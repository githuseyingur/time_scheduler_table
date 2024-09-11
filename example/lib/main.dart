import 'package:time_scheduler_table/time_scheduler_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.bottom]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // title, back button, etc. can be added here
          TimeSchedulerTable(
            eventList: eventList,
            cellHeight: 52,
            cellWidth: 64,
            currentColumnTitleIndex: 3,
            // column & row labels can be added
            eventAlert: EventAlert(
              addOnPressed: (event) {
                showSnackBar(context, '${event.title} added', event.color!);
              },
              deleteOnPressed: (event) {
                showSnackBar(context, '${event.title} deleted', event.color!);
              },
              updateOnPressed: (event) {
                showSnackBar(context, '${event.title} updated', event.color!);
              },
            ),
          ),
        ],
      ),
    );
  }

  void showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      backgroundColor: color,
    ));
  }
}
