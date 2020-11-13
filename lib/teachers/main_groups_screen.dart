import 'package:Scolaria/teachers/create_group_screen.dart';
import 'package:Scolaria/teachers/main_teachers_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import './models/group_model.dart';
import 'group_screen.dart';

class MainGroupsScreen extends StatefulWidget {
  static const routeName = '/MainGroupScreen';
  @override
  _MainGroupsScreenState createState() => _MainGroupsScreenState();
}

class _MainGroupsScreenState extends State<MainGroupsScreen> {
  final databaseReference = FirebaseFirestore.instance;
  Iterable<QueryDocumentSnapshot> databaseGroups;
  final List<Group> groups = [];

  Future buildCreateGroup() {
    TextEditingController _groupName = TextEditingController();
    TextEditingController _activitiesNumber = TextEditingController();
    return showDialog(
      context: context,
      child: AlertDialog(
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
              createNewGroup(context, _groupName, _activitiesNumber);
            },
            child: Text("Crear"),
          ),
        ],
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _groupName,
                decoration: InputDecoration(labelText: "Nombre del grupo"),
              ),
              TextField(
                controller: _activitiesNumber,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Número de actividades"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createNewGroup(BuildContext context, TextEditingController _groupName,
      TextEditingController _acitivitiesNumber) {
    if (_groupName.text.isEmpty || _acitivitiesNumber.text.isEmpty) {
      showDialog(
          context: context,
          child: AlertDialog(
            content: Text("Debe rellenar todos los campos"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Ok"),
              ),
            ],
          ));
      return;
    }

    Navigator.of(context).pushReplacementNamed(CreateGroupScreen.routeName, arguments: {
      'groupName': _groupName.text,
      'activitiesNumber':int.parse(_acitivitiesNumber.text),
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: databaseReference.collection('Group').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Retrieve groups from database
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          databaseGroups = snapshot.data.docs.where((element) =>
              element.data()['teacherId'] == MainTeachersScreen.userId);
          databaseGroups.forEach((element) {
            Group newGroup = Group(
                id: element.id,
                name: element.data()['name'],
                activities: element.data()['activities'],
                code: element.data()['code'],
                students: element.data()['students'],
                teacherId: element.data()['teacherId']);
            if (groups.where((element) => element.id == newGroup.id).length ==
                0) {
              groups.add(newGroup);
            }
          });
          return Scaffold(
            body: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Grupos(${groups.length})",
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
                          return GroupTile(
                            group: groups[index],
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.teal[300],
              child: Icon(Icons.add),
              onPressed: () {
                buildCreateGroup();
              },
            ),
          );
        });
  }
}

class GroupTile extends StatefulWidget {
  Group group;

  GroupTile({this.group});

  @override
  _GroupTileState createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.widget.group.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Código: " + this.widget.group.code)
          ],
        ),
        trailing: InkWell(
          child: Icon(Icons.content_copy),
          onTap: () {
            Clipboard.setData(new ClipboardData(text: widget.group.code));
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Código copiado al portapapeles"),
            ));
          },
        ),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(GroupScreen.routeName, arguments: {
            'group': this.widget.group
          });
        },
      ),
    );
  }
}
