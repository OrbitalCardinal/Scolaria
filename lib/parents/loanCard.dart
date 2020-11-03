import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoanCard extends StatelessWidget {
  final String id;
  final String name;
  final String codeGroup;
  final Function deleteFunct;

  const LoanCard(
    {
      this.id,
      this.name,
      this.codeGroup,
      this.deleteFunct
    }
  );

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
        title: Text(this.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          "Grado de escolaridad"
        ),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: Icon(Icons.delete),
              onTap: (){
                showDialog(
                  context: context,
                  child: AlertDialog(
                    content: Text('¿Está seguro que desea eliminar la información?'),
                    actions: [
                      FlatButton(
                        child: Text('Cancelar'),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text('Eliminar',style: TextStyle(color: Colors.deepPurpleAccent),),
                        onPressed: (){
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