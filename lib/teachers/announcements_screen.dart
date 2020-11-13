import 'package:Scolaria/teachers/models/announcements_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'models/group_model.dart';

class AnnouncementsScreen extends StatefulWidget {
  static const routeName = '/AnnouncementsScreen';
  @override
  _AnnouncementsScreenState createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  final databaseReference = FirebaseFirestore.instance;
  Iterable<QueryDocumentSnapshot> databaseAnnouncements = [];
  final List<Announcement> announcements = [];
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final Group group = routeArgs['group'];
    return StreamBuilder(
        stream: databaseReference.collection('Announcement').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          databaseAnnouncements = snapshot.data.docs
              .where((element) => element.data()['groupId'] == group.id);
          databaseAnnouncements.forEach((element) {
            Announcement newAnnouncement = new Announcement(
              id: element.id,
              date: element.data()['date'].toDate(),
              groupId: element.data()['groupId'],
              message: element.data()['message'],
            );
            if (this
                    .announcements
                    .where((element) => element.id == newAnnouncement.id)
                    .length ==
                0) {
              this.announcements.add(newAnnouncement);
            }
          });

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.teal[300],
              title: Text("Avisos"),
              actions: [
                FlatButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            content: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                  labelText: "Mensaje del aviso"),
                            ),
                            actions: [
                              FlatButton(
                                child: Text("Cancelar",
                                    style: TextStyle(color: Colors.red)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text("Agregar",
                                    style: TextStyle(color: Colors.blue)),
                                onPressed: () {
                                  Announcement newAnnouncement =
                                      new Announcement(
                                    date: DateTime.now(),
                                    groupId: group.id,
                                    id: Uuid().v4(),
                                    message: _messageController.text,
                                  );
                                  databaseReference
                                      .collection('Announcement')
                                      .doc(newAnnouncement.id)
                                      .set({
                                    'date': newAnnouncement.date,
                                    'groupId': newAnnouncement.groupId,
                                    'id': newAnnouncement.id,
                                    'message': newAnnouncement.message
                                  }).then((value) {
                                    // setState(() {
                                    //   announcements.add(newAnnouncement);
                                    // });
                                    Navigator.of(context).pop();
                                  });
                                },
                              )
                            ],
                          ));
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ))
              ],
            ),
            body: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Avisos",
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
                        itemCount: this.announcements.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey))),
                            child: ListTile(
                              title: Text(this.announcements[index].message),
                              subtitle: Text(
                                  this.announcements[index].date.toString()),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
