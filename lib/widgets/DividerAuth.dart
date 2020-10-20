import 'package:flutter/material.dart';

class DividerAuth extends StatelessWidget {
  final String dividerText;

  DividerAuth(this.dividerText);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1.5,
            color: Colors.teal[300],
          ),
        ),
        Text(dividerText,
            style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Alatsi")),
        Expanded(
          child: Divider(
            thickness: 1.5,
            color: Colors.teal[300],
          ),
        ),
      ],
    );
  }
}
