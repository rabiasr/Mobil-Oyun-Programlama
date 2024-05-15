import 'package:flutter/material.dart';
import 'package:wordle/wordle/containers/board.dart';
import 'package:wordle/wordle/provider/wordle_game.dart.dart';


class Keyboard extends StatefulWidget {
  Keyboard( {Key? key, required this.game, required this.uid}) : super(key: key);
   WordleGame game;
   final String uid;
  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  List satir1 = "QWERTYUIOPĞÜ".split("");
  List satir2 = "ASDFGHJKLŞİ".split("");
  List satir3 = ["SİL", "Z", "X", "C", "V", "B", "N", "M", "Ö","Ç", "GÖNDER"];

  @override
  Widget build(BuildContext context){
  
   setState(() {
     widget.game.kelimeAl(widget.uid);
   });
    return Scaffold(
      body: Column(
        children: [
         
          const SizedBox(
            height: 120.0,
          ),Text(
            WordleGame.game_message,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ), const  SizedBox(
            height:20.0,
          ),
          Board(widget.game),
         const  SizedBox(
            height:20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: satir1.map((e) {
              return InkWell(
                onTap: () {
                  setState(() {
                        WordleGame.game_message = "";
                  });
               print(e);
                  if (widget.game.harfid <WordleGame.harfSayisi) {
                    print(widget.game.satirid);
                    widget.game.insertWord(widget.game.harfid, Letter(e, 0));
                    widget.game.harfid++;
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
                   setState(() {
                        WordleGame.game_message = "";
                  });
                  print(e);
                  if (widget.game.harfid < WordleGame.harfSayisi) {
                    print(widget.game.satirid);
                    widget.game.insertWord(widget.game.harfid, Letter(e, 0));
                    widget.game.harfid++;
                    setState(() {});
                  }
                },
                child: Container(
                  padding:const  EdgeInsets.all(10.0),
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
         const  SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: satir3.map((e) {
              return InkWell(
                onTap: () {

                   setState(() {
                        WordleGame.game_message = "";
                  });
                  print(e);
      
                  if (e == "SİL") {
                    if (widget.game.harfid > 0) {
                      setState(() {
                        widget.game
                            .insertWord(widget.game.harfid - 1, Letter("", 0));
                        widget.game.harfid--;
                      });
                    }
                  } else if (e == "GÖNDER") {
                    // setting the game rules
                    print("dpgruuuu: ${WordleGame.game_guess}");
                    if (widget.game.harfid >= WordleGame.harfSayisi) {
                      /*WordleGame.boardWordle[widget.game.satirid].replaceRange(
                        0,
                        WordleGame.harfSayisi,
                        List.generate(WordleGame.harfSayisi, (index) => Letter("", 1)),
                      ); */
                      String guess = WordleGame.boardWordle[widget.game.satirid]
                          .map((e) => e.letter)
                          .join();
                      print(guess);
                      print("fdenemeeÇ:"+WordleGame.game_guess == guess);
                      if (widget.game.checkWordExist(guess)) {
                        print("girdiii");
                        if (guess == WordleGame.game_guess) {
                          setState(() {
                            WordleGame.game_message = "Congratulations🎉";
                            WordleGame.boardWordle[widget.game.satirid]
                                .forEach((element) {
                              element.code = 1;
                            });
                          });
                        } else {
                          print(" dfsfsf "+WordleGame.game_guess);
                          int listLength = guess.length;
                          for (int i = 0; i < listLength; i++) {
                            String char = guess[i].toUpperCase();
                            print(
                                "the test: ${WordleGame.game_guess.contains(char)}");
                            if (WordleGame.game_guess.contains(char)) {
                              if (WordleGame.game_guess[i] == char) {
                                setState(() {
                                  print(char);
                                 WordleGame.boardWordle[widget.game.satirid][i]
                                      .code = 1;
                                });
                              } else {
                                setState(() {
                                  print(char);
                                  WordleGame.boardWordle[widget.game.satirid][i]
                                      .code = 2;
                                });
                              }
                            }
                          }
                          widget.game.satirid++;
                          widget.game.harfid = 0;
                        }
                      } else {
                       setState(() {
                          WordleGame.game_message =
                            "the world does not exist try again";
                       });
                      }
                    }
                  } else {
                    if (widget.game.harfid < WordleGame.harfSayisi) {
                      print(widget.game.satirid);
                      widget.game.insertWord(widget.game.harfid, Letter(e, 0));
                      widget.game.harfid++;
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