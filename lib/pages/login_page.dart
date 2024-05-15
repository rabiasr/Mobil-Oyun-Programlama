import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wordle/pages/signin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _email = "";
  var _password = "";
  var _hata="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giriş Sayfası"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(_hata.isNotEmpty)
              Text("Bir hata oluştu: $_hata",style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            TextField(
              decoration: InputDecoration(hintText: "Email adresini gir"),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _email = value;
                if(_hata.isNotEmpty){
                  _hata="";
                  setState(() {
                    
                  });
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Şifreni gir"),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onChanged: (value) {
                _password = value;
                   if(_hata.isNotEmpty){
                  _hata="";
                  setState(() {
                    
                  });
                }
              },
            ),
           const  SizedBox(height: 30,),
            TextButton(
              onPressed: () {
                final regexp=RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]{2,}$");
                final eslesme=regexp.hasMatch(_email) && _password.length>5;

                if (eslesme) {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _email,
                    password: _password,
                  ).catchError((error){
                    _hata=error.toString();//error tiplerine göre ayrılabilir kodlar var firebase dökümanında 
                    setState(() {
                    });
                    });
                }
                else {
                  _hata="Email adresi veya Şifre geçersiz";
                  setState(() {
                    
                  });
                }
              },
              child: const Text("Giriş Yap"),
              ),
            const Divider(height: 60,),
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                return const SigninPage();
              }),);
            }, child: const Text("Kayıt Ol"))

          ],
        ),
      ),
    );
  }
}
