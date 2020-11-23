import 'package:Scolaria/parents/subject_Details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/student_group.dart';

class GroupCard extends StatelessWidget {
  final StudentGroupData studentGroupData;

  GroupCard(
    {
      this.studentGroupData,
    }
  );

  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: FittedBox(
            child: Icon(Icons.book//Text(
              //"Prueba"
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(5)
          ),
        ),
        title: Text("Grupo: ${studentGroupData.nameSubject}", style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          "Actividades: ${studentGroupData.activities}",
        ),
        onTap: (){
          Navigator.of(context).pushReplacementNamed(SubjectActivity.routeName,
          arguments: {
            'groupId': studentGroupData,
          });
        },
      ),
    );
  }
}