import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class seleccionAlumno extends StatefulWidget {
  static const routeName ='seleccionalumno';
  @override
  _seleccionAlumno createState() => _seleccionAlumno();
  final FirebaseStorage storage = FirebaseStorage(app: Firestore.instance.app,
  storageBucket: 'gs://scolaria-44ae1.appspot.com');
}

class _seleccionAlumno extends State<seleccionAlumno> {
  File _image;
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(_image);
      //TaskSnapshot taskSnapshot = await uploadTask.onComplete;

      //final String url = (await taskSnapshot.ref.getDownloadURL());
      print('URL is $url');

      setState(() {
        print("Foto de perfil actualizada");
        print("...................$url");
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Foto de perfil actualizada')));
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Información Alumno'),
      ),
      body: Builder(
        builder: (context) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                        radius: 90,
                        backgroundColor: Colors.orange,
                        child: ClipOval(
                          child: SizedBox(
                            width: 160.0,
                            height: 160.0,
                            child: (_image != null)
                                ? Image.file(_image, fit: BoxFit.fill)
                                : Image.network(
                                    "https://image.flaticon.com/icons/png/512/354/354637.png",
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 90.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.photo_camera,
                        size: 30.0,
                      ),
                      onPressed: () {
                        getImage();
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Usuario',
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 18.0),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Melissa Reyna',
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Icon(
                        Icons.edit,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Email: ',
                        style:
                            TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
                    SizedBox(width: 20.0),
                    Text('melissa21@gmail.com',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.orange,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    elevation: 3.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.orange,
                    onPressed: () {
                      uploadPic(context);
                    },
                    elevation: 3.0,
                    splashColor: Colors.blueGrey,
                    child: Text(
                      'Aceptar',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}