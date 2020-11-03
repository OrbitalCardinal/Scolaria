import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoanCard extends StatelessWidget {
  final String id;
  final String name;
  final DateTime initialDate;
  final DateTime finalDate;
  final double amount;
  final Function deleteFunct;

  const LoanCard(
      {this.id,
      this.name,
      this.initialDate,
      this.finalDate,
      this.amount,
      this.deleteFunct});

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
              '\$${this.amount.toString()}',
              style: TextStyle(color: Colors.white),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(5)),
        ),
        title: Text(this.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            'Fecha inicial: ${DateFormat.yMMMd().format(this.initialDate)}\nFecha final: ${DateFormat.yMMMd().format(this.finalDate)}'),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon(Icons.edit),
            InkWell(
              child: Icon(Icons.delete),
              onTap: () {
                showDialog(
                  context: context,
                  child: AlertDialog(
                    content: Text('¿Está seguro que desea eliminar este prestamo?'),
                    actions: [
                      FlatButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text('Eliminar', style: TextStyle(color: Colors.red),),
                        onPressed: () {
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
      ),
    );
  }
}