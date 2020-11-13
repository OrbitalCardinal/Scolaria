import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'group_screen.dart';
import 'main_teachers_screen.dart';
import 'models/group_model.dart';

class GroupSettingsScreen extends StatefulWidget {
  static const routeName = '/GroupSettingsScreen';

  @override
  _GroupSettingsScreenState createState() => _GroupSettingsScreenState();
}

class _GroupSettingsScreenState extends State<GroupSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _newNameController = TextEditingController();
    final databaseReference = FirebaseFirestore.instance;
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    Group group = routeArgs['group'];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        title: Text("Opciones de grupo"),
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () => Navigator.of(context).pushReplacementNamed(
              GroupScreen.routeName,
              arguments: {'group': group}),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Información del grupo",
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
            SizedBox(height: 5),
            Divider(
              color: Colors.grey[700],
              height: 2,
            ),
            Column(
              children: [
                ListTile(
                  title: Text("Nombre"),
                  subtitle: Text(group.name),
                  trailing: InkWell(
                    child: Icon(Icons.edit),
                    onTap: () {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            content: TextField(
                              controller: _newNameController,
                              decoration:
                                  InputDecoration(labelText: "Nuevo nombre"),
                            ),
                            actions: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Cancelar",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              FlatButton(
                                onPressed: () {
                                  if (!_newNameController.text.isEmpty) {
                                    databaseReference
                                        .collection('Group')
                                        .doc(group.id)
                                        .update({
                                      'name': _newNameController.text
                                    }).then((value) {
                                      setState(() {
                                        group.name = _newNameController.text;
                                      });
                                      Navigator.of(context).pop();
                                    });
                                  } else {
                                    showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          content: Text(
                                              "Debe rellenar todos los campos"),
                                          actions: [
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                "Ok",
                                              ),
                                            ),
                                          ],
                                        ));
                                  }
                                },
                                child: Text("Cambiar"),
                              ),
                            ],
                          ));
                    },
                  ),
                ),
                ListTile(
                  title: Text("Código"),
                  subtitle: Text(group.code),
                  trailing: InkWell(
                    child: Icon(Icons.content_copy),
                    onTap: () {
                      Clipboard.setData(new ClipboardData(text: group.code));
                    },
                  ),
                ),
                ListTile(
                  title: Text("Número de alumnos"),
                  subtitle: Text(group.students.toString()),
                )
              ],
            ),
            Divider(
              color: Colors.grey[700],
              height: 2,
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text("Eliminar grupo"),
                  onTap: () {
                    showDialog(
                        context: context,
                        child: AlertDialog(
                          content: Text(
                              "¿Esta seguro que desea eliminar este grupo?"),
                          actions: [
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancelar")),
                            FlatButton(
                                onPressed: () {
                                  databaseReference
                                      .collection('Announcement')
                                      .get()
                                      .then((QuerySnapshot snapshot) {
                                    Iterable<QueryDocumentSnapshot>
                                        announcementsToDelete;
                                    announcementsToDelete = snapshot.docs.where(
                                        (element) =>
                                            element.data()['groupId'] ==
                                            group.id);
                                    announcementsToDelete.forEach((element) {
                                      databaseReference
                                          .collection('Announcement')
                                          .doc(element.id)
                                          .delete();
                                    });
                                  });

                                  databaseReference
                                      .collection('GroupActivity')
                                      .get()
                                      .then((QuerySnapshot snapshot) {
                                    Iterable<QueryDocumentSnapshot>
                                        activityToDelete;
                                    activityToDelete = snapshot.docs.where(
                                        (element) =>
                                            element.data()['groupId'] ==
                                            group.id);
                                    activityToDelete.forEach((element) {
                                      databaseReference
                                          .collection('GroupActivity')
                                          .doc(element.id)
                                          .delete();
                                    });
                                  });

                                  databaseReference
                                      .collection('Group')
                                      .doc(group.id)
                                      .delete()
                                      .then((value) => Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              MainTeachersScreen.routeName,
                                              (route) => false, arguments: {
                                                'userId': MainTeachersScreen.userId
                                              }));
                                },
                                child: Text(
                                  "Eliminar",
                                  style: TextStyle(color: Colors.red),
                                ))
                          ],
                        ));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
