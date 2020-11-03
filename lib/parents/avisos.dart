import 'package:flutter/material.dart';

class Aviso extends StatelessWidget {
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
              title: Text('Dia de Muertos',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('02/Noviembre/2020'),
              leading: Icon(
                Icons.info,
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text('Asamblea Revolucion Mexicana',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('13/Noviembre/2020'),
              leading: Icon(
                Icons.info,
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text('Reunion para Padres',
                style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('20/Noviembre/2020'),
              leading: Icon(
                Icons.info,
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text('Festival de la Escuela',
                style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('25/Noviembre/2020'),
              leading: Icon(
                Icons.info,
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text('Ultimo de Clases',
                style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('05/Diciembre/2020'),
              leading: Icon(
                Icons.info,
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text('Entrega de Calificaciones',
                style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('10/Diciembre/2020'),
              leading: Icon(
                Icons.info,
                color: Colors.orange,
              ),
            ),
            ListTile(
              title: Text('Graduaciones',
                style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('15/Diciembre/2020'),
              leading: Icon(
                Icons.info,
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

