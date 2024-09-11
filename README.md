A time table for Android & IOS where you can create events by clicking on cells, edit (update) and delete the events you have created. You can assign colors to events and if the name of the event is too long, you can see the full name and description by long pressing on the event.

## Features

<img src="https://github.com/user-attachments/assets/5b185280-1cd8-4cf2-af45-fdaa0b8d8e0b"  width="280" >
<img src="https://github.com/user-attachments/assets/7f8ba698-079a-4b02-980d-40f73d79b715"  width="280">
<img src="https://github.com/user-attachments/assets/53117e44-7a2f-4831-bc36-84c4d930ef63"  width="280">
<img src="https://github.com/user-attachments/assets/d263b526-e428-4c4d-a4ad-d192995d735a"  width="280">


## Getting started

```dart
flutter pub add time_scheduler_table
```

## Usage

Create a list of event with title, column index, row index and color. <br> The row and column index, specify the index of the elements in the column and row labels (Mon, Tue or 08:00, 09:00). They starts from 0:
```dart
     List<Event> eventList = [
    Event(
      title: "Flutter Project",
      columnIndex: 0, //columnLabel's index (Monday)
      rowIndex: 3, //rowLabel's index (08:00)
      color: Colors.orange,
    ),
    Event(
      title: "Deep Learning Course",
      columnIndex: 1,
      rowIndex: 6,
      color: Colors.pink,
    ),
    Event(
      title: "Violin & Piano Course",
      columnIndex: 4,
      rowIndex: 8,
      color: Colors.green,
    ),
    Event(
      title: "Sport",
      columnIndex: 3,
      rowIndex: 1,
      color: Colors.deepPurpleAccent,
    ),
    Event(
      title: "Algorithm and Data Structures",
      columnIndex: 2,
      rowIndex: 11,
      color: Colors.blue,
    )
  ];
```
Create your Time Scheduler Widget: <br>

```dart
TimeSchedulerTable(
        cellHeight: 52,
        cellWidth: 64,
        columnLabels: const [ // You can assign any value to columnLabels. For Example : ['Column 1','Column 2','Column 3', ...]
          "Mon",
          "Tue",
          "Wed",
          "Thur",
          "Fri",
          "Sat",
          "Sun"
        ],
        currentColumnTitleIndex: DateTime.now().weekday - 1,
        rowLabels: const [ // You can assign any value to rowLabels. For Example : ['Row 1','Row 2','Row 3', ...]
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
        eventList: eventList,
        eventAlert: EventAlert(
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
`columnLabels` contain days or values that you define. It is not required. <br> The default value is : 
```dart
["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"]
```
You can define it as you want. For Example: <br>
```dart
columnLabels: const ["Column 1", "Column 2", "Column 3", ...],
currentColumnTitleIndex: 2,
```
If you define like this, selected column is 3 if `currentColumnTitleIndex` is 2. 

`rowLabels` contain times or values that you define. It is not required. <br> The default value is : 
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
rowLabels: const ["Row 1", "Row 2", "Row 3", ...],
```
<br> <br> <br> <br>

Thanks to [Mesut Demir](https://github.com/mesut-demr) :coffee:

