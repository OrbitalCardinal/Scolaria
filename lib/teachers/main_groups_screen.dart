import 'package:flutter/material.dart';
import './models/group_model.dart';
import 'group_screen.dart';

class MainGroupsScreen extends StatelessWidget {
  final List<Group> groups = [
    Group(
        id: "1",
        code: "1",
        name: "Español",
        activities: 4,
        students: 20,
        teacherId: "123"),
    Group(
        id: "2",
        code: "1",
        name: "Matematicas",
        activities: 4,
        students: 20,
        teacherId: "123"),
    Group(
        id: "3",
        code: "1",
        name: "Geografia",
        activities: 4,
        students: 20,
        teacherId: "123"),
    Group(
        id: "4",
        code: "1",
        name: "Civica",
        activities: 4,
        students: 20,
        teacherId: "123"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Grupos(4)",
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
          showDialog(
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
                  onPressed: () {},
                  child: Text("Crear"),
                ),
              ],
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration:
                          InputDecoration(labelText: "Nombre del grupo"),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(labelText: "Número de actividades"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class GroupTile extends StatelessWidget {
  final Group group;

  GroupTile({this.group});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.group.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Código: " + this.group.code)
          ],
        ),
        trailing: Icon(Icons.content_copy),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => GroupScreen(group: this.group,)));
        },
      ),
    );
  }
}
