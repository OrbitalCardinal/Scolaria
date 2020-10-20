import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'DividerAuth.dart';
import '../facebookCircularButton.dart';
import '../googleCircularButton.dart';
import 'homePage.dart';
import 'noAccountRegister.dart';
import 'textLogo.dart';

class LoginBody extends StatefulWidget {
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width - size.width / 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextLogo(),
                SizedBox(height: size.height / 25),
                TextField(
                  controller: emailController,
                  style: TextStyle(color: Colors.orange[500], fontSize: 18, fontFamily: "Alatsi"),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange[100]),
                      borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange[100]),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      filled: true,
                      fillColor: Colors.orange[100],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      prefixIcon: Icon(Icons.person, color: Colors.orange[500],),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.orange[500], fontSize: 20)),
                ),
                SizedBox(height: size.height / 40),
                TextField(
                  controller: passController,
                  style: TextStyle(color: Colors.orange[500], fontSize: 18, fontFamily: "Alatsi"),
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange[100]),
                      borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange[100]),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      filled: true,
                      fillColor: Colors.orange[100],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      prefixIcon: Icon(Icons.vpn_key, color: Colors.orange[500],),
                      labelText: "Contraseña",
                      labelStyle: TextStyle(color: Colors.orange[500], fontSize: 20, fontFamily: "Alatsi")),
                ),
                SizedBox(height: size.height / 25),
                Container(
                  height: size.height / 13,
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text(
                      "Iniciar sesión",
                      style: TextStyle(fontSize: 19, color: Colors.white),
                    ),
                    color: Colors.deepOrange[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    onPressed: () async {
                      try {
                        await _auth
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passController.text)
                            .then((user) {
                          if (user.user.emailVerified) {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_LoginBodyState) {
                              return HomePage(emailController.text);
                            }));
                          } else {
                            print("Verifique su correo por favor");
                          }
                        });
                      } catch (err) {
                        print("Error: " + err.toString());
                      }
                    },
                  ),
                ),
                SizedBox(height: size.height / 45),
                GestureDetector(
                  child: Text(
                    "¿Olvidate tu contraseña?",
                    style: TextStyle(fontSize: 18, color: Colors.deepOrange[400], fontFamily: "Alatsi"),
                  ),
                  onTap: () {
                    print("Olvidaste tu contrasena");
                  },
                ),
                SizedBox(height: size.height / 20),
              ],
            ),
          ),
          Container(
            width: size.width - size.width / 10,
            child: Column(
              children: [
                DividerAuth("  O también inicia sesión con:  "),
                SizedBox(height: size.height / 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FacebookCircularButton(),
                    GoogleCircularButton(),
                  ],
                ),
                SizedBox(height: size.height / 50),
                NoAccountRegister(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
