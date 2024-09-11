import 'package:flutter/material.dart';

class Event {
  /// [title] is title of event.
  String? title;

  /// [time] is time of event.
  String? time;

  /// [color] is color of event.
  Color? color;

  /// [columnIndex] indicates in which column index the Event is located.
  int columnIndex;

  /// [rowIndex] indicates in which row index the Event is located.
  int rowIndex;

  Event({
    this.title,
    this.time,
    this.color,
    required this.columnIndex,
    required this.rowIndex,
  });
}
