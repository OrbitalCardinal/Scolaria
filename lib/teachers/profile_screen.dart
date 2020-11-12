import 'package:Scolaria/teachers/main_teachers_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child:
          Text(MainTeachersScreen.userId, style: TextStyle(fontSize: 20, color: Colors.black)),
    ));
  }
}
