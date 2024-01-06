import 'package:flutter/material.dart';

class EventModel {
  /// [title] is title of event.
  String? title;

  /// [time] is time of event.
  String? time;

  //// [color] is color of event.
  Color? color;

  /// [dayIndex] indicates in which column index the Event is located.
  int dayIndex;

  EventModel({
    this.title,
    this.time,
    this.color,
    required this.dayIndex,
  });
}
