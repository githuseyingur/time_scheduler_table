A time scheduler for Android & IOS where you can create events by clicking on cells, edit (update) and delete the events you have created. You can assign colours to events and if the name of the event is too long, you can see the full name and description by long pressing on the event.

## Features

#### GIFS
<img src="https://github.com/githuseyingur/time_scheduler_table/assets/120099096/27177563-81d0-49ca-9765-87b52c39a8bd"  width="280" height ="580">
<img src="https://github.com/githuseyingur/time_scheduler_table/assets/120099096/c909575d-4292-45e3-95e0-ecf59cd92092"  width="280" height ="580">

#### SCREENSHOTS
<img src="https://github.com/githuseyingur/time_scheduler_table/assets/120099096/b3c72c90-512e-40b5-a98a-cb5cebc5e768"  width="280">
<img src="https://github.com/githuseyingur/time_scheduler_table/assets/120099096/ba9214b2-9efc-477c-8e79-2a9beea7e1f6"  width="280">
<img src="https://github.com/githuseyingur/time_scheduler_table/assets/120099096/8179e42e-a57e-42f8-aed2-693998af9692"  width="280">
<img src="https://github.com/githuseyingur/time_scheduler_table/assets/120099096/b56ee7c6-bfb9-4b25-9097-08a7239edc7d"  width="280">


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
`topTitles` contain days or values that you define. It is not required. <br> The default value is : 
```dart
["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"]
```
You can define it as : <br>
```dart
topTitles: const ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"],
currentTitleIndex: 2,
```
If you define like this, the `topTitles` contain numbers from 1 to 14. And selected day is 3 if `currentTitleIndex` is 2.

