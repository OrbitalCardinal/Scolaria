import 'package:Scolaria/parents/loanScreen.dart';
import 'package:Scolaria/parents/models/student.dart';
import 'package:Scolaria/parents/newStudent.dart';
import 'package:Scolaria/parents/seleccionAlumno.dart';
import 'package:Scolaria/parents/studentScreen.dart';
//import 'package:Scolaria/parents/seleccionAlumno.dart';
import 'package:Scolaria/teachers/student_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class students extends StatelessWidget{
  static const routeName = 'addStudent';
  static List<Student> tempStud = [];

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,

        body: TabBarView(children: [
          seleccionAlumno(),
          //LoanScreen(),

        ]),
      ),
    );
  }
}