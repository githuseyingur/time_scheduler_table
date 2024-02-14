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
        columnIndex:
            0, // columnIndex is columnTitle's index (Monday : 0 or Day 1 : 0)
        rowIndex: 2, // rowIndex is rowTitle's index (08:00 : 0 or Time 1 : 0)
        color: Colors.orange,
      ),
      EventModel(
        title: "History",
        columnIndex: 1,
        rowIndex: 5,
        color: Colors.pink,
      ),
      EventModel(
        title: "Guitar & Piano Course",
        columnIndex: 4,
        rowIndex: 8,
        color: Colors.green,
      ),
      EventModel(
        title: "Meeting",
        columnIndex: 3,
        rowIndex: 1,
        color: Colors.deepPurple,
      ),
      EventModel(
        title: "Guitar and Piano Course",
        columnIndex: 2,
        rowIndex: 9,
        color: Colors.blue,
      )
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: false,
      ),
      home: TimeSchedulerTable(
        cellHeight: 72,
        cellWidth: 72,
        columnTitles: const [
          "Mon",
          "Tue",
          "Wed",
          "Thur",
          "Fri",
          "Sat",
          "Sun"
        ], // columnTitles is growable : you can add as much as you want
        // columnTitles: const ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"],
        // currentColumnTitleIndex: 2,      --> if currentColumnTitleIndex is 2 then selected day is 3.
        currentColumnTitleIndex: DateTime.now().weekday - 1,
        rowTitles: const [
          '08:00 - 09:00',
          '09:00 - 10:00',
          '10:00 - 11:00',
          '11:00 - 12:00',
          '12:00 - 13:00',
          '13:00 - 14:00',
          '14:00 - 15:00',
          '15:00 - 16:00',
          '16:00 - 17:00',
          '17:00 - 18:00',
          '18:00 - 19:00',
          '19:00 - 20:00',
          '20:00 - 21:00',
        ],
        // You can assign any value to rowTitles. For Example : ['1','2','3']
        title: "Event Schedule",
        titleStyle: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        eventTitleStyle: const TextStyle(color: Colors.white, fontSize: 8),
        isBack: false, // back button
        eventList: eventList,
        scrollColor: Colors.deepOrange.withOpacity(0.7),
        isScrollTrackingVisible: true,
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
