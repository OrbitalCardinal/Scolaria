import 'package:flutter/material.dart';

class AccountLogin extends StatelessWidget {
  const AccountLogin({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "¿Ya tienes una cuenta?",
          style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: "Alatsi"),
        ),
        GestureDetector(
          child: Text(
            " Inicia sesión",
            style: TextStyle(fontSize: 18, color: Colors.deepOrange[400], fontFamily: "Alatsi"),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
