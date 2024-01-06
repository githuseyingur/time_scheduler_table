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
Create a list of event models with title, column index, row index and color. <br> The row and column index, specify the index of the elements in the column and row titles (Mon, Tue or 08:00, 09:00). They starts from 0:
```dart
    List<EventModel> eventList = [
      EventModel(
        title: "Math",
        columnIndex: 0, // columnIndex is columnTitle's index (Monday : 0 or Day 1 : 0)
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
```
Create your Time Scheduler Widget: <br>

```dart
TimeSchedulerTable(
        cellHeight: 64,
        cellWidth: 72,
        columnTitles: const [ // You can assign any value to columnTitles. For Example : ['Column 1','Column 2','Column 3', ...]
          "Mon",
          "Tue",
          "Wed",
          "Thur",
          "Fri",
          "Sat",
          "Sun"
        ],
        currentColumnTitleIndex: DateTime.now().weekday - 1,
        rowTitles: const [ // You can assign any value to rowTitles. For Example : ['Row 1','Row 2','Row 3', ...]
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
          addOnPressed: (event) { // when an event added to your list
            // Your code after event added.
          },
          updateOnPressed: (event) { // when an event updated from your list
            // Your code after event updated.
          }, 
          deleteOnPressed: (event) { // when an event deleted from your list
            // Your code after event deleted.
          }, 
        ),
      ),
```
`columnTitles` contain days or values that you define. It is not required. <br> The default value is : 
```dart
["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"]
```
You can define it as you want. For Example: <br>
```dart
columnTitles: const ["Column 1", "Column 2", "Column 3", ...],
currentColumnTitleIndex: 2,
```
If you define like this, selected column is 3 if `currentColumnTitleIndex` is 2. 

`rowTitles` contain times or values that you define. It is not required. <br> The default value is : 
```dart
[
  '06:00 - 07:00',
  '07:00 - 08:00',
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
  '21:00 - 22:00',
  '22:00 - 23:00',
  '23:00 - 00:00',
],
```
You can define it as you want. For Example: <br>
```dart
rowTitles: const ["Row 1", "Row 2", "Row 3", ...],
```
<br> <br> <br> <br>

Thanks to [Mesut Demir](https://github.com/mesut-demr) :coffee:

