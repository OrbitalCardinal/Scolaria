import 'dart:math';

import 'package:Scolaria/parents/Student.dart';
import 'package:Scolaria/parents/loanCard.dart';
import 'package:Scolaria/parents/models/loan.dart';
import 'package:Scolaria/parents/newLoan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoanScreen extends StatefulWidget {
  static const routeName = 'loanScreen';

  @override
  _LoanScreenState createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  
  void _startAddNewLoan(BuildContext context){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_){
        return GestureDetector(
          child: NewLoan(addLoan),
          onTap: (){},
          behavior: HitTestBehavior.opaque,
        );
      }
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Student.tempLoans.isEmpty ? Center(child: Text('No existen alumnos registrados', style: TextStyle(color: Colors.white),),) : Container(
        child: ListView.builder(
          itemCount: Student.tempLoans.length,
          itemBuilder: (context, index){
            return LoanCard(
              id:  Student.tempLoans[index].id,
              name: Student.tempLoans[index].name,
              codeGroup: Student.tempLoans[index].codeGroup,
              deleteFunct: deleteLoan);
          },
        ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.orange,
      child: Icon(Icons.add),
      onPressed: (){
        _startAddNewLoan(context);
      }),
    );
  }

  addLoan(String name, String codeGroup){
    setState(() {
      Student.tempLoans.add(Loan(
        id: Random().nextInt(100).toString(),
        name: name,
        codeGroup: codeGroup,
      ));
    });
    Navigator.of(context).pop();
  }

  deleteLoan(String id){
    setState(() {
      Student.tempLoans.removeWhere((tx){
        return tx.id == id;
      });
    });
  }
}