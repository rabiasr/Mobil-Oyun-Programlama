import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordle/cubits/channel_cubit.dart';
import 'package:wordle/models/user_model.dart';
import 'package:wordle/pages/choose_word.dart';
import 'package:wordle/pages/constant_choose_word.dart';
import 'package:wordle/widgets/channel_card.dart';

class Channel extends StatefulWidget {
  const Channel({super.key, required this.tur, required this.kanal});

  final String tur;
  final String kanal;

  @override
  State<Channel> createState() => _ChannelState();
}

class _ChannelState extends State<Channel> {
  late bool flag = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      flag = false;
    });
   final user = FirebaseAuth.instance.currentUser!;
    context.read<ChannelCubit>().channelEkleCikar(user.uid).then((_) {
      setState(() {
        flag = true;
      });
    });
  }
 
  @override
  Widget build(BuildContext context) {
 
   final user = FirebaseAuth.instance.currentUser!;

    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);



    return flag
        ? BlocBuilder<ChannelCubit, List<String>>(
            builder: (_, channel) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color.fromARGB(255, 83, 25, 120),
                  title: const Text(
                    "Wordle",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Builder(
                    builder: (BuildContext context) {
                      return const Icon(
                        Icons.wordpress_outlined,
                        color: Colors.white,
                      );
                    },
                  ),
                  centerTitle: false,
                  actions: [
                    IconButton(
                      onPressed: () {
                        final user = FirebaseAuth.instance.currentUser!;

                        context
                            .read<ChannelCubit>()
                            .channelEkleCikar(user.uid)
                            .then((_) {
                          setState(() {
                            flag = true;
                          });
                        });
                      },
                      icon: const Icon(Icons.logout),
                    )
                  ],
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 650, // ListView'un yüksekliğini sınırla
                          child: ListView(
                            children: [
                              for (final uid in channel)
                                FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(uid)
                                      .get(),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      final urun = UserModel.fromFirestore(
                                        snapshot.data?.data() ?? {},
                                        snapshot.data!.id,
                                      );
                                      for (int i = 0; i < channel.length; i++) {
                                        return ChannelCard(
                                          ad: urun.ad,
                                          durum: urun.durum,
                                          onPressed: () {
                                            if(urun.uid!=user.uid){
                                                 widget.tur == "rastgele"
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChooseWord(
                                                              tur: widget.tur,
                                                              kanal:
                                                                  widget.kanal, uid: urun.uid),
                                                    ))
                                                : Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ConstantChooseWord(
                                                              tur: widget.tur,
                                                              kanal:
                                                                  widget.kanal, uid: urun.uid,),
                                                    ));
                                            }
                                         
                                          },
                                        );
                                      }
                                    }
                                    return const LinearProgressIndicator();
                                  },
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : const CircularProgressIndicator();
  }
}
