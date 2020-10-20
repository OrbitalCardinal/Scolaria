import 'package:flutter/material.dart';

import 'registerBody.dart';

class NoAccountRegister extends StatelessWidget {
  const NoAccountRegister({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "¿No tienes una cuenta?",
          style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: "Alatsi"),
        ),
        GestureDetector(
          child: Text(
            " Registrate",
            style: TextStyle(fontSize: 18, color: Colors.deepOrange[400], fontFamily: "Alatsi"),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return RegisterBody();
            }));
          },
        ),
      ],
    );
  }
}
