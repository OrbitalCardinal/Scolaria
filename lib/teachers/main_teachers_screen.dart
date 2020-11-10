import 'package:flutter/material.dart';

import 'main_groups_screen.dart';
import 'profile_screen.dart';

class MainTeachersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 47),
          child: AppBar(
            backgroundColor: Colors.teal[300],
            flexibleSpace: SafeArea(
              child: TabBar(
                indicatorColor: Colors.white,
                unselectedLabelColor: Colors.teal[700],
                indicatorWeight: 2,
                tabs: [
                  Tab(
                    child: Column(
                      children: [Icon(Icons.school), Text("Grupos")],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: [Icon(Icons.person), Text("Perfil")],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(children: [
          MainGroupsScreen(),
          ProfileScreen(),
        ]),
      ),
    );
  }
}