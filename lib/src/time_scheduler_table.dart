// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:time_scheduler_table/src/model/event_alert.dart';
import 'package:time_scheduler_table/src/model/event.dart';
import 'package:time_scheduler_table/src/widget/color_circle.dart';
import 'package:time_scheduler_table/src/widget/scheduler_alert.dart';

class TimeSchedulerTable extends StatefulWidget {
  TimeSchedulerTable({
    super.key,
    this.currentColumnTitleIndex,
    this.columnLabels,
    this.rowLabels,
    required this.eventList,
    required this.cellHeight,
    required this.cellWidth,
    required this.eventAlert,
    this.scrollColor,
    this.scrollTrackingColor,
    this.isScrollTrackingVisible,
  });

  /// The index indicating the currently selected column.
  final int? currentColumnTitleIndex;

  /// [eventList] is the list of [Event] containing events.
  final List<Event> eventList;

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

  /// [columnLabels] is list of column names. Default value is  ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"]
  final List<String>? columnLabels;

  /// [rowLabels] is list of row names. Default value is  ['06:00 - 07:00','07:00 - 08:00','08:00 - 09:00','09:00 - 10:00','10:00 - 11:00','11:00 - 12:00','12:00 - 13:00','13:00 - 14:00','14:00 - 15:00','15:00 - 16:00','16:00 - 17:00','17:00 - 18:00','18:00 - 19:00','19:00 - 20:00','20:00 - 21:00','21:00 - 22:00','22:00 - 23:00','23:00 - 24:00']
  final List<String>? rowLabels;

  /// [formKey] is key of TextFormField in [EventAlert]
  final formKey = GlobalKey<FormState>();

  /// [EventAlert] is the class containing all the properties of the alert.
  final EventAlert eventAlert;

  /// [scrollColor] is color of horizontal and vertical scrolls. Default value is Colors.deepOrange.withOpacity(0.5)
  final Color? scrollColor;

  /// [scrollTrackingColor] is tracking color of the scroll. Default value is Colors.deepOrange.withOpacity(0.1)
  final Color? scrollTrackingColor;

  /// scroll tracking visibility
  final bool? isScrollTrackingVisible;

  @override
  State<TimeSchedulerTable> createState() => _TimeSchedulerTableState();
}

class _TimeSchedulerTableState extends State<TimeSchedulerTable> {
  TextEditingController eventTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // columnTitles are table column names.
    List<String>? columnLabels = widget.columnLabels ??
        [
          "Mon",
          "Tue",
          "Wed",
          "Thur",
          "Fri",
          "Sat",
          "Sun",
        ];
    List<String>? rowLabels = widget.rowLabels ??
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
    List<Widget> headers = List.generate(columnLabels.length, (index) {
      return SizedBox(
        height: 32,
        width: widget.cellWidth,
        child: Center(
          child: Text(
            columnLabels[index],
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
    return Expanded(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[50],
        body: GestureDetector(
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
                      for (int i = 0; i < columnLabels.length; i++) headers[i]
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  //first number is start hour and second number is end hour
                                  for (int i = 0; i < rowLabels.length; i++)
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: widget.cellHeight,
                                          width: 84,
                                          child: Center(
                                            child: Text(
                                              rowLabels[i],
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
                                height: (rowLabels.length * widget.cellHeight) +
                                    rowLabels.length * 1.6,
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
                          thumbColor: widget.scrollColor ??
                              Colors.deepOrange.withOpacity(0.5),
                          interactive: true,
                          radius: const Radius.circular(8),
                          thickness: 3,
                          trackVisibility:
                              widget.isScrollTrackingVisible ?? true,
                          trackColor: widget.scrollTrackingColor ??
                              Colors.deepOrange.withOpacity(0.1),
                          child: SingleChildScrollView(
                            controller: widget.mainVerticalController,
                            child: RawScrollbar(
                              controller: widget.mainHorizontalController,
                              thumbVisibility: true,
                              thumbColor: widget.scrollColor ??
                                  Colors.deepOrange.withOpacity(0.5),
                              interactive: true,
                              radius: const Radius.circular(8),
                              thickness: 3,
                              trackVisibility:
                                  widget.isScrollTrackingVisible ?? true,
                              trackColor: widget.scrollTrackingColor ??
                                  Colors.deepOrange.withOpacity(0.1),
                              child: SingleChildScrollView(
                                controller: widget.mainHorizontalController,
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(
                                          height: (rowLabels.length *
                                                  widget.cellHeight) +
                                              (rowLabels.length * 1.6),
                                          width: (columnLabels.length *
                                              widget.cellWidth),
                                          child: Stack(
                                            children: <Widget>[
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  for (int i = 0;
                                                      i < rowLabels.length;
                                                      i++)
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Row(children: [
                                                          for (int j = 0;
                                                              j <
                                                                  columnLabels
                                                                      .length;
                                                              j++)
                                                            GestureDetector(
                                                              onTap: () {
                                                                eventTextController
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
                                                                          textController: eventTextController,
                                                                          alertTitle: widget.eventAlert.addAlertTitle,
                                                                          addButtonTitle: widget.eventAlert.addButtonTitle,
                                                                          selectedColor: widget.eventAlert.initialEventColor,
                                                                          textFieldEmptyMessage: widget.eventAlert.textFieldEmptyValidateMessage,
                                                                          x: j,
                                                                          y: i,
                                                                          hintText: widget.eventAlert.hintText,
                                                                          colorWidget: Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
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
                                                                                Event event = Event(
                                                                                  color: widget.eventAlert.initialEventColor,
                                                                                  title: eventTextController.text,
                                                                                  rowIndex: i,
                                                                                  columnIndex: j,
                                                                                );

                                                                                widget.eventList.add(event);
                                                                                eventTextController.clear();

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
                                                              child: Container(
                                                                color: widget
                                                                            .currentColumnTitleIndex !=
                                                                        null
                                                                    ? widget.currentColumnTitleIndex ==
                                                                            j
                                                                        ? Colors.blueGrey[
                                                                            100]
                                                                        : Colors
                                                                            .white
                                                                    : widget.selectedDate.weekday ==
                                                                            j +
                                                                                1
                                                                        ? Colors.blueGrey[
                                                                            100]
                                                                        : Colors
                                                                            .white,
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
                                                                          eventTextController.text = widget
                                                                              .eventList[widget.indexList.indexOf(j.toString() + i.toString())]
                                                                              .title!;

                                                                          showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return StatefulBuilder(
                                                                                builder: (context, state) => SchedulerAlert(
                                                                                    isAdd: false,
                                                                                    formKey: widget.formKey,
                                                                                    textController: eventTextController,
                                                                                    alertTitle: widget.eventAlert.editAlertTitle,
                                                                                    deleteButtonTitle: widget.eventAlert.deleteButtonTitle,
                                                                                    updateButtonTitle: widget.eventAlert.updateButtonTitle,
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
                                                                                        Event eventModel = widget.eventList.elementAt(widget.indexList.indexOf(j.toString() + i.toString()));
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
                                                                                              .title = eventTextController.text;

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
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(6),
                                                                            color: widget
                                                                                    .eventList[widget.indexList.indexOf(
                                                                                  j.toString() + i.toString(),
                                                                                )]
                                                                                    .color ??
                                                                                Colors.teal,
                                                                          ),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                4,
                                                                            vertical:
                                                                                0,
                                                                          ),
                                                                          child:
                                                                              Tooltip(
                                                                            key:
                                                                                UniqueKey(),
                                                                            message: widget
                                                                                .eventList[widget.indexList.indexOf(
                                                                              j.toString() + i.toString(),
                                                                            )]
                                                                                .title!,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.transparent,
                                                                              borderRadius: BorderRadius.circular(14),
                                                                            ),
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                                                            textStyle: TextStyle(
                                                                                color: widget
                                                                                    .eventList[widget.indexList.indexOf(
                                                                                  j.toString() + i.toString(),
                                                                                )]
                                                                                    .color,
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w500),
                                                                            child:
                                                                                Text(
                                                                              widget
                                                                                  .eventList[widget.indexList.indexOf(
                                                                                j.toString() + i.toString(),
                                                                              )]
                                                                                  .title!,
                                                                              style: const TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 9,
                                                                                fontWeight: FontWeight.w500,
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
                                                          color:
                                                              Colors.grey[200],
                                                          thickness: 1.8,
                                                        ),
                                                      ],
                                                    )
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  for (var i = 0;
                                                      i < columnLabels.length;
                                                      i++)
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        SizedBox(
                                                          width:
                                                              widget.cellWidth -
                                                                  1.6,
                                                        ),
                                                        // The vertical lines that divides the columns
                                                        Container(
                                                          width: 1.6,
                                                          height: rowLabels
                                                                      .length *
                                                                  widget
                                                                      .cellHeight +
                                                              rowLabels.length *
                                                                  1.6,
                                                          color:
                                                              Colors.grey[200],
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
      ),
    );
  }
}
