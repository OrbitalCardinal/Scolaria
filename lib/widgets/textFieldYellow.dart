import 'package:flutter/material.dart';

class TextFieldYellow extends StatelessWidget {
  final String labelText;
  final Icon prefixIcon;
  final bool pass;
  TextFieldYellow({this.labelText, this.prefixIcon, this.pass});
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Alatsi"),
      obscureText: pass ? true : false,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
           borderSide: BorderSide(color: Colors.cyan[300]),
           borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          filled: true,
          fillColor: Colors.grey[600],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          prefixIcon: prefixIcon,
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
