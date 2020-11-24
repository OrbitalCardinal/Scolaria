import 'package:Scolaria/parents/parent_start.dart';
import 'package:Scolaria/parents/subject_Details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class studentCard extends StatelessWidget{
  final String id;
  final String name; 
  final String url;
  final Function deleteFunct;

  const studentCard(
    {
      this.id,
      this.name,
      this.url, 
      this.deleteFunct
    }
  );

  @override
  Widget build(BuildContext context){
    
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: FittedBox(
            child: Icon(Icons.photo_camera),
          ),
          decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(5)
          ),
        ),
        title: Text(this.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Alumno"),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: Icon(Icons.delete),
              onTap: (){
                showDialog(
                  context: context,
                  child: AlertDialog(
                    content: Text('¿Está seguro que desea eliminar los datos?'),
                    actions: [
                      FlatButton(
                        child: Text('Cancelar'),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text('Eliminar', style: TextStyle(color: Colors.red),),
                        onPressed: (){
                          this.deleteFunct(this.id);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        onTap: (){
          Navigator.of(context).pushReplacementNamed(ParentStart.routeName,
          arguments: {
            'idStudent': id,
          });
        },
      ),
    );
  }
}