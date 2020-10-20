import 'package:flutter/material.dart';

class TextLogo extends StatelessWidget {
  const TextLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Scolaria",
      style: TextStyle(
        color: Colors.teal[300],
        fontFamily: 'Viga',
        fontSize: 45,
      ),
    );
  }
}