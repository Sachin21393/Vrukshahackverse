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
    DaySlot(time: '12 PM'),
    DaySlot(time: '1 PM'),
    DaySlot(
        time: '2 PM', title: 'Watering', description: 'Clivia', isDone: false),
    DaySlot(time: '3 PM'),
    DaySlot(
        time: '4 PM',
        title: 'Watering',
        description: 'Leten Rose',
        isDone: false),
    DaySlot(time: '5 PM'),
    DaySlot(time: '6 PM'),
    DaySlot(
        time: '7 PM',
        title: 'Task 4',
        description: 'Butterfly Pea',
        isDone: false),
    DaySlot(time: '8 PM'),
    DaySlot(time: '9 PM'),
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
        appBar: AppBar(
          backgroundColor: MyColors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            'Tasks',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ),
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
              activeBackgroundDayColor: const Color(0xFFDAE6E2),
              dayColor: const Color(0xFF7FA999),
              activeDayColor: const Color(0xFF7FA999),
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
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                slots[index].time,
                                style: const TextStyle(fontSize: 15),
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
                                  color: const Color(0xFFADC8BE),
                                ),
                              ),
                              if (slots[index].title != null)
                                Center(
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: const BoxDecoration(
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
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: const BorderSide(
                                                color: Color(0xFF000000),
                                                width: 1),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    SvgPicture.asset(
                                                      'assets/images/harvest.svg',
                                                      width: 32,
                                                      height: 32,
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          slots[index].title!,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          slots[index]
                                                              .description!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  height: 1,
                                                  color:
                                                      const Color(0xFFADC8BE),
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
                                                    const Expanded(
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
                                    : const Placeholder(
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
