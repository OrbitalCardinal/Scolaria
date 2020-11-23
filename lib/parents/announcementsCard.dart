import 'package:Scolaria/parents/models/announcements_subjects.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementsCard extends StatelessWidget {
  final SubjectAnnouncements sAnnoun;

  AnnouncementsCard({
    this.sAnnoun
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: FittedBox(
            child: Text(
              sAnnoun.message,
              style: TextStyle(color: Colors.white),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(5)),
        ),
        title: Text("Fecha: ${sAnnoun.date.toLocal().toString()}", style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            'Prueba'),
      ),
    );
  }
}