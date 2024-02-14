// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:time_scheduler_table/src/model/event_alert.dart';
import 'package:time_scheduler_table/src/model/event_model.dart';
import 'package:time_scheduler_table/src/widget/color_circle.dart';
import 'package:time_scheduler_table/src/widget/scheduler_alert.dart';

class TimeSchedulerTable extends StatefulWidget {
  TimeSchedulerTable({
    super.key,
    this.title,
    this.titleStyle,
    this.eventTitleStyle,
    this.isBack = true,
    this.currentColumnTitleIndex,
    this.columnTitles,
    this.rowTitles,
    required this.eventList,
    required this.cellHeight,
    required this.cellWidth,
    required this.eventAlert,
  });

  /// [title] is title of table
  final String? title;

  /// [titleStyle] is text style of table's title
  final TextStyle? titleStyle;

  /// [eventTitleStyle] is text style of event's title in cells
  final TextStyle? eventTitleStyle;

  /// [isBack] is the button that allows to go back. Default value is true.
  final bool isBack;

  /// The index indicating the currently selected column.
  final int? currentColumnTitleIndex;

  /// [eventList] is the list of [EventModel] containing events.
  final List<EventModel> eventList;

  /// [cellHeight] is the height of cells in table.
  final double cellHeight;

  /// [cellWidth] is the width of cells in table.
  final double cellWidth;

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

  /// [columnTitles] is list of column names.
  final List<String>? columnTitles;

  /// [rowTitles] is list of row names.
  final List<String>? rowTitles;

  /// [formKey] is key of TextFormField in [EventAlert]
  final formKey = GlobalKey<FormState>();

  /// [EventAlert] is the class containing all the properties of the alert.
  final EventAlert eventAlert;

  @override
  State<TimeSchedulerTable> createState() => _TimeSchedulerTableState();
}

class _TimeSchedulerTableState extends State<TimeSchedulerTable> {
  @override
  Widget build(BuildContext context) {
    // columnTitles are table column names.
    List<String>? columnTitles = widget.columnTitles ??
        [
          "Mon",
          "Tue",
          "Wed",
          "Thur",
          "Fri",
          "Sat",
          "Sun",
        ];
    List<String>? rowTitles = widget.rowTitles ??
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
          '23:00 - 24:00',
        ];

    // headers is a widget list containing table column names.
    List<Widget> headers = List.generate(columnTitles.length, (index) {
      return SizedBox(
        height: 32,
        width: widget.cellWidth,
        child: Center(
          child: Text(
            columnTitles[index],
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 9,
                color: widget.currentColumnTitleIndex != null
                    ? widget.currentColumnTitleIndex == index
                        ? Colors.blue
                        : Colors.grey[500]
                    : widget.selectedDate.weekday == index + 1
                        ? Colors.blue
                        : Colors.grey[500]),
          ),
        ),
      );
    });

    widget.x.clear();
    widget.y.clear();
    widget.indexList.clear();

    for (var element in widget.eventList) {
      widget.x.add(element.columnIndex);
      widget.y.add(element.rowIndex);
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
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.isBack == true
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 18,
                              color: Colors.black,
                            ),
                          )
                        : const SizedBox(
                            width: 18,
                          ),
                    widget.title != null
                        ? Text(
                            widget.title!,
                            style: widget.titleStyle ??
                                const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                          )
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
                          for (int i = 0; i < columnTitles.length; i++)
                            headers[i]
                        ],
                      ),
                    ),
                    Container(
                      height: 1.6,
                      color: Colors.grey[200],
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(
                              scrollbars: false,
                            ),
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
                                      for (int i = 0; i < rowTitles.length; i++)
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: widget.cellHeight,
                                              width: 84,
                                              child: Center(
                                                child: Text(
                                                  rowTitles[i],
                                                  style: TextStyle(
                                                    color: Colors.grey[500] ??
                                                        Colors.grey,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 1.6,
                                            )
                                          ],
                                        ),
                                    ],
                                  ),
                                  Container(
                                    height:
                                        (rowTitles.length * widget.cellHeight) +
                                            rowTitles.length * 1.6,
                                    width: 1.6,
                                    color: Colors.grey[200],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: RawScrollbar(
                              controller: widget.mainVerticalController,
                              thumbVisibility: true,
                              thumbColor: Colors.deepOrange.withOpacity(0.6),
                              interactive: true,
                              radius: const Radius.circular(8),
                              thickness: 3,
                              trackVisibility: true,
                              trackColor: Colors.deepOrange.withOpacity(0.1),
                              child: SingleChildScrollView(
                                controller: widget.mainVerticalController,
                                child: RawScrollbar(
                                  controller: widget.mainHorizontalController,
                                  thumbVisibility: true,
                                  thumbColor:
                                      Colors.deepOrange.withOpacity(0.6),
                                  interactive: true,
                                  radius: const Radius.circular(8),
                                  thickness: 3,
                                  trackVisibility: true,
                                  trackColor:
                                      Colors.deepOrange.withOpacity(0.1),
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
                                              height: (rowTitles.length *
                                                      widget.cellHeight) +
                                                  (rowTitles.length * 1.6),
                                              width: (columnTitles.length *
                                                  widget.cellWidth),
                                              child: Stack(
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      for (int i = 0;
                                                          i < rowTitles.length;
                                                          i++)
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            Row(children: [
                                                              for (int j = 0;
                                                                  j <
                                                                      columnTitles
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
                                                                                    EventModel event = EventModel(
                                                                                      color: widget.eventAlert.initialEventColor,
                                                                                      title: widget.eventAlert.alertTextController.text,
                                                                                      rowIndex: i,
                                                                                      columnIndex: j,
                                                                                    );

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
                                                                    color: widget.currentColumnTitleIndex !=
                                                                            null
                                                                        ? widget.currentColumnTitleIndex ==
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
                                                                                            widget.eventList.removeAt(
                                                                                              widget.indexList.indexOf(
                                                                                                j.toString() + i.toString(),
                                                                                              ),
                                                                                            );

                                                                                            if (widget.eventAlert.deleteOnPressed != null) {
                                                                                              widget.eventAlert.deleteOnPressed!(eventModel);
                                                                                            }
                                                                                          });
                                                                                          Navigator.of(context, rootNavigator: true).pop('dialog');
                                                                                        },
                                                                                        updateOnPressed: () {
                                                                                          if (widget.formKey.currentState!.validate()) {
                                                                                            setState(() {
                                                                                              widget
                                                                                                  .eventList[widget.indexList.indexOf(
                                                                                                j.toString() + i.toString(),
                                                                                              )]
                                                                                                  .color = widget.eventAlert.initialEventColor;
                                                                                              widget
                                                                                                  .eventList[widget.indexList.indexOf(
                                                                                                j.toString() + i.toString(),
                                                                                              )]
                                                                                                  .title = widget.eventAlert.alertTextController.text;

                                                                                              if (widget.eventAlert.updateOnPressed != null) {
                                                                                                widget.eventAlert.updateOnPressed!(widget.eventList[widget.indexList.indexOf(
                                                                                                  j.toString() + i.toString(),
                                                                                                )]);
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
                                                                                color: widget
                                                                                        .eventList[widget.indexList.indexOf(
                                                                                      j.toString() + i.toString(),
                                                                                    )]
                                                                                        .color ??
                                                                                    Colors.teal,
                                                                              ),
                                                                              alignment: Alignment.center,
                                                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                                                              child: Tooltip(
                                                                                key: UniqueKey(),
                                                                                message: widget
                                                                                    .eventList[widget.indexList.indexOf(
                                                                                  j.toString() + i.toString(),
                                                                                )]
                                                                                    .title!,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.black.withOpacity(0.7),
                                                                                  borderRadius: BorderRadius.circular(14),
                                                                                ),
                                                                                textStyle: const TextStyle(color: Colors.white, fontSize: 10),
                                                                                child: Text(
                                                                                  widget
                                                                                      .eventList[widget.indexList.indexOf(
                                                                                    j.toString() + i.toString(),
                                                                                  )]
                                                                                      .title!,
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
                                                          i <
                                                              columnTitles
                                                                  .length;
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
                                                              height: rowTitles
                                                                          .length *
                                                                      widget
                                                                          .cellHeight +
                                                                  rowTitles
                                                                          .length *
                                                                      1.6,
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
