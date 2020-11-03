import 'package:Scolaria/parents/loanScreen.dart';
import 'package:Scolaria/parents/models/loan.dart';
import 'package:Scolaria/parents/parent_start.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Student extends StatelessWidget{
  static const routeName = 'Student';
  static List<Loan> tempLoans = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        /*appBar: AppBar(
          flexibleSpace: SafeArea(
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: TabBar(
                indicatorColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Theme.of(context).backgroundColor,
                tabs: [
                  Tab(
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 6,),
                          Icon(
                            Icons.monetization_on,
                          ),
                          Text('1')
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: [
                        SizedBox(height: 6,),
                        Icon(
                          Icons.book,
                        ),
                        Text('2')
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: [
                        SizedBox(height: 6,),
                        Icon(
                          Icons.person,
                        ),
                        Text('3')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          ),
        ),*/
        body: TabBarView(children: [
          LoanScreen(),
          ParentStart(),
          Student(),
          //HistoryScreen(),
          //ProfileScreen(),
        ]),
      ),
    );
  }
}