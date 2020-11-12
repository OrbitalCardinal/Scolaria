import 'dart:math';

import 'package:Scolaria/teachers/main_teachers_screen.dart';
import 'package:Scolaria/widgets/loginBackground.dart';
import 'package:Scolaria/widgets/registerBodyTeachers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'DividerAuth.dart';
import '../facebookCircularButton.dart';
import '../googleCircularButton.dart';
import 'homePage.dart';
import 'noAccountRegister.dart';
import 'textLogo.dart';

class LoginBodyTeachers extends StatefulWidget {
  @override
  _LoginBodyTeachersState createState() => _LoginBodyTeachersState();
}

class _LoginBodyTeachersState extends State<LoginBodyTeachers> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseFirestore.instance;

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
                Text(
                  "Maestros",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepOrange[400],
                      fontFamily: "Alatsi"),
                ),
                SizedBox(height: size.height / 25),
                TextField(
                  controller: emailController,
                  style: TextStyle(
                      color: Colors.orange[500],
                      fontSize: 18,
                      fontFamily: "Alatsi"),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[100]),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange[100]),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      filled: true,
                      fillColor: Colors.orange[100],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.orange[500],
                      ),
                      labelText: "Email",
                      labelStyle:
                          TextStyle(color: Colors.orange[500], fontSize: 20)),
                ),
                SizedBox(height: size.height / 40),
                TextField(
                  controller: passController,
                  style: TextStyle(
                      color: Colors.orange[500],
                      fontSize: 18,
                      fontFamily: "Alatsi"),
                  obscureText: true,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange[100]),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange[100]),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      filled: true,
                      fillColor: Colors.orange[100],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.orange[500],
                      ),
                      labelText: "Contraseña",
                      labelStyle: TextStyle(
                          color: Colors.orange[500],
                          fontSize: 20,
                          fontFamily: "Alatsi")),
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
                            .then((user) async {
                          if (user.user.emailVerified) {
                            // Check if it's teacher
                            await databaseReference.collection("User").get().then((QuerySnapshot snapshot) {
                              var document = snapshot.docs.where((element) => element["id"] == user.user.uid);
                              bool isTeacher = document.first.data()['teacher'];
                              String userId = document.first.data()['id'];
                              if(isTeacher) {
                                Navigator.of(context).pushReplacementNamed(MainTeachersScreen.routeName, arguments: {
                                  'userId': userId 
                                });
                              } else {
                                showDialog(context: context, child: AlertDialog(
                                  content: Text("Esta intentando ingresar con una cuenta que no es de docente"),
                                  actions: [
                                    FlatButton(onPressed: () {
                                      Navigator.of(context).pop();
                                    }, child: Text("Ok"))
                                  ],
                                ));
                              }
                            });
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
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.deepOrange[400],
                        fontFamily: "Alatsi"),
                  ),
                  onTap: () {
                    print("Olvidaste tu contrasena");
                  },
                ),
                SizedBox(height: size.height / 20),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "¿No tienes una cuenta?",
                style: TextStyle(
                    fontSize: 18, color: Colors.black, fontFamily: "Alatsi"),
              ),
              GestureDetector(
                child: Text(
                  " Registrate",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepOrange[400],
                      fontFamily: "Alatsi"),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(RegisterBodyTeachers.routeName);
                },
              ),
            ],
          ),
          SizedBox(height: size.height / 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "¿No eres docente?",
                style: TextStyle(
                    fontSize: 18, color: Colors.black, fontFamily: "Alatsi"),
              ),
              GestureDetector(
                child: Text(
                  " Inicia sesión como padre",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepOrange[400],
                      fontFamily: "Alatsi"),
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, LoginBackground.routeName);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
