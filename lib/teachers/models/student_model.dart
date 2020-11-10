import 'package:flutter/cupertino.dart';

class Student {
  final String id;
  final String name;
  final double average;
  final String imageURL;

  Student({
    @required this.id,
    @required this.name,
    @required this.average,
    this.imageURL
  });
}
