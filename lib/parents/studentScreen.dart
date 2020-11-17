import 'dart:math';
import 'package:Scolaria/parents/addStudent.dart';
import 'package:Scolaria/parents/models/student.dart';
import 'package:Scolaria/parents/newStudent.dart';
import 'package:Scolaria/parents/studentCard.dart';
import 'package:Scolaria/teachers/student_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class studentScreen extends StatefulWidget{
  static const routeName = 'studentScreen';

  @override
  _studentScreenState createState() => _studentScreenState();
}

class _studentScreenState extends State<studentScreen> {
  final databaseRef = FirebaseFirestore.instance;

  void _startAddNewStudent(BuildContext context){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_){
        return GestureDetector(
          child: NewStudent(addStudent),
          onTap: (){},
          behavior: HitTestBehavior.opaque,
        );
      }
    );
  }

  @override
  Widget build(BuildContext context){
   /*final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final String studentName = routeArgs['studentName'];
    final String url = routeArgs['url'];
    Iterable<QueryDocumentSnapshot> databaseStudent;
    List<TextEditingController> textEditingList = [];

    void upgradeStudent(){
      int index = 0;
      databaseStudent.forEach((element) {
        databaseRef.collection('StudentInformation').doc(element.id).update({
          'grade': double.parse(textEditingList[index].text)
        });
        index+=1;
      });
    }*/

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Selección de Alumno'),
      ),
      backgroundColor: Colors.white,
      body: students.tempStud.isEmpty ? Center(child: Text('No existen alumnos registrados', style: TextStyle(color: Colors.black),),) : Container(
        child: ListView.builder(
          itemCount: students.tempStud.length,
          itemBuilder: (context, index){
            return studentCard(
              id: students.tempStud[index].id,
              name: students.tempStud[index].name,
              url: students.tempStud[index].url,
              deleteFunct: deleteStud);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: (){
          _startAddNewStudent(context);
        }),
    );
  }

  addStudent(String name){
    setState(() {
      students.tempStud.add(Student(
        id: Random().nextInt(100).toString(),
        name: name,
        //url: url,
      ));
    });
    Navigator.of(context).pop();
  }

  deleteStud(String id){
    setState(() {
      students.tempStud.removeWhere((tx){
        return tx.id == id;
      });
    });
  }
}