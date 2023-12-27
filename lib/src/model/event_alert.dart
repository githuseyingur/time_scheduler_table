import 'package:flutter/material.dart';
import 'package:time_scheduler_table/src/model/event_model.dart';

class EventAlert {
  TextEditingController alertTextController; //
  String? addAlertTitle; //
  String? editAlertTitle; //
  String? hintText; //
  String? textFieldEmptyValidateMessage; //
  BorderRadiusGeometry? borderRadius; //
  Color initialEventColor = Colors.orange; //
  String? addButtonTitle; //
  String? deleteButtonTitle; //
  String? updateButtonTitle; //
  Function(EventModel event)? addOnPressed;
  Function(EventModel event)? deleteOnPressed;
  Function(EventModel event)? updateOnPressed;

  EventAlert(
      {required this.alertTextController,
      this.addAlertTitle,
      this.editAlertTitle,
      this.hintText,
      this.addButtonTitle,
      this.deleteButtonTitle,
      this.updateButtonTitle,
      this.textFieldEmptyValidateMessage,
      this.borderRadius,
      this.addOnPressed,
      this.deleteOnPressed,
      this.updateOnPressed});
}
