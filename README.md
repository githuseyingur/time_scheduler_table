
A nice time planner for Android & IOS where you can create events by clicking on cells, edit (update) and delete the events you have created. You can assign colours to events and if the name of the event is too long, you can see the full name and description by long pressing on the event.

## Features





## Getting started

```dart
flutter pub add time_scheduler_table
```

## Usage
Define a TextEditingController for event add and event update alerts:
```dart
TextEditingController textController = TextEditingController();
```
Create a list of event models with title, day index, time and color. <br> The day index, specifies the index of the elements in the top titles (Mon, Tue or Day1, Day2). It starts from 0:
```dart
List<EventModel> eventList = [
  EventModel(title: "Math", dayIndex: 0, time: "08:00 - 09:00", color: Colors.orange), // time format :  08:00 - 09:00
  EventModel(title: "History", dayIndex: 1, time: "11:00 - 12:00", color: Colors.pink), // dayIndex is topTitle's index (Monday : 0  or  Day1 : 0)
  EventModel(title: "Guitar & Piano Course", dayIndex: 4, time: "14:00 - 15:00", color: Colors.green),
  EventModel(title: "Meeting", dayIndex: 3, time: "06:00 - 07:00", color: Colors.deepPurple),
  EventModel(title: "Guitar and Piano Course", dayIndex: 2, time: "15:00 - 16:00", color: Colors.blue)
];
```
Create your Time Scheduler Widget: <br>

```dart
TimeSchedulerTable(
  cellHeight: 48,
  cellWidth: 64,
  topTitles: const ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"],      // topTitles is growable : you can add as much as you want
  currentTitleIndex: DateTime.now().weekday - 1,
  // topTitles: const ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"],
  // currentTitleIndex: 2,      --> if currentTitleIndex is 2 then selected day is 3.
  title: "Event Schedule",
  titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
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
```
<ins>topTitles</ins> contain days or values that you define. It is not required. <br> The default value is : 
```dart
["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"]
```
You can define it as : <br>
```dart
topTitles: const ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"],
currentTitleIndex: 2,
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
