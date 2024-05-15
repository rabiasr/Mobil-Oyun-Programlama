import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wordle/cubits/channel_cubit.dart';
import 'package:wordle/pages/channel.dart';
import 'package:wordle/widgets/card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseLetter extends StatefulWidget {
  const ChooseLetter({
    Key? key,
    required this.tur,
    //required this.kanal,
  }) : super(key: key);

  final String tur;
  //final  String kanal;

  @override
  State<ChooseLetter> createState() => _ChooseLetterState();
}

class _ChooseLetterState extends State<ChooseLetter> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
      

    return 
    Scaffold(
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
       /* actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],*/
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 50),
        child: Center(
          child: Column(
            children: [
              const Text(
                "Harf Sayısını Seçiniz",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold, // Sabit kısmı kalın yapar
                ),
              ),
              const Divider(
                height: 10,
              ),
              Row(
                children: [
                  Material(
                    // Material widget eklendi
                    child: CardWidget(
                      kelime: "5 Harfli Oyun",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (_) =>
                                  ChannelCubit(widget.tur, 'besharf'),
                              child: Channel(tur: widget.tur, kanal: 'besharf'),
                            ),
                          ),
                        ) ;
                      },
                    ),
                  ),
                  Material(
                    // Material widget eklendi
                    child: CardWidget(
                      kelime: "6 Harfli Oyun",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (_) =>
                                  ChannelCubit(widget.tur, 'altiharf'),
                              child: Channel(tur: widget.tur, kanal: 'altiharf'),
                            ),
                          ),
                        ) ;
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
