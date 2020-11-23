import 'package:flutter/cupertino.dart';

class GroupData {
  final String id;
  final String code;
  String name;
  final int activities;
  final String teacherId;
  final int students;

  GroupData({
    @required this.id,
    @required this.code,
    @required this.name,
    @required this.activities,
    @required this.teacherId,
    @required this.students,
  });
}