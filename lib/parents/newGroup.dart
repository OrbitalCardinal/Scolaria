import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewGroup extends StatefulWidget {
  final Function addLoanFun;
  NewGroup(this.addLoanFun);

  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  final _codeGroupController = TextEditingController();

  void _submit(){
    widget.addLoanFun(_codeGroupController.text);
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
                decoration: InputDecoration(labelText: 'Código de Grupo'),
                controller: _codeGroupController,
              ),
              Container(
              child: Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      child: Text(
                        'Entrar a la Clase',
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