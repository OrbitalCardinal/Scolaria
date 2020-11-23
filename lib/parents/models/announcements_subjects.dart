import 'package:flutter/cupertino.dart';

class SubjectAnnouncements {
  final String groupId;
  final DateTime date;
  final String message;

  SubjectAnnouncements({
    @required this.groupId,
    @required this.date,
    @required this.message,
  });
}