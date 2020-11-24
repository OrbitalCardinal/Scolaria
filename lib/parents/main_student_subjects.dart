import 'dart:math';

import 'package:Scolaria/parents/Student.dart';
import 'package:Scolaria/parents/groupCard.dart';
import 'package:Scolaria/parents/models/Group_Model.dart';
import 'package:Scolaria/parents/models/activity_data.dart';
import 'package:Scolaria/parents/models/group_data.dart';
import 'package:Scolaria/parents/models/student_group.dart';
import 'package:Scolaria/parents/newGroup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class StudentSubjects extends StatefulWidget {
  static const routeName = 'loanScreen';

  @override
  _StudentSubjectsState createState() => _StudentSubjectsState();
}

class _StudentSubjectsState extends State<StudentSubjects> {
  final databaseReference = FirebaseFirestore.instance;
  Iterable<QueryDocumentSnapshot> databaseGroups;
  final List<StudentGroupData> groups = [];
  String nombremateria;

  void _startAddNewLoan(
    BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    final _codeGroupController = TextEditingController();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return GestureDetector(
            child: SingleChildScrollView(
              child: Card(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        decoration:
                            InputDecoration(labelText: 'Código de Grupo'),
                        controller: _codeGroupController,
                      ),
                      Container(
                          child: Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              child: Text(
                                'Entrar a la Clase',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              color: Colors.blueGrey,
                              onPressed: () =>
                                  addLoan(_codeGroupController.text),
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: databaseReference.collection('StudentGroup').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          databaseGroups = snapshot.data.docs.where(
              (element) => element.data()['studentId'] == 'ejemplodeID'); //no

          databaseGroups.forEach((element) {
            StudentGroupData studentGroup = StudentGroupData(
              studentId: element.data()['studentId'],
              groupId: element.data()['groupId'],
              average: element.data()['average'],
              nameSubject: element.data()['nameSubject'],
              activities: element.data()['numberAct'],
            );
            if (groups
                    .where((element) =>
                        element.groupId == studentGroup.groupId)
                    .length ==
                0) {
              groups.add(studentGroup);
            }
          });
          return Scaffold(
            body: Container(
              child: ListView.builder(
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  return GroupCard(
                    studentGroupData: groups[index],
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.orange,
                child: Icon(Icons.add),
                onPressed: () {
                  _startAddNewLoan(context, snapshot);
                }),
          );
        });
  }

  addLoan(String codeGroup) {
    setState(() {
      //databaseGroups = snapshot.data.docs.where((element) =>
      //      element.data()['group'] == MainTeachersScreen.userId);
      //if(!databaseGroups.isEmpty){

      // }
      Iterable<QueryDocumentSnapshot> groupData;
      databaseReference.collection('Group').get().then((value) {
        groupData = value.docs.where((element) => element.data()['code'] == codeGroup);
        if(groupData.isEmpty){
          //Alerta de que el codigo no es el correcto
        }else{
          databaseReference.collection('StudentGroup').doc().set({
          'average': 0,
          'groupId': groupData.first.id,
          'studentId': 'ejemplodeID',
          'nameSubject':groupData.first.data()['name'],
          'numberAct': groupData.first.data()['activities']
        });
        }
      });
    });
    Navigator.of(context).pop();
  }

  deleteLoan(String id) {
    setState(() {
      Student.tempLoans.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }
}
