import 'package:flutter/cupertino.dart';

class StudentGroupData {
  final String studentId;
  final String groupId;
  final int average;
  final String nameSubject;
  final int activities;

  StudentGroupData({
    @required this.studentId,
    @required this.groupId,
    @required this.average,
    @required this.nameSubject,
    @required this.activities,
  });
}