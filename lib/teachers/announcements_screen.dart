import 'package:Scolaria/teachers/models/announcements_model.dart';
import 'package:flutter/material.dart';

class AnnouncementsScreen extends StatelessWidget {
  final List<Announcement> announcements = [
    Announcement(
        id: "1",
        date: DateTime.now(),
        groupId: "1",
        message:
            "Mamis la tarea 8 esta por entregarse para que las hagan con antelación"),
    Announcement(
        id: "2",
        date: DateTime.now(),
        groupId: "1",
        message:
            "Mamis la tarea 8 esta por entregarse para que las hagan con antelación"),
    Announcement(
        id: "3",
        date: DateTime.now(),
        groupId: "1",
        message:
            "Mamis la tarea 8 esta por entregarse para que las hagan con antelación"),
    Announcement(
        id: "4",
        date: DateTime.now(),
        groupId: "1",
        message:
            "Mamis la tarea 8 esta por entregarse para que las hagan con antelación"),
  ];

  @override
  Widget build(BuildContext context) {
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
                        decoration:
                            InputDecoration(labelText: "Mensaje del aviso"),
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
                          onPressed: () {},
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
                        border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
                      ),
                      child: ListTile(
                        title: Text(this.announcements[index].message),
                        subtitle: Text(this.announcements[index].date.toString()),
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
  }
}
