import 'package:Scolaria/teachers/announcements_screen.dart';
import 'package:Scolaria/teachers/group_settings_screen.dart';
import 'package:Scolaria/teachers/models/group_activity_model.dart';
import 'package:Scolaria/teachers/models/student_activity_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'main_teachers_screen.dart';
import 'models/group_model.dart';
import 'models/student_model.dart';
import 'student_screen.dart';

class GroupScreen extends StatefulWidget {
  static const routeName = '/GroupScreen';

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final databaseReference = FirebaseFirestore.instance;

  List<Student> students = [];

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
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final Group group = routeArgs['group'];
    Iterable<QueryDocumentSnapshot> databaseStudentsGroups;
    Iterable<QueryDocumentSnapshot> databaseStudents;
    return StreamBuilder(
        stream: databaseReference.collection('StudentGroup').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          databaseStudentsGroups = snapshot.data.docs
              .where((element) => element.data()['groupId'] == group.id);

          return StreamBuilder(
              stream: databaseReference.collection('Student').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshotStudent) {
                if (!snapshotStudent.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                databaseStudentsGroups.forEach((studentsInGroup) {
                  databaseStudents = snapshotStudent.data.docs.where(
                      (students) =>
                          students.id == studentsInGroup.data()['studentId']);
                  this.students.add(new Student(
                      id: databaseStudents.first.id,
                      name: databaseStudents.first.data()['name'],
                      imageURL: databaseStudents.first.data()['imageUrl']));
                });
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.teal[300],
                    leading: InkWell(
                      child: Icon(Icons.arrow_back),
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            MainTeachersScreen.routeName, (route) => false,
                            arguments: {'userId': MainTeachersScreen.userId});
                      },
                    ),
                    title: Text(group.name),
                    actions: [
                      FlatButton(
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              AnnouncementsScreen.routeName,
                              arguments: {'group': group});
                        },
                      ),
                      FlatButton(
                        child: Icon(Icons.settings, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                              GroupSettingsScreen.routeName,
                              arguments: {'group': group});
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
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 16),
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
                                return StudentTile(
                                  student: students[index],
                                  studentActivities: this.studentActivities,
                                  groupActivities: this
                                      .groupActivities
                                      .where((element) =>
                                          element.groupId == group.id)
                                      .toList(),
                                  group: group,
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }
}

class StudentTile extends StatelessWidget {
  final Student student;
  final List<StudentActivity> studentActivities;
  final List<GroupActivity> groupActivities;
  final Group group;

  StudentTile(
      {this.student, this.studentActivities, this.groupActivities, this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(this.student.imageURL),
        ),
        title: Text(this.student.name),
        // subtitle: Text("Promedio: " + this.student.average.toString()),
        onTap: () {
          Navigator.of(context).pushNamed(StudentScreen.routeName, arguments: {
            'studentName': this.student.name,
            'groupId': group.id,
          });
        },
      ),
    );
  }
}
