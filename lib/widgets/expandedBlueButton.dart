import 'package:flutter/material.dart';

class ExpandedBlueButton extends StatelessWidget {
  final bool login;
  ExpandedBlueButton({this.login});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 13,
      width: double.infinity,
      child: RaisedButton(
        child: Text(
          login ? "Iniciar sesión" : "Registrate",
          style: TextStyle(fontSize: 19, color: Colors.white),
        ),
        color: Colors.blue[500],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        onPressed: () {
          print("Iniciar Sesión");
        },
      ),
    );
  }
}