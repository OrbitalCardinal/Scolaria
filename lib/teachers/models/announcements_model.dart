import 'package:flutter/material.dart';

class Announcement {
  final String id;
  final DateTime date;
  final String message;
  final String groupId;

  Announcement({
    @required this.id,
    @required this.date,
    @required this.message,
    @required this.groupId,
  });
}
