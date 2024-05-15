import 'dart:math';

import 'package:flutter/src/widgets/container.dart';
import 'package:wordle/wordle/provider/altiharf.dart';
import 'package:wordle/wordle/provider/besharf.dart';

class RowProvider {
  int harfid = 0;
  static late int harfSayisi;
  static String game_message="";
  static String game_guess = "";
  static late List<String> word_list;
  static List<String> alphabet = [
  "A", "B", "C", "Ç", "D", "E", "F", "G", "H", "I", "İ", "K", "L", 
  "M", "N", "O", "Ö", "P", "R", "S", "Ş", "T", "U", "Ü", "V", 
  "Y", "Z"
];

 
  static late List<Letter> satirWordle;
  static late List<Letter> constsatir;
 static int indis=0;
  
  //Constructor
  RowProvider(int sayi) {
    if (sayi == 5) {
      word_list = BesHarf.list;
    } else if (sayi == 6) {
      word_list = AltiHarf.list;
    }

    harfSayisi = sayi;

    satirWordle = List.generate(
      sayi,
      (index) => Letter("", 0),
    );
 
  constsatir = List.generate(
      sayi,
      (index) => Letter("", 0),
    );
     
  }

  //Initialize the game
   void initGame() {
    final random = Random();
    int index = random.nextInt(alphabet.length);
    game_guess = alphabet[index].toUpperCase();
   indis=random.nextInt(harfSayisi+1);
    constsatir[indis] = Letter(game_guess, 0);

  }

  //Setting the game insertion
  void insertWord(index, word) {
    satirWordle[index] = word;
  }

  //checking word existence
  bool checkWordExist(String word) {
    return word_list.contains(word);
  }
}

class Letter {
  String? letter;
  int code = 0;

  Letter(this.letter, this.code);

  map(Container Function(dynamic e) param0) {}
}
