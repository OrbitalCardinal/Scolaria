import 'package:Scolaria/parents/announcementsCard.dart';
import 'package:Scolaria/parents/subject_Details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/announcements_subjects.dart';
import 'models/student_group.dart';

class AnnouncementsSubject extends StatelessWidget {
  static const routeName = '/AnnouncementsSubject';
  final databaseReference = FirebaseFirestore.instance;
  Iterable<QueryDocumentSnapshot> databaseGroups;
  final List<SubjectAnnouncements> groups = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: databaseReference.collection('Announcement').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Retrieve groups from database
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final routeArgs =
              ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
          final StudentGroupData group = routeArgs['groupId'];
          //Cambia a group ide el grupo
          databaseGroups = snapshot.data.docs.where((element) =>
              element.data()['groupId'] ==
              group.groupId);
          databaseGroups.forEach((element) {
            SubjectAnnouncements announcements = SubjectAnnouncements(
                groupId: element.data()['groupId'],
                date: element.data()['date'],
                message: element.data()['message']);
            if (groups
                    .where((element) => element.message == announcements.message)
                    .length ==
                0) {
              groups.add(announcements);
            }
          });
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange[500],
              leading: InkWell(
                child: Icon(Icons.arrow_back),
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      SubjectActivity.routeName, (route) => false,
                      arguments: {'groupId': group.groupId});
                },
              ),
              title: Text('Avisos de la Materia'),
              actions: [
                FlatButton(
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AnnouncementsSubject.routeName);
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
                    "Avisos "+groups.length.toString(),
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
                          return AnnouncementsCard(
                            sAnnoun: groups[index],
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
