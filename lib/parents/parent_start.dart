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
        // backgroundColor: Theme.of(context).backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 47),
          child: AppBar(
            backgroundColor: Colors.orange[500],
            flexibleSpace: SafeArea(
              child: TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 2,
                tabs: [
                  Tab(
                    child: Icon(
                      Icons.notifications,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.book,
                    ),
                  ),
                  Tab(
                    child: Icon(
                      Icons.grade,
                    ),
                  ),
                  Tab(
                      child: Icon(
                    Icons.person,
                  )),
                ],
              ),
            ),
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
