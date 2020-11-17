import 'package:flutter/cupertino.dart';

class Student {
  final String id;
  final String name;
  final String url;

  Student({
    @required this.id,
    @required this.name,
    this.url
  });
}