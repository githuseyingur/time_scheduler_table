import 'package:flutter/material.dart';
import 'package:time_scheduler_table/src/model/event.dart';

class EventAlert {
  /// [addAlertTitle] is title for add alert.
  String? addAlertTitle;

  /// [editAlertTitle] is title for edit alert.
  String? editAlertTitle;

  /// [hintText] is hint of TextFormField inside the alert.
  String? hintText;

  /// [textFieldEmptyValidateMessage] is message shown when the form is empty.
  String? textFieldEmptyValidateMessage;

  /// [initialEventColor] is initial color of event. Whatever color is assigned to this variable is selected inside the alert.
  Color initialEventColor = Colors.orange;

  /// [addButtonTitle] is title of the add button inside the alert.
  String? addButtonTitle;

  /// [deleteButtonTitle] is title of the delete button inside the alert.
  String? deleteButtonTitle;

  /// [updateButtonTitle] is title of the update button inside the alert.
  String? updateButtonTitle;

  /// [addOnPressed] is the function that shows the actions to be performed after adding the event by clicking the add button.
  Function(Event event)? addOnPressed;

  /// [deleteOnPressed] is the function that shows the actions to be performed after deleting the event by clicking the delete button.
  Function(Event event)? deleteOnPressed;

  /// [updateOnPressed] is the function that shows the actions to be performed after updating the event by clicking the update button.
  Function(Event event)? updateOnPressed;

  EventAlert(
      {this.addAlertTitle,
      this.editAlertTitle,
      this.hintText,
      this.addButtonTitle,
      this.deleteButtonTitle,
      this.updateButtonTitle,
      this.textFieldEmptyValidateMessage,
      this.addOnPressed,
      this.deleteOnPressed,
      this.updateOnPressed});
}
