import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentScreen extends StatefulWidget {
  static const routeName = '/StudentScreen';
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final databaseReference = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final String studentName = routeArgs['studentName'];
    final String groupId = routeArgs['groupId'];
    Iterable<QueryDocumentSnapshot> databaseGroupActivities;
    List<TextEditingController> textEditingList  = [];

    void updateGrades() {
      int index = 0;
      databaseGroupActivities.forEach((element) {
        databaseReference.collection('StudentActivity').doc(element.id).update({
          'grade': double.parse(textEditingList[index].text)
        });
        index+=1;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        title: Text(studentName),
        actions: [
          FlatButton(
            onPressed: updateGrades,
            child: Icon(
              Icons.save,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Calificaciones",
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
            SizedBox(height: 5),
            Divider(
              color: Colors.grey[700],
              height: 2,
            ),
            Expanded(
              child: Container(
                child: StreamBuilder(
                  stream: databaseReference
                      .collection('StudentActivity')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    databaseGroupActivities =  snapshot.data.docs.where((element) => element.data()['groupId'] == groupId);

                    return ListView.builder(
                      itemCount: databaseGroupActivities.length,
                      itemBuilder: (context, index) {
                        textEditingList.add(new TextEditingController());

                        return Card(
                          elevation: 5,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(20),
                            title: Text(
                              'Actividad ${index + 1}',
                              style: TextStyle(
                                  color: Colors.teal[300],
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(databaseGroupActivities.toList()[index].data()['name']),
                                TextField(
                                  controller: textEditingList[index]..text = databaseGroupActivities.toList()[index].data()['grade'].toString(),
                                decoration: InputDecoration(
                                  labelText: "Calificación",
                                ),
                                keyboardType: TextInputType.number,
                                ),
                                
                              ],
                            ),
                          ),
                        );
                      },
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
