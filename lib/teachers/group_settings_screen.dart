import 'package:flutter/material.dart';

class GroupSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        title: Text("Opciones de grupo"),
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
                  subtitle: Text("Español"),
                  trailing: Icon(Icons.edit),
                ),
                ListTile(
                  title: Text("Código"),
                  subtitle: Text("18927bn4"),
                  trailing: Icon(Icons.content_copy),
                ),
                ListTile(
                  title: Text("Número de alumnos"),
                  subtitle: Text("12"),
                  trailing: Icon(Icons.edit),
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
                    showDialog(context: context, child: AlertDialog(
                      content: Text("¿Esta seguro que desea eliminar este grupo?"),
                      actions: [
                        FlatButton(onPressed: () {
                          Navigator.of(context).pop();
                        }, child: Text("Cancelar")),
                        FlatButton(onPressed: () {}, child: Text("Eliminar", style: TextStyle(color: Colors.red),))
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
