import 'package:flutter/material.dart';
import 'package:wordle/wordle/provider/row_provider.dart';
import 'package:wordle/wordle/provider/wordle_game.dart.dart';


class RowConstant extends StatefulWidget {
  RowConstant({Key? key, required this.sayi}) : super(key: key);
final int sayi;
 
  @override
  State<RowConstant> createState() => _RowConstantState();
}

class _RowConstantState extends State<RowConstant> {
      RowProvider rowProvider=RowProvider(0);
     
@override
void initState() {
   
rowProvider=RowProvider(widget.sayi);
 
  rowProvider.initGame();
}

  @override
  Widget build(BuildContext context) {
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: RowProvider.constsatir
                    .map((e) => 
                    Container(
                          padding:const EdgeInsets.all(8.0),
                          width: 50.0,
                          height: 50.0,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: e.code == 0
                                ? Colors.grey.shade800
                                : e.code == 1
                                    ? Colors.green.shade400
                                    : Colors.amber.shade400,
                          ),
                          child: Center(
                              child: Text(
                            e.letter!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ))
                    .toList(),
              );
  }
}