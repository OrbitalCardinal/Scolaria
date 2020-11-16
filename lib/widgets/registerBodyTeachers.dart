import 'package:Scolaria/widgets/loginBackgroundTeachers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'textLogo.dart';

class RegisterBodyTeachers extends StatefulWidget {
  static const routeName = '/register-teachers';
  @override
  _RegisterBodyTeachersState createState() => _RegisterBodyTeachersState();
}

class _RegisterBodyTeachersState extends State<RegisterBodyTeachers> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confpassController = TextEditingController();
  final _nameController = TextEditingController();
  final databaseReference = FirebaseFirestore.instance;

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
              Text(
                "Maestros",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepOrange[400],
                    fontFamily: "Alatsi"),
              ),
              TextField(
                controller: _emailController,
                style: TextStyle(
                    color: Colors.orange[400],
                    fontSize: 18,
                    fontFamily: "Alatsi"),
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
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.orange,
                    ),
                    labelText: "Email",
                    labelStyle:
                        TextStyle(color: Colors.orange[400], fontSize: 18)),
              ),
              TextField(
                controller: _nameController,
                style: TextStyle(
                    color: Colors.orange[400],
                    fontSize: 18,
                    fontFamily: "Alatsi"),
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
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.orange,
                    ),
                    labelText: "Nombre Completo",
                    labelStyle:
                        TextStyle(color: Colors.orange[400], fontSize: 18)),
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
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Colors.orange[400],
                    ),
                    labelText: "Contraseña",
                    labelStyle:
                        TextStyle(color: Colors.orange[400], fontSize: 20)),
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
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Colors.orange[400],
                    ),
                    labelText: "Confirmar contraseña",
                    labelStyle:
                        TextStyle(color: Colors.orange[400], fontSize: 20)),
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
                        await _auth
                            .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passController.text)
                            .then((user) async {
                          try {
                            _auth.currentUser.sendEmailVerification();
                            await databaseReference
                                .collection('User')
                                .doc()
                                .set({
                              'id': user.user.uid,
                              'userName': _nameController.text,
                              'teacher': true,
                              'email': _emailController.text
                            }).then((value) => Navigator.of(context)
                                    .pushReplacementNamed(
                                        LoginBackgroundTeachers.routeName));
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿Ya tienes una cuenta?",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: "Alatsi"),
                  ),
                  GestureDetector(
                    child: Text(
                      " Inicia sesión",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.deepOrange[400],
                          fontFamily: "Alatsi"),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                          LoginBackgroundTeachers.routeName);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
