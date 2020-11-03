
import 'package:flutter/material.dart';

class Materias extends StatelessWidget {
  static final showCard = true; // Set to false to show Stack

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        body: Center(child: showCard ? _buildCard() : _buildStack()),
      ),
    );
  }

  // #docregion Card
  Widget _buildCard() => SizedBox(
      height: 600,
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Matematicas',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Prof. Juan Hdz'),
              leading: Icon(
                Icons.book,
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text('Español',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Prof. Melissa Reyna'),
              leading: Icon(
                Icons.book,
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text('Ciencias Sociales',
                style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Prof. Jorge Ginez'),
              leading: Icon(
                Icons.book,
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text('Educacion Fisica',
                style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Prof. Martha Hdz'),
              leading: Icon(
                Icons.book,
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text('Artes',
                style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Prof. Antoni Perez'),
              leading: Icon(
                Icons.book,
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text('Historia',
                style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Prof. Cesar Hdz'),
              leading: Icon(
                Icons.book,
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text('Geografia',
                style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Prof. Edson Hdz'),
              leading: Icon(
                Icons.book,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  // #enddocregion Card

  // #docregion Stack
  Widget _buildStack() => Stack(
      alignment: const Alignment(0.6, 0.6),
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('images/pic.jpg'),
          radius: 100,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black45,
          ),
          child: Text(
            'Mia B',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  // #enddocregion Stack
}