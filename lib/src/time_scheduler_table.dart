// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:time_scheduler_table/src/model/event_alert.dart';
import 'package:time_scheduler_table/src/model/event_model.dart';
import 'package:time_scheduler_table/src/widget/color_circle.dart';
import 'package:time_scheduler_table/src/widget/scheduler_alert.dart';

// ignore: must_be_immutable
class TimeSchedulerTable extends StatefulWidget {
  TimeSchedulerTable(
      {super.key,
      this.title,
      this.titleStyle,
      this.eventTitleStyle,
      this.isBack = true,
      this.currentTitleIndex,
      this.topTitles,
      required this.eventList,
      required this.cellHeight,
      required this.cellWidth,
      required this.eventAlert});

  /// [title] is title of table
  final String? title;

  /// [titleStyle] is text style of table's title
  final TextStyle? titleStyle;

  /// [eventTitleStyle] is text style of event's title in cells
  final TextStyle? eventTitleStyle;

  /// [isBack] is the button in the table that allows to go back. Default value is true.
  final bool isBack;

  /// [currentTitleIndex] is the index indicating the currently selected column.
  final int? currentTitleIndex;

  /// [eventList] is the list of [EventModel] containing events.
  final List<EventModel> eventList;

  /// [cellHeight] is the height of cells in table.
  final double cellHeight;

  /// [cellWidth] is the width of cells in table.
  final double cellWidth;

  /// [selectedDate] is used to specify the selected column if [currentTitleIndex] is not given.
  final selectedDate = DateTime.now();

  final ScrollController mainHorizontalController = ScrollController();
  final ScrollController mainVerticalController = ScrollController();
  final ScrollController dayHorizontalController = ScrollController();
  final ScrollController timeVerticalController = ScrollController();

  /// [x] is  list of column's index
  final List<int> x = [];

  /// [y] is  list of row's index
  final List<int> y = [];

  /// [indexList] is string list of (x+y)
  final List<String> indexList = [];

  /// [topTitles] is list of column names.
  List<String>? topTitles;

  /// [formKey] is key of TextFormField in [EventAlert]
  final formKey = GlobalKey<FormState>();

  /// [EventAlert] is is the class containing all the properties of the alert.
  final EventAlert eventAlert;

  @override
  State<TimeSchedulerTable> createState() => _TimeSchedulerTableState();
}

class _TimeSchedulerTableState extends State<TimeSchedulerTable> {
  @override
  Widget build(BuildContext context) {
    // topTitles are table column names.
    List<String>? topTitles =
        widget.topTitles ?? ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"];
    // headers is a widget list containing table column names.
    List<Widget> headers = List.generate(topTitles.length, (index) {
      return SizedBox(
        height: 32,
        width: widget.cellWidth,
        child: Center(
          child: Text(
            topTitles[index],
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 10,
                color: widget.currentTitleIndex != null
                    ? widget.currentTitleIndex == index
                        ? Colors.blue
                        : Colors.grey[400]
                    : widget.selectedDate.weekday == index + 1
                        ? Colors.blue
                        : Colors.grey[400]),
          ),
        ),
      );
    });

    // widget.x is a topTile List
    widget.x.clear();

    // widget.y is a time List
    widget.y.clear();

    widget.indexList.clear();
    for (var element in widget.eventList) {
      widget.x.add(element.dayIndex);
      switch (element.time) {
        case "06:00 - 07:00":
          widget.y.add(0);
          break;
        case "07:00 - 08:00":
          widget.y.add(1);
          break;
        case "08:00 - 09:00":
          widget.y.add(2);
          break;
        case "09:00 - 10:00":
          widget.y.add(3);
          break;
        case "10:00 - 11:00":
          widget.y.add(4);
          break;
        case "11:00 - 12:00":
          widget.y.add(5);
          break;
        case "12:00 - 13:00":
          widget.y.add(6);
          break;
        case "13:00 - 14:00":
          widget.y.add(7);
          break;
        case "14:00 - 15:00":
          widget.y.add(8);
          break;
        case "15:00 - 16:00":
          widget.y.add(9);
          break;
        case "16:00 - 17:00":
          widget.y.add(10);
          break;
        case "17:00 - 18:00":
          widget.y.add(11);
          break;
        case "18:00 - 19:00":
          widget.y.add(12);
          break;
        case "19:00 - 20:00":
          widget.y.add(13);
          break;
        case "20:00 - 21:00":
          widget.y.add(14);
          break;
        case "21:00 - 22:00":
          widget.y.add(15);
          break;
        case "22:00 - 23:00":
          widget.y.add(16);
          break;
        case "23:00 - 24:00":
          widget.y.add(17);
          break;
      }
    }
    for (int i = 0; i < widget.x.length; i++) {
      widget.indexList.add(widget.x[i].toString() + widget.y[i].toString());
    }

    widget.mainHorizontalController.addListener(() {
      widget.dayHorizontalController
          .jumpTo(widget.mainHorizontalController.offset);
    });
    widget.mainVerticalController.addListener(() {
      widget.timeVerticalController
          .jumpTo(widget.mainVerticalController.offset);
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[50],
      body: Center(
          child: GestureDetector(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.isBack == true
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_ios_rounded,
                                size: 18, color: Colors.black),
                          )
                        : const SizedBox(
                            width: 18,
                          ),
                    widget.title != null
                        ? Text(widget.title!,
                            style: widget.titleStyle ??
                                const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold))
                        : const SizedBox(),
                    const SizedBox(
                      width: 18,
                    )
                  ],
                ),
              ),
            ),
            Divider(
              height: 1.6,
              color: Colors.grey[200],
              thickness: 1.8,
            ),
            Expanded(
              flex: 21,
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SingleChildScrollView(
                      controller: widget.dayHorizontalController,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          const SizedBox(
                            width: 84 + 1.6,
                          ),
                          for (int i = 0; i < topTitles.length; i++) headers[i],
                        ],
                      ),
                    ),
                    Container(
                      height: 1.6,
                      color: Colors.grey[200],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context)
                                .copyWith(scrollbars: false),
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: widget.timeVerticalController,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      //first number is start hour and second number is end hour
                                      for (int i = 6; i <= 23; i++)
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: widget.cellHeight,
                                              width: 84,
                                              child: Center(
                                                  child: Text(
                                                i < 10
                                                    ? "0$i:00 - ${i + 1}:00"
                                                    : "$i:00 - ${i + 1}:00",
                                                style: TextStyle(
                                                    color: Colors.grey[400]!,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 10),
                                              )),
                                            ),
                                            const SizedBox(
                                              height: 1.6,
                                            )
                                          ],
                                        ),
                                    ],
                                  ),
                                  Container(
                                    height: (18 * widget.cellHeight) + 18 * 1.6,
                                    width: 1.6,
                                    color: Colors.grey[200],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Scrollbar(
                              controller: widget.mainVerticalController,
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                controller: widget.mainVerticalController,
                                child: Scrollbar(
                                  controller: widget.mainHorizontalController,
                                  thumbVisibility: true,
                                  child: SingleChildScrollView(
                                    controller: widget.mainHorizontalController,
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SizedBox(
                                              height: (18 * widget.cellHeight) +
                                                  (18 * 1.6),
                                              width: (topTitles.length *
                                                  widget.cellWidth),
                                              child: Stack(
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      for (int i = 0;
                                                          i < 18;
                                                          i++)
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            Row(children: [
                                                              for (int j = 0;
                                                                  j <
                                                                      topTitles
                                                                          .length;
                                                                  j++)
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    widget
                                                                        .eventAlert
                                                                        .alertTextController
                                                                        .text = "";

                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return StatefulBuilder(
                                                                          builder: (context, state) => SchedulerAlert(
                                                                              isAdd: true,
                                                                              formKey: widget.formKey,
                                                                              textController: widget.eventAlert.alertTextController,
                                                                              alertTitle: widget.eventAlert.addAlertTitle,
                                                                              addButtonTitle: widget.eventAlert.addButtonTitle,
                                                                              selectedColor: widget.eventAlert.initialEventColor,
                                                                              borderRadius: widget.eventAlert.borderRadius,
                                                                              textFieldEmptyMessage: widget.eventAlert.textFieldEmptyValidateMessage,
                                                                              x: j,
                                                                              y: i,
                                                                              hintText: widget.eventAlert.hintText,
                                                                              colorWidget: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                children: [
                                                                                  ColorCircle(
                                                                                    size: MediaQuery.of(context).size.width * 0.08,
                                                                                    onTap: () {
                                                                                      state(() {
                                                                                        widget.eventAlert.initialEventColor = Colors.orange;
                                                                                      });
                                                                                    },
                                                                                    color: Colors.orange,
                                                                                    isSelected: widget.eventAlert.initialEventColor == Colors.orange ? true : false,
                                                                                  ),
                                                                                  ColorCircle(
                                                                                    size: MediaQuery.of(context).size.width * 0.08,
                                                                                    onTap: () {
                                                                                      state(() {
                                                                                        widget.eventAlert.initialEventColor = Colors.pink;
                                                                                      });
                                                                                    },
                                                                                    color: Colors.pink,
                                                                                    isSelected: widget.eventAlert.initialEventColor == Colors.pink ? true : false,
                                                                                  ),
                                                                                  ColorCircle(
                                                                                    size: MediaQuery.of(context).size.width * 0.08,
                                                                                    onTap: () {
                                                                                      state(() {
                                                                                        widget.eventAlert.initialEventColor = Colors.blue;
                                                                                      });
                                                                                    },
                                                                                    color: Colors.blue,
                                                                                    isSelected: widget.eventAlert.initialEventColor == Colors.blue ? true : false,
                                                                                  ),
                                                                                  ColorCircle(
                                                                                    size: MediaQuery.of(context).size.width * 0.08,
                                                                                    onTap: () {
                                                                                      state(() {
                                                                                        widget.eventAlert.initialEventColor = Colors.green;
                                                                                      });
                                                                                    },
                                                                                    color: Colors.green,
                                                                                    isSelected: widget.eventAlert.initialEventColor == Colors.green ? true : false,
                                                                                  ),
                                                                                  ColorCircle(
                                                                                    size: MediaQuery.of(context).size.width * 0.08,
                                                                                    onTap: () {
                                                                                      state(() {
                                                                                        widget.eventAlert.initialEventColor = Colors.deepPurpleAccent;
                                                                                      });
                                                                                    },
                                                                                    color: Colors.deepPurpleAccent,
                                                                                    isSelected: widget.eventAlert.initialEventColor == Colors.deepPurpleAccent ? true : false,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              addOnPressed: () {
                                                                                if (widget.formKey.currentState!.validate()) {
                                                                                  setState(() {
                                                                                    EventModel event = EventModel(color: widget.eventAlert.initialEventColor, title: widget.eventAlert.alertTextController.text, time: getTime(i), dayIndex: j);

                                                                                    widget.eventList.add(event);
                                                                                    widget.eventAlert.alertTextController.clear();

                                                                                    if (widget.eventAlert.addOnPressed != null) {
                                                                                      widget.eventAlert.addOnPressed!(event);
                                                                                    }
                                                                                  });
                                                                                  Navigator.of(context, rootNavigator: true).pop('dialog');
                                                                                }
                                                                              }),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    color: widget.currentTitleIndex !=
                                                                            null
                                                                        ? widget.currentTitleIndex ==
                                                                                j
                                                                            ? Colors.blueGrey[
                                                                                100]
                                                                            : Colors
                                                                                .white
                                                                        : widget.selectedDate.weekday ==
                                                                                j + 1
                                                                            ? Colors.blueGrey[100]
                                                                            : Colors.white,
                                                                    height: widget
                                                                        .cellHeight,
                                                                    width: widget
                                                                        .cellWidth,
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            4,
                                                                        vertical:
                                                                            4),
                                                                    child: widget
                                                                            .indexList
                                                                            .contains(j.toString() +
                                                                                i.toString())
                                                                        ? GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              widget.eventAlert.alertTextController.text = widget.eventList[widget.indexList.indexOf(j.toString() + i.toString())].title!;

                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return StatefulBuilder(
                                                                                    builder: (context, state) => SchedulerAlert(
                                                                                        isAdd: false,
                                                                                        formKey: widget.formKey,
                                                                                        textController: widget.eventAlert.alertTextController,
                                                                                        alertTitle: widget.eventAlert.editAlertTitle,
                                                                                        deleteButtonTitle: widget.eventAlert.deleteButtonTitle,
                                                                                        updateButtonTitle: widget.eventAlert.updateButtonTitle,
                                                                                        borderRadius: widget.eventAlert.borderRadius,
                                                                                        textFieldEmptyMessage: widget.eventAlert.textFieldEmptyValidateMessage,
                                                                                        x: j,
                                                                                        y: i,
                                                                                        hintText: widget.eventAlert.hintText,
                                                                                        colorWidget: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                          children: [
                                                                                            ColorCircle(
                                                                                              size: MediaQuery.of(context).size.width * 0.08,
                                                                                              onTap: () {
                                                                                                state(() {
                                                                                                  widget.eventAlert.initialEventColor = Colors.orange;
                                                                                                });
                                                                                              },
                                                                                              color: Colors.orange,
                                                                                              isSelected: widget.eventAlert.initialEventColor == Colors.orange ? true : false,
                                                                                            ),
                                                                                            ColorCircle(
                                                                                              size: MediaQuery.of(context).size.width * 0.08,
                                                                                              onTap: () {
                                                                                                state(() {
                                                                                                  widget.eventAlert.initialEventColor = Colors.pink;
                                                                                                });
                                                                                              },
                                                                                              color: Colors.pink,
                                                                                              isSelected: widget.eventAlert.initialEventColor == Colors.pink ? true : false,
                                                                                            ),
                                                                                            ColorCircle(
                                                                                              size: MediaQuery.of(context).size.width * 0.08,
                                                                                              onTap: () {
                                                                                                state(() {
                                                                                                  widget.eventAlert.initialEventColor = Colors.blue;
                                                                                                });
                                                                                              },
                                                                                              color: Colors.blue,
                                                                                              isSelected: widget.eventAlert.initialEventColor == Colors.blue ? true : false,
                                                                                            ),
                                                                                            ColorCircle(
                                                                                              size: MediaQuery.of(context).size.width * 0.08,
                                                                                              onTap: () {
                                                                                                state(() {
                                                                                                  widget.eventAlert.initialEventColor = Colors.green;
                                                                                                });
                                                                                              },
                                                                                              color: Colors.green,
                                                                                              isSelected: widget.eventAlert.initialEventColor == Colors.green ? true : false,
                                                                                            ),
                                                                                            ColorCircle(
                                                                                              size: MediaQuery.of(context).size.width * 0.08,
                                                                                              onTap: () {
                                                                                                state(() {
                                                                                                  widget.eventAlert.initialEventColor = Colors.deepPurpleAccent;
                                                                                                });
                                                                                              },
                                                                                              color: Colors.deepPurpleAccent,
                                                                                              isSelected: widget.eventAlert.initialEventColor == Colors.deepPurpleAccent ? true : false,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        deleteOnPressed: () {
                                                                                          setState(() {
                                                                                            EventModel eventModel = widget.eventList.elementAt(widget.indexList.indexOf(j.toString() + i.toString()));
                                                                                            widget.eventList.removeAt(widget.indexList.indexOf(j.toString() + i.toString()));

                                                                                            if (widget.eventAlert.deleteOnPressed != null) {
                                                                                              widget.eventAlert.deleteOnPressed!(eventModel);
                                                                                            }
                                                                                          });
                                                                                          Navigator.of(context, rootNavigator: true).pop('dialog');
                                                                                        },
                                                                                        updateOnPressed: () {
                                                                                          if (widget.formKey.currentState!.validate()) {
                                                                                            setState(() {
                                                                                              widget.eventList[widget.indexList.indexOf(j.toString() + i.toString())].color = widget.eventAlert.initialEventColor;
                                                                                              widget.eventList[widget.indexList.indexOf(j.toString() + i.toString())].title = widget.eventAlert.alertTextController.text;

                                                                                              if (widget.eventAlert.updateOnPressed != null) {
                                                                                                widget.eventAlert.updateOnPressed!(widget.eventList[widget.indexList.indexOf(j.toString() + i.toString())]);
                                                                                              }
                                                                                            });

                                                                                            Navigator.of(context, rootNavigator: true).pop('dialog');
                                                                                          }
                                                                                        }),
                                                                                  );
                                                                                },
                                                                              );
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(6),
                                                                                color: widget.eventList[widget.indexList.indexOf(j.toString() + i.toString())].color ?? Colors.teal,
                                                                              ),
                                                                              alignment: Alignment.center,
                                                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                                                              child: Tooltip(
                                                                                key: UniqueKey(),
                                                                                message: widget.eventList[widget.indexList.indexOf(j.toString() + i.toString())].title!,
                                                                                decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(14)),
                                                                                textStyle: const TextStyle(color: Colors.white, fontSize: 10),
                                                                                child: Text(
                                                                                  widget.eventList[widget.indexList.indexOf(j.toString() + i.toString())].title!,
                                                                                  style: widget.eventTitleStyle ??
                                                                                      const TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 8,
                                                                                      ),
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  maxLines: 2,
                                                                                  softWrap: true,
                                                                                  textAlign: TextAlign.center,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : const SizedBox(),
                                                                  ),
                                                                )
                                                            ]),
                                                            Divider(
                                                              height: 1.6,
                                                              color: Colors
                                                                  .grey[200],
                                                              thickness: 1.8,
                                                            ),
                                                          ],
                                                        )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      for (var i = 0;
                                                          i < topTitles.length;
                                                          i++)
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: widget
                                                                      .cellWidth -
                                                                  1.6,
                                                            ),
                                                            // The vertical lines that divides the columns
                                                            Container(
                                                              width: 1.6,
                                                              height: 18 *
                                                                      widget
                                                                          .cellHeight +
                                                                  18 * 1.6,
                                                              color: Colors
                                                                  .grey[200],
                                                            )
                                                          ],
                                                        )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

/// Method to get time of row index (i)
String getTime(int i) {
  switch (i) {
    case 0:
      return "06:00 - 07:00";
    case 1:
      return "07:00 - 08:00";
    case 2:
      return "08:00 - 09:00";
    case 3:
      return "09:00 - 10:00";
    case 4:
      return "10:00 - 11:00";
    case 5:
      return "11:00 - 12:00";
    case 6:
      return "12:00 - 13:00";
    case 7:
      return "13:00 - 14:00";
    case 8:
      return "14:00 - 15:00";
    case 9:
      return "15:00 - 16:00";
    case 10:
      return "16:00 - 17:00";
    case 11:
      return "17:00 - 18:00";
    case 12:
      return "18:00 - 19:00";
    case 13:
      return "19:00 - 20:00";
    case 14:
      return "20:00 - 21:00";
    case 15:
      return "21:00 - 22:00";
    case 16:
      return "22:00 - 23:00";
    case 17:
      return "23:00 - 24:00";
    default:
      return "00:00 - 00:00";
  }
}
