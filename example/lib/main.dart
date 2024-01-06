import 'package:time_scheduler_table/time_scheduler_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.bottom]);

    TextEditingController textController = TextEditingController();

    List<EventModel> eventList = [
      EventModel(
          title: "Math",
          dayIndex: 0,
          time: "08:00 - 09:00",
          color: Colors.orange), // time format :  08:00 - 09:00
      EventModel(
          title: "History",
          dayIndex: 1,
          time: "11:00 - 12:00",
          color: Colors
              .pink), // dayIndex is topTitle's index (Monday : 0  or  Day1 : 0)
      EventModel(
          title: "Guitar & Piano Course",
          dayIndex: 4,
          time: "14:00 - 15:00",
          color: Colors.green),
      EventModel(
          title: "Meeting",
          dayIndex: 3,
          time: "06:00 - 07:00",
          color: Colors.deepPurple),
      EventModel(
          title: "Guitar and Piano Course",
          dayIndex: 2,
          time: "15:00 - 16:00",
          color: Colors.blue)
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TimeSchedulerTable(
        cellHeight: 48,
        cellWidth: 64,
        // topTitles: const ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"],      --> topTitles is growable : you can add as much as you want
        // currentTitleIndex: DateTime.now().weekday - 1,
        // topTitles: const ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"],
        // currentTitleIndex: 2,      --> if currentTitleIndex is 2 then selected day is 3.
        title: "Event Schedule",
        titleStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        eventTitleStyle: const TextStyle(color: Colors.white, fontSize: 8),
        isBack: false, // back button
        eventList: eventList,
        eventAlert: EventAlert(
          alertTextController: textController,
          borderRadius: const BorderRadius.all(
            Radius.circular(12.0),
          ),
          addAlertTitle: "Add Event",
          editAlertTitle: "Edit",
          addButtonTitle: "ADD",
          deleteButtonTitle: "DELETE",
          updateButtonTitle: "UPDATE",
          hintText: "Event Name",
          textFieldEmptyValidateMessage: "Cannot be empty!",
          addOnPressed: (event) {}, // when an event added to your list
          updateOnPressed: (event) {}, // when an event updated from your list
          deleteOnPressed: (event) {}, // when an event deleted from your list
        ),
      ),
    );
  }
}
