import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wordle/firebase_options.dart';

import 'package:wordle/pages/game_type_page.dart';
import 'package:wordle/pages/login_page.dart';
import 'package:wordle/pages/splash.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Web Scraping',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const Splash(),
    );
    
  }
}
