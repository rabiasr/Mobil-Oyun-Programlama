import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wordle/pages/choose_letter.dart';
import 'package:wordle/widgets/card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class GameTypePage extends StatefulWidget {
  const GameTypePage({super.key});

  @override
  State<GameTypePage> createState() => _GameTypePageState();
}

class _GameTypePageState extends State<GameTypePage> {
  @override
  Widget build(BuildContext context) {
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
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ], 
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 40),
        child: Center(
          child: Column(
            children: [
              const Text(
                "Oyun Türünü Seçiniz",
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
                  CardWidget(
                    kelime: "Harf Sabitli Oyun",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                (const ChooseLetter(tur : 'sabit')), // Hedef sayfaya yönlendirme
                            ),// Hedef sayfaya yönlendirme
                          );
                    },
                  ),
                  CardWidget(kelime: "Harf Sabitsiz Oyun", onPressed: () { Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                (const ChooseLetter(tur : 'rastgele')), // Hedef sayfaya yönlendirme
                          ));}),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
