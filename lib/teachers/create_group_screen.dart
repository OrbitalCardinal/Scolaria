import 'package:Scolaria/teachers/models/group_activity_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'main_teachers_screen.dart';
import 'models/group_model.dart';

class CreateGroupScreen extends StatefulWidget {
  static const routeName = '/CreateGroupScreen';
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final databaseReference = FirebaseFirestore.instance;
  int sum = 0;
  List<TextEditingController> nameTextControllers = [];
  List<TextEditingController> weightingTextControllers = [];
  List<int> oldValues = [];
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        title: Text('Registro de actividades'),
      ),
      bottomNavigationBar: Container(
        color: Colors.teal[300],
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Suma de pondreación: $sum/100",
              style: TextStyle(
                  color: sum <= 100 ? Colors.white : Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            RaisedButton(
              child: Text(
                "Continuar",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.teal[700],
              onPressed: () async {
                bool isNamesFilled = true;
                bool isWeightingFilled = true;
                for (int i = 0; i < routeArgs['activitiesNumber']; i++) {
                  if (nameTextControllers[i].text.isEmpty) {
                    isNamesFilled = false;
                    break;
                  }
                }

                for (int i = 0; i < routeArgs['activitiesNumber']; i++) {
                  if (weightingTextControllers[i].text.isEmpty) {
                    isWeightingFilled = false;
                    break;
                  }
                }

                if (!isNamesFilled) {
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      content: Text("Todos los campos deben ser rellenados"),
                      actions: [
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text("Ok"),
                        )
                      ],
                    ),
                  );
                  return;
                }

                if (!isWeightingFilled) {
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      content: Text("Todos los campos deben ser rellenados"),
                      actions: [
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text("Ok"),
                        )
                      ],
                    ),
                  );
                  return;
                }

                if (sum != 100) {
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      content: Text(
                          "La suma de las ponderaciones debe ser igual a 100"),
                      actions: [
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text("Ok"),
                        )
                      ],
                    ),
                  );
                  return;
                }

                Group newGroup = Group(
                  id: Uuid().v4(),
                  code: Uuid().v4(),
                  name: routeArgs['groupName'],
                  activities: routeArgs['activitiesNumber'],
                  teacherId: MainTeachersScreen.userId,
                  students: 0,
                );

                List<GroupActivity> newGroupActivities = [];

                for (int i = 0; i < routeArgs['activitiesNumber']; i++) {
                  newGroupActivities.add(new GroupActivity(
                      name: nameTextControllers[i].text,
                      weighting: double.parse(weightingTextControllers[i].text),
                      groupId: newGroup.id));
                }

                databaseReference.collection('Group').doc(newGroup.id).set({
                  'code': newGroup.code,
                  'name': newGroup.name,
                  'activities': newGroup.activities,
                  'teacherId': newGroup.teacherId,
                  'students': newGroup.students
                }).then((value) {
                  int index = 0;
                  newGroupActivities.forEach((element) async {
                    databaseReference.collection('GroupActivity').doc().set({
                      'name': element.name,
                      'weighting': element.weighting,
                      'groupId': element.groupId,
                      'activityNumber': index
                    });
                    index+=1;
                  });
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      MainTeachersScreen.routeName, (route) => false,
                      arguments: {'userId': MainTeachersScreen.userId});
                });
              },
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: routeArgs['activitiesNumber'],
                itemBuilder: (context, index) {
                  nameTextControllers.add(new TextEditingController());
                  weightingTextControllers.add(new TextEditingController());
                  oldValues.add(0);
                  return Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      child: ListTile(
                        title: Text(
                          "Actividad ${index + 1}",
                          style: TextStyle(
                            color: Colors.teal[300],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: nameTextControllers[index],
                              decoration: InputDecoration(
                                  labelText: "Nombre de la actividad"),
                            ),
                            TextField(
                              controller: weightingTextControllers[index],
                              decoration:
                                  InputDecoration(labelText: "Ponderación"),
                              onSubmitted: (value) {
                                int newWeighting = int.parse(
                                    weightingTextControllers[index].text);
                                if (newWeighting != oldValues[index]) {
                                  setState(() {
                                    sum -= oldValues[index];
                                    sum += int.parse(
                                        weightingTextControllers[index].text);
                                    oldValues[index] = newWeighting;
                                  });
                                }
                              },
                              onChanged: (value) {
                                int newWeighting = int.parse(
                                    weightingTextControllers[index].text);
                                if (newWeighting != oldValues[index]) {
                                  setState(() {
                                    sum -= oldValues[index];
                                    sum += int.parse(
                                        weightingTextControllers[index].text);
                                    oldValues[index] = newWeighting;
                                  });
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
