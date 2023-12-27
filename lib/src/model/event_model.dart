import 'package:flutter/material.dart';

class EventModel {
  String? title;
  String? time;
  Color? color;
  int dayIndex;
  EventModel({this.title, this.time, this.color, required this.dayIndex});
}
