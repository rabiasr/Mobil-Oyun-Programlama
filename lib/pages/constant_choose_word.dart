import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:wordle/wordle/containers/keyboard_constant.dart';

import 'package:wordle/wordle/provider/altiharf.dart';
import 'package:wordle/wordle/provider/besharf.dart';
import 'package:wordle/wordle/provider/row_provider.dart';
import 'package:wordle/wordle/provider/wordle_game.dart.dart';

class ConstantChooseWord extends StatefulWidget {
  const ConstantChooseWord({super.key, required this.tur, required this.kanal, required this.uid});

  final String tur;
  final String kanal;
  final String uid;
  @override
  State<ConstantChooseWord> createState() => _ConstantChooseWordState();
}

class _ConstantChooseWordState extends State<ConstantChooseWord> {
  var _kelime;
  var _hata = "";

  BesHarf besHarf = BesHarf();
  AltiHarf altiHarf = AltiHarf();

  WordleGame _game = WordleGame(0);
  RowProvider _rowp = RowProvider(0);
  late String word;
  @override
  /* void initState() {
    // TODO: implement initState
    super.initState();
    WordleGame.initGame();
  }*/

  @override
  void initState() {
    super.initState();
    if (widget.kanal == "besharf") {
      _game = WordleGame(5);
      _rowp = RowProvider(5);
      RowProvider.harfSayisi = 5;
      _game.listeEkle("besharf");
    } else if (widget.kanal == "altiharf") {
      _game = WordleGame(6);
      _rowp = RowProvider(6);
      RowProvider.harfSayisi = 6;
      _game.listeEkle("altiharf");
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardConstant(
      game: _game,
      sayi: RowProvider.harfSayisi,
      rowProvider: _rowp, uid: widget.uid,
    );
  }
}
