import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String loggedEmail;
  HomePage(this.loggedEmail);
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
                Text(
                  "Correo: " + loggedEmail,
                  style: TextStyle(fontSize: 20),
                ),
                RaisedButton(
                  child: Text("Cerrar sesión"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
