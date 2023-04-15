import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';

class TasksListScreen extends StatefulWidget {
  const TasksListScreen({super.key});

  @override
  State<TasksListScreen> createState() => _TasksListScreenState();
}

class DaySlot {
  final String time;
  String? title;
  String? description;
  bool isDone = false;

  DaySlot(
      {required this.time, this.title, this.description, this.isDone = false});
}

class _TasksListScreenState extends State<TasksListScreen> {
  DateTime _selectedDate = DateTime.now();

  List<DaySlot> slots = [
    DaySlot(
        time: '08 AM',
        title: 'Task 1',
        description: 'Butterfly Pea',
        isDone: false),
    DaySlot(
        time: '09 AM',
        title: 'Task 2',
        description: 'Butterfly Pea',
        isDone: false),
    DaySlot(time: '10 AM'),
    DaySlot(
        time: '11 AM',
        title: 'Task 3',
        description: 'Butterfly Pea',
        isDone: true),
    DaySlot(time: '12 PM'),
    DaySlot(time: '1 PM'),
    DaySlot(time: '2 PM'),
    DaySlot(time: '3 PM'),
    DaySlot(time: '4 PM'),
    DaySlot(time: '5 PM'),
    DaySlot(time: '6 PM'),
    DaySlot(time: '7 PM'),
    DaySlot(time: '8 PM'),
    DaySlot(
        time: '9 PM',
        title: 'Task 4',
        description: 'Butterfly Pea',
        isDone: false),
    DaySlot(
        time: '10 PM',
        title: 'Task 5',
        description: 'Butterfly Pea',
        isDone: true),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CalendarTimeline(
              initialDate: _selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onDateSelected: (date) {
                print('Selected date: $date');
                _selectedDate = date;
              },
              activeBackgroundDayColor: Color(0xFFDAE6E2),
              dayColor: Color(0xFF7FA999),
              activeDayColor: Color(0xFF7FA999),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                color: MyColors.silverColor,
                child: ListView.builder(
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(top: 0),
                    child: Row(
                      children: [
                        Container(
                          height: 150,
                          width: 75,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                slots[index].time,
                                style: TextStyle(fontSize: 15),
                              ),
                            )),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 150,
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  width: 4,
                                  height: 150,
                                  color: Color(0xFFADC8BE),
                                ),
                              ),
                              if (slots[index].title != null)
                                Center(
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFADC8BE),
                                        shape: BoxShape.circle),
                                  ),
                                )
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                                height: 150,
                                child: slots[index].title != null
                                    ? Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: BorderSide(
                                                color: Color(0xFF000000),
                                                width: 1),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/images/harvest.svg',
                                                      width: 32,
                                                      height: 32,
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          slots[index].title!,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          slots[index]
                                                              .description!,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  height: 1,
                                                  color: Color(0xFFADC8BE),
                                                ),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                        value:
                                                            slots[index].isDone,
                                                        activeColor: MyColors
                                                            .primaryColor,
                                                        onChanged: (changed) {
                                                          setState(() {
                                                            slots[index]
                                                                    .isDone =
                                                                changed!;
                                                          });
                                                        }),
                                                    Expanded(
                                                        child: Text(
                                                      'Finish Task',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Placeholder(
                                        color: Colors.transparent,
                                      )))
                      ],
                    ),
                  ),
                  itemCount: slots.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
