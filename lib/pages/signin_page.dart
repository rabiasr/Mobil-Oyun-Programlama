import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  var _email = "";
  var _password = "";
  var _hata = "";
  var _ad="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kayıt Sayfası"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_hata.isNotEmpty)
              Text(
                "Bir hata oluştu: $_hata",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            TextField(
              decoration: const InputDecoration(hintText: "Email adresini gir"),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                _email = value;
                if (_hata.isNotEmpty) {
                  _hata = "";
                  setState(() {});
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: const InputDecoration(hintText: "Şifreni gir"),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onChanged: (value) {
                _password = value;
                if (_hata.isNotEmpty) {
                  _hata = "";
                  setState(() {});
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
                 TextField(
              decoration: const InputDecoration(hintText: "Kullanıcı Adı Giriniz"),
              keyboardType: TextInputType.name,
              onChanged: (value) {
                _ad = value;
                if (_hata.isNotEmpty) {
                  _hata = "";
                  setState(() {});
                }
              },
            ),
            TextButton(
              onPressed: () {
                final regexp = RegExp(
                    r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]{2,}$");
                final eslesme = regexp.hasMatch(_email) && _password.length > 5;

                if (eslesme) {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: _email,
                    password: _password,
                  )
                      .catchError(
                    (error) {
                      _hata = error
                          .toString(); //error tiplerine göre ayrılabilir kodlar var firebase dökümanında
                      setState(
                        () {},
                      );
                    },
                  ).then((value) async {
                    final uid = value.user?.uid;
                    final user = {
                      'email': _email,
                      'point':0,
                      'kelime':"",
                      'durum':"aktif",
                      'ad':_ad,

                    };
                    if (uid == null) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .add(user);
                    } else {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .set(user);
//yeni belge oluşturur update sadece ilgili kısımı günceller döküman varsa!!!!
                    }
                    if (mounted) Navigator.of(context).pop();
                  });
                } else {
                  _hata = "Email adresi veya Şifre geçersiz";
                  setState(() {});
                }
              },
              child: const Text("Kayıt Yap"),
            ),
          ],
        ),
      ),
    );
  }
}
