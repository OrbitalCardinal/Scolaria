

import 'package:Scolaria/parents/avisos.dart';
import 'package:Scolaria/parents/informacion.dart';
import 'package:Scolaria/parents/materias.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Scolaria/parents/inicio.dart';

class ParentStart extends StatelessWidget {
  static const routeName = 'parent_start';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: TabBar(
                indicatorColor: Colors.transparent,
                labelColor: Colors.orange,
                unselectedLabelColor: Theme.of(context).backgroundColor,
                tabs: [
                  Tab(
                    child: Icon(
                      Icons.home,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.lock_clock
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.book
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.person
                    )
                  ),
                ],
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          ),
        ),
        body: TabBarView(children: [
          InicioPadre(),
          Aviso(),
          Materias(),
          Info(),
        ]),
      ),
    );
  }
}