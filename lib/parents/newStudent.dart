import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class NewStudent extends StatefulWidget{
  final Function addStudentFun;
  NewStudent(this.addStudentFun);

  @override
  _NewStudentState createState() => _NewStudentState();
  final FirebaseStorage storage = FirebaseStorage(app: Firestore.instance.app,
  storageBucket: 'gs://scolaria-44ae1.appspot.com');
}

class _NewStudentState extends State<NewStudent> {
  File _image;
  final _nameController = TextEditingController();
  
  void _submit(){
    widget.addStudentFun(_nameController.text);
  }

  @override
  Widget build(BuildContext context){

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
      //widget.addStudentFun(_nameController.text);
    }

    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10, 
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

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
                    padding: EdgeInsets.only(top: 80.0),
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
                height: 20.0,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Nombre del alumno'),
                controller: _nameController,
              ),
              
              /*Container(
                child: Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                        child: Text(
                          'Agregar Alumno',
                          style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.white),
                        ),
                        color: Colors.orange,
                        onPressed: _submit,
                      ),
                    )
                  ],
                )
              )*/
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
                      _submit();
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

              SizedBox(
                height: 30.0,
              ),

            ],
            
          ),
        ),
      ),
    );

  }
}