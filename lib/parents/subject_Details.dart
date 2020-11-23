import 'package:Scolaria/parents/activityCard.dart';
import 'package:Scolaria/parents/annoucementsSubject.dart';
import 'package:Scolaria/parents/models/student_group.dart';
import 'package:Scolaria/parents/parent_start.dart';
import 'package:Scolaria/parents/main_student_subjects.dart';
import 'package:Scolaria/parents/models/activity_data.dart';
import 'package:Scolaria/parents/models/group_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectActivity extends StatelessWidget {
  static const routeName = '/SubjectActivity';
  final databaseReference = FirebaseFirestore.instance;
  Iterable<QueryDocumentSnapshot> databaseGroups;
  final List<ActivityData> groups = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: databaseReference.collection('GroupActivity').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Retrieve groups from database
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          //Se recive el groupId para mostrar las materias de ese grupo
          final routeArgs =
              ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
          final StudentGroupData group = routeArgs['groupId'];
          databaseGroups = snapshot.data.docs.where((element) =>
              element.data()['groupId'] ==
              group.groupId);//Insertar group.groupId.
             

          databaseGroups.forEach((element) {
            ActivityData activity = ActivityData(
                name: element.data()['name'],
                weighting: element.data()['activities'],
                numberAct: element.data()['code']);
            if (groups
                    .where((element) => element.name == activity.name)
                    .length ==
                0) {
              groups.add(activity);
            }
          });
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange[500],
              leading: InkWell(
                child: Icon(Icons.arrow_back),
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      ParentStart.routeName, (route) => false);
                },
              ),
              title: Text('Detalles de Actividades'),
              actions: [
                FlatButton(
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AnnouncementsSubject.routeName,
                        arguments: {'groupId': group});
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Actividades(${groups.length})",
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
                        itemCount: groups.length,
                        itemBuilder: (context, index) {
                          return ActivityCard(
                            activityData: groups[index],
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
  }
}
