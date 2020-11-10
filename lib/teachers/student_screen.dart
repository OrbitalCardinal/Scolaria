import 'package:Scolaria/teachers/models/group_activity_model.dart';
import 'package:flutter/material.dart';

import 'models/student_activity_model.dart';
import 'models/student_model.dart';

class StudentScreen extends StatelessWidget {
  final Student student;
  List<StudentActivity> studentActivities;
  final List<GroupActivity> groupActivities;

  StudentScreen(
      {@required this.student,
      @required this.studentActivities,
      @required this.groupActivities});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        title: Text(
          student.name,
          style: TextStyle(fontSize: 17),
        ),
        actions: [
          FlatButton(
            child: Icon(Icons.save, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Calificaciones",
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
            SizedBox(height: 5),
            Divider(
              color: Colors.grey[700],
              height: 2,
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: this.studentActivities.length,
                  itemBuilder: (context, index) {
                    return GradeStudentTile(
                      studentActivity: this.studentActivities[index],
                      index: index,
                      groupActivity: this.groupActivities[index],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GradeStudentTile extends StatelessWidget {
  final StudentActivity studentActivity;
  final int index;
  final GroupActivity groupActivity;

  GradeStudentTile(
      {@required this.studentActivity,
      @required this.index,
      @required this.groupActivity});

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(
          title: Text("Actividad " +
              (index + 1).toString() +
              " (" +
              this.groupActivity.weighting.toString() +
              "%)"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(this.groupActivity.name),
              Form(
                key: _formKey,
                child: TextFormField(
                  initialValue: this.studentActivity.grade.toString(),
                  decoration: InputDecoration(
                    labelText: "Calificación",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
