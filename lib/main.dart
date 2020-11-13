import 'package:Scolaria/parents/inicio.dart';
import 'package:Scolaria/teachers/announcements_screen.dart';
import 'package:Scolaria/teachers/create_group_screen.dart';
import 'package:Scolaria/teachers/group_screen.dart';
import 'package:Scolaria/teachers/group_settings_screen.dart';
import 'package:Scolaria/teachers/main_groups_screen.dart';
import 'package:Scolaria/teachers/student_screen.dart';
import 'package:Scolaria/widgets/loginBackground.dart';
import 'package:Scolaria/widgets/loginBackgroundTeachers.dart';
import 'package:Scolaria/widgets/registerBody.dart';
import 'package:Scolaria/widgets/registerBodyTeachers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Scolaria/parents/parent_start.dart';

import 'teachers/main_teachers_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scolaria',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (ctx) => LoginBackground(),
        LoginBackgroundTeachers.routeName: (ctx) => LoginBackgroundTeachers(),
        RegisterBodyTeachers.routeName: (ctx) => RegisterBodyTeachers(),
        RegisterBody.routeName: (ctx) => RegisterBody(),
        MainTeachersScreen.routeName: (ctx) => MainTeachersScreen(),
        CreateGroupScreen.routeName: (ctx) => CreateGroupScreen(),
        MainGroupsScreen.routeName: (ctx) => MainGroupsScreen(),
        GroupScreen.routeName: (ctx) => GroupScreen(),
        StudentScreen.routeName: (ctx) => StudentScreen(),
        AnnouncementsScreen.routeName: (ctx) => AnnouncementsScreen(),
        GroupSettingsScreen.routeName: (ctx) => GroupSettingsScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        // body: RegisterBody()
        body: MainTeachersScreen(),
        );
    }
}

