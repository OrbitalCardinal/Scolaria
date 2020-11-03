import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewLoan extends StatefulWidget {
  final Function addLoanFun;
  NewLoan(this.addLoanFun);

  @override
  _NewLoanState createState() => _NewLoanState();
}

class _NewLoanState extends State<NewLoan> {
  final _nameController = TextEditingController();
  final _codeGroupController = TextEditingController();

  void _submit(){
    widget.addLoanFun(_nameController.text, _codeGroupController.text);
  }

  @override
  Widget build(BuildContext context){
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
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nombre'),
                controller: _nameController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Código de Grupo'),
                controller: _codeGroupController,
              ),
              Container(
              child: Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      child: Text(
                        'Agregar alumno',
                        style: TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.white),
                      ),
                      color: Colors.blueGrey,
                      onPressed: _submit,
                    ),
                  )
                ],))
            ],  
          ),
        ),
      ),
    );
  }
}