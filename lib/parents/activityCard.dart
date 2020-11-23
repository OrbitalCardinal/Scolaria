import 'package:Scolaria/parents/models/activity_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final ActivityData activityData;

  ActivityCard({this.activityData});

   @override
  Widget build(BuildContext context){
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: FittedBox(
            child: Icon(Icons.photo_camera//Text(
              //"Prueba"
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(5)
          ),
        ),
        title: Text('Nombre de la Actividad: '+activityData.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          "Valor: " + activityData.numberAct.toString(),
        ),
      ),
    );
  }
}