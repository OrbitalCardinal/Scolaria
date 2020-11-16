import 'package:Scolaria/teachers/main_teachers_screen.dart';
import 'package:Scolaria/widgets/loginBackgroundTeachers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final databaseReference = FirebaseFirestore.instance;
  Iterable<QueryDocumentSnapshot> userInfo;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: databaseReference.collection('User').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          userInfo = snapshot.data.docs.where(
              (element) => element.data()['id'] == MainTeachersScreen.userId);

          return Scaffold(
            body: Center(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Información del perfil",
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: Colors.grey[700],
                      height: 2,
                    ),
                    ListTile(
                      title: Text("Correo"),
                      subtitle: Text(userInfo.toList().first.data()['email']),
                    ),
                    ListTile(
                      title: Text("Nombre"),
                      subtitle:
                          Text(userInfo.toList().first.data()['userName']),
                    ),
                    Divider(
                      color: Colors.grey[700],
                      height: 2,
                    ),
                    ListTile(
                      title: Text("Cerrar sesión"),
                      trailing: Icon(Icons.input),
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(LoginBackgroundTeachers.routeName, (route) => false);
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
