import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../facebookCircularButton.dart';
import '../googleCircularButton.dart';
import 'DividerAuth.dart';
import 'accountLogIn.dart';
import 'textLogo.dart';

class RegisterBody extends StatefulWidget {
  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confpassController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 70, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextLogo(),
              TextField(
                controller: _emailController,
                style: TextStyle(color: Colors.orange[400], fontSize: 18, fontFamily: "Alatsi"),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange[100]),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange[100]),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    filled: true,
                    fillColor: Colors.orange[100],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    prefixIcon: Icon(Icons.person, color: Colors.orange,),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.orange[400], fontSize: 18)),
              ),
              TextField(
                controller: _passController,
                style: TextStyle(color: Colors.orange[400], fontSize: 18),
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange[100]),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange[100]),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    filled: true,
                    fillColor: Colors.orange[100],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    prefixIcon: Icon(Icons.vpn_key, color: Colors.orange[400],),
                    labelText: "Contraseña",
                    labelStyle: TextStyle(color: Colors.orange[400], fontSize: 20)),
              ),
              TextField(
                controller: _confpassController,
                style: TextStyle(color: Colors.orange[400], fontSize: 18),
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange[100]),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange[100]),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    filled: true,
                    fillColor: Colors.orange[100],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    prefixIcon: Icon(Icons.vpn_key, color: Colors.orange[400],),
                    labelText: "Confirmar contraseña",
                    labelStyle: TextStyle(color: Colors.orange[400], fontSize: 20)),
              ),
              Container(
                height: size.height / 13,
                width: double.infinity,
                child: RaisedButton(
                  child: Text(
                    "Registrate",
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                  color: Colors.deepOrange[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  onPressed: () async {
                    try {
                      if (_confpassController.text == _passController.text) {
                        await  _auth.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passController.text).then((user) {
                              try {
                                _auth.currentUser.sendEmailVerification();
                                Navigator.pop(context);
                              } catch (e) {
                                print(e);
                              }
                              
                            });
                      } else {
                        print("Contraseñas no coinciden");
                      }
                    } catch (err) {
                      print(err);
                    }
                  },
                ),
              ),
              DividerAuth('  O también registrate con:  '),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GoogleCircularButton(),
                  FacebookCircularButton(),
                ],
              ),
              AccountLogin()
            ],
          ),
        ),
      ),
    );
  }
}
