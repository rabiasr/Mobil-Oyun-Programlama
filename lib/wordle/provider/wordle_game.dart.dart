import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:wordle/models/user_model.dart';
import 'package:wordle/wordle/provider/altiharf.dart';
import 'package:wordle/wordle/provider/besharf.dart';

class WordleGame {
  //setting the game variables
  int satirid = 0;
  int harfid = 0;
  static late int harfSayisi;
  static String game_message = "";
  static String game_guess = "";
  static late List<String> word_list;
  static bool bitti = false;

  //Setting the game row and board
  static late List<Letter> satirWordle;
  static late List<List<Letter>> boardWordle;

  void listeEkle(String sayi) {
    if (sayi == "besharf") {
      word_list = BesHarf.list;
    } else if (sayi == "altiharf") {
      word_list = AltiHarf.list;
    }
  }

  //Constructor
  WordleGame(int sayi) {
    harfSayisi = sayi;
    print("sayi: $harfSayisi");
    // Initialize satirWordle
    satirWordle = List.generate(
      sayi,
      (index) => Letter("", 0),
    );

    // Initialize boardWordle
    boardWordle = List.generate(
      sayi,
      (index) => List.generate(
        harfSayisi,
        (index) => Letter("", 0),
      ),
    );
  }

  //Setting the Game Functon
  void altsatirGec() {
    satirid++;
    harfid = 0;
  }

  //Initialize the game
  /* static void initGame() {
    final random = Random();
    int index = random.nextInt(word_list.length);
    game_guess = word_list[index].toUpperCase();
  }*/

  //Setting the game insertion
  void insertWord(index, word) {
    boardWordle[satirid][index] = word;
  }

  //checking word existence
  bool checkWordExist(String word) {
    return word_list.contains(word);
  }

  Future<String?> kelimeAl(String uid) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (snapshot.exists) {
      final urun = UserModel.fromFirestore(snapshot.data() ?? {}, snapshot.id);
      
      game_guess=urun.kelime;
      return urun.kelime;
    }
    return null;
  }
}

class Letter {
  String? letter;
  int code = 0;

  Letter(this.letter, this.code);

  map(Container Function(dynamic e) param0) {}
}
