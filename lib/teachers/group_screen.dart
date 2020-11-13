import 'package:Scolaria/teachers/announcements_screen.dart';
import 'package:Scolaria/teachers/group_settings_screen.dart';
import 'package:Scolaria/teachers/models/group_activity_model.dart';
import 'package:Scolaria/teachers/models/student_activity_model.dart';
import 'package:flutter/material.dart';

import 'main_teachers_screen.dart';
import 'models/group_model.dart';
import 'models/student_model.dart';
import 'student_screen.dart';

class GroupScreen extends StatelessWidget {
  static const routeName = '/GroupScreen';

  final List<Student> students = [
    Student(
      id: "1",
      name: "Edson Raul Cepeda Marquez",
      average: 90,
      imageURL:
          "https://images.unsplash.com/photo-1519308824948-e00cc00057d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
    ),
    Student(
      id: "2",
      name: "Valeria Michelle Cepeda Marquez",
      average: 87,
      imageURL:
          "https://images.unsplash.com/photo-1507036066871-b7e8032b3dea?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80",
    ),
    Student(
      id: "3",
      name: "Dulce Vianey Cepeda Marquez",
      average: 70,
      imageURL:
          "https://images.unsplash.com/photo-1473655551229-a39d1a982885?ixlib=rb-1.2.1&auto=format&fit=crop&w=1352&q=80",
    ),
    Student(
      id: "4",
      name: "Lorena Maricruz Mireles Campos",
      average: 96,
      imageURL:
          "https://images.unsplash.com/photo-1471914036897-d8255336ca8a?ixlib=rb-1.2.1&auto=format&fit=crop&w=1352&q=80",
    ),
  ];

  final List<GroupActivity> groupActivities = [
    GroupActivity(name: "Ejercicio 1", weighting: 25, groupId: "1"),
    GroupActivity(name: "Ejercicio 2", weighting: 25, groupId: "1"),
    GroupActivity(name: "Ejercicio 3", weighting: 25, groupId: "1"),
    GroupActivity(name: "Ejercicio 4", weighting: 25, groupId: "1"),

    GroupActivity(name: "Ejercicio 1", weighting: 25, groupId: "2"),
    GroupActivity(name: "Ejercicio 2", weighting: 0, groupId: "2"),
    GroupActivity(name: "Ejercicio 3", weighting: 50, groupId: "2"),
    GroupActivity(name: "Ejercicio 4", weighting: 25, groupId: "2"),

    GroupActivity(name: "Ejercicio 1", weighting: 25, groupId: "3"),
    GroupActivity(name: "Ejercicio 2", weighting: 25, groupId: "3"),
    GroupActivity(name: "Ejercicio 3", weighting: 25, groupId: "3"),
    GroupActivity(name: "Ejercicio 4", weighting: 25, groupId: "3"),

    GroupActivity(name: "Ejercicio 1", weighting: 25, groupId: "4"),
    GroupActivity(name: "Ejercicio 2", weighting: 25, groupId: "4"),
    GroupActivity(name: "Ejercicio 3", weighting: 25, groupId: "4"),
    GroupActivity(name: "Ejercicio 4", weighting: 25, groupId: "4"),
  ];

  final List<StudentActivity> studentActivities = [
    StudentActivity(id: "1", groupId: "1", studentId: "1", grade: 0),
    StudentActivity(id: "2", groupId: "1", studentId: "1", grade: 0),
    StudentActivity(id: "3", groupId: "1", studentId: "1", grade: 0),
    StudentActivity(id: "4", groupId: "1", studentId: "1", grade: 0),

    StudentActivity(id: "1", groupId: "1", studentId: "2", grade: 25),
    StudentActivity(id: "2", groupId: "1", studentId: "2", grade: 25),
    StudentActivity(id: "3", groupId: "1", studentId: "2", grade: 25),
    StudentActivity(id: "4", groupId: "1", studentId: "2", grade: 25),

    StudentActivity(id: "1", groupId: "1", studentId: "3", grade: 25),
    StudentActivity(id: "3", groupId: "1", studentId: "3", grade: 0),
    StudentActivity(id: "2", groupId: "1", studentId: "3", grade: 0),
    StudentActivity(id: "4", groupId: "1", studentId: "3", grade: 25),

    StudentActivity(id: "1", groupId: "1", studentId: "4", grade: 0),
    StudentActivity(id: "2", groupId: "1", studentId: "4", grade: 25),
    StudentActivity(id: "3", groupId: "1", studentId: "4", grade: 25),
    StudentActivity(id: "4", groupId: "1", studentId: "4", grade: 0),
  ];

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final Group group = routeArgs['group'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        leading: InkWell(child: Icon(Icons.arrow_back), onTap: () {
          Navigator.of(context).pushNamedAndRemoveUntil(MainTeachersScreen.routeName, (route) => false, arguments: {
            'userId': MainTeachersScreen.userId
          });
          // Navigator.of(context).pushReplacementNamed(MainTeachersScreen.routeName, arguments: {
          //   'userId': MainTeachersScreen.userId
          // });
        },),
        title: Text(group.name),
        actions: [
          FlatButton(
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AnnouncementsScreen.routeName, arguments: {
                'group': group
              });
            },
          ),
          FlatButton(
            child: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(GroupSettingsScreen.routeName, arguments: {
                'group': group
              });
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Alumnos",
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
                  itemCount: students.length,
                  itemBuilder: (context, index) {             
                    return StudentTile(student: students[index],studentActivities: this.studentActivities,groupActivities: this.groupActivities.where((element) => element.groupId == group.id).toList(),group: group,);
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

class StudentTile extends StatelessWidget {
  final Student student;
  final List<StudentActivity> studentActivities;
  final List<GroupActivity> groupActivities;
  final Group group;

  StudentTile({this.student, this.studentActivities, this.groupActivities, this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
      ),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(this.student.imageURL),),
        title: Text(this.student.name),
        subtitle: Text("Promedio: " + this.student.average.toString()),
        trailing: Icon(Icons.delete, color: Colors.red,),
        onTap: () {
          Navigator.of(context).pushNamed(StudentScreen.routeName, arguments: {
            'group': this.group
          });
        },
      ),
    );
  }
}
