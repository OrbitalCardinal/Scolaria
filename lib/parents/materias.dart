
import 'package:Scolaria/widgets/loginBackground.dart';
import 'package:flutter/material.dart';

class Materias extends StatelessWidget {
  //final String loggedEmail;
  //Materias(this.loggedEmail);
  //static List<Loan> tempLoans = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Correo: cesarhdzh18@gmail.com",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                RaisedButton(
                  child: Text("Cerrar sesión"),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(LoginBackground.routeName);
                  },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}