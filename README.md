
A nice time planner for Android & IOS where you can create events by clicking on cells, edit (update) and delete the events you have created. You can assign colours to events and if the name of the event is too long, you can see the full name and description by long pressing on the event.

## Features

```dart
TextEditingController textController = TextEditingController();

List<EventModel> eventList = [
  EventModel(title: "Math", dayIndex: 0, time: "08:00 - 09:00", color: Colors.orange), // time format :  08:00 - 09:00
  EventModel(title: "History", dayIndex: 1, time: "11:00 - 12:00", color: Colors.pink), // dayIndex is topTitle's index (Monday : 0  or  Day1 : 0)
  EventModel(title: "Guitar & Piano Course", dayIndex: 4, time: "14:00 - 15:00", color: Colors.green),
  EventModel(title: "Meeting", dayIndex: 3, time: "06:00 - 07:00", color: Colors.deepPurple),
  EventModel(title: "Guitar and Piano Course", dayIndex: 2, time: "15:00 - 16:00", color: Colors.blue)
];
```



## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
