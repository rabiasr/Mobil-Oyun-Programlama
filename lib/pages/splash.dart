
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'game_type_page.dart';
import 'login_page.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

 @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
          final login=snapshot.hasData && snapshot.data!=null;
        return 
        MaterialApp(
          debugShowCheckedModeBanner: false,
           home: login ? const GameTypePage() : const LoginPage(), 
           // home: LoginPage(),
        );
      }
    );
  }
 

 




}
