import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wordle/wordle/containers/keyboard.dart';
import 'package:wordle/wordle/containers/row.dart';
import 'package:wordle/wordle/containers/row_constant.dart';
import 'package:wordle/wordle/provider/row_provider.dart' as RP;
import 'package:wordle/wordle/provider/wordle_game.dart.dart';

class KeyboardConstant extends StatefulWidget {
  const KeyboardConstant(
      {super.key,
      required this.sayi,
      required this.rowProvider,
      required this.game, required this.uid});
  final int sayi;
  final RP.RowProvider rowProvider;
  final WordleGame game;
  final String uid;
  @override
  State<KeyboardConstant> createState() => _KeyboardConstantState();
}

class _KeyboardConstantState extends State<KeyboardConstant> {
  List satir1 = "QWERTYUIOPĞÜ".split("");
  List satir2 = "ASDFGHJKLŞİ".split("");
  List satir3 = ["SİL", "Z", "X", "C", "V", "B", "N", "M", "Ö", "Ç", "GÖNDER"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100.0,
          ),
          Text(
            RP.RowProvider.game_message,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 100.0,
          ),
          const Text(
            "Kelimeyi aşağıdaki gibi giriniz",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          RowConstant(sayi: widget.sayi),
          const SizedBox(
            height: 15.0,
          ),
          RowChoose(
            sayi: widget.sayi,
          ),
          const SizedBox(
            height: 250.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: satir1.map((e) {
              return InkWell(
                onTap: () {
                  print(e);
                  if (widget.rowProvider.harfid < widget.sayi) {
                    widget.rowProvider
                        .insertWord(widget.rowProvider.harfid, RP.Letter(e, 0));
                    widget.rowProvider.harfid++;
                    setState(() {});
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.shade300,
                  ),
                  child: Text(
                    "${e}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: satir2.map((e) {
              return InkWell(
                onTap: () {
                  print(e);
                  if (widget.rowProvider.harfid < widget.sayi) {
                    widget.rowProvider
                        .insertWord(widget.rowProvider.harfid, RP.Letter(e, 0));
                    widget.rowProvider.harfid++;
                    setState(() {});
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.shade300,
                  ),
                  child: Text(
                    "${e}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: satir3.map((e) {
              return InkWell(
                onTap: () async {
                  print(e);
                  setState(() {
                    RP.RowProvider.game_message =
                        "";
                  });
                  if (e == "SİL") {
                    if (widget.rowProvider.harfid > 0) {
                      setState(() {
                        widget.rowProvider.insertWord(
                            widget.rowProvider.harfid - 1, RP.Letter("", 0));
                        widget.rowProvider.harfid--;
                      });
                    }
                  } else if (e == "GÖNDER") {
                    if (widget.rowProvider.harfid >= widget.sayi) {
                      String birlesmisKelime = RP.RowProvider.satirWordle
                          .map((letter) => letter.letter!)
                          .join();
                      print(birlesmisKelime);

                      if (widget.rowProvider.checkWordExist(birlesmisKelime)) {
                           
                       /* setState(() {
                          final user = FirebaseAuth.instance.currentUser!;

                         FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .update({'kelime': birlesmisKelime}).then((_) {
                              widget.game.kelimeAl(widget.uid);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Keyboard(game: widget.game),
                              ));
                            });
                          
                        });
                    */
                        String istenenHarf = RP.RowProvider
                            .satirWordle[RP.RowProvider.indis].letter!;
                        if (istenenHarf == RP.RowProvider.game_guess) {
                          setState(() {
                           final user = FirebaseAuth.instance.currentUser!;

                         FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .update({'kelime': birlesmisKelime}).then((_) {
                              //widget.game.kelimeAl(widget.uid);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Keyboard(game: widget.game, uid: widget.uid,),
                              ));
                            });
                          });
                        } else {
                          setState(() {
                            RP.RowProvider.game_message =
                                "Lütfen Geçerli Bir Kelime Girin";
                          });
                        }
                      } else {
                        setState(() {
                          RP.RowProvider.game_message =
                              "Lütfen Geçerli Bir Kelime Girin";
                        });
                      }
                    }
                  } else {
                    if (widget.rowProvider.harfid < RP.RowProvider.harfSayisi) {
                      widget.rowProvider.insertWord(
                          widget.rowProvider.harfid, RP.Letter(e, 0));
                      widget.rowProvider.harfid++;
                      setState(() {});
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.shade300,
                  ),
                  child: Text(
                    "${e}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
