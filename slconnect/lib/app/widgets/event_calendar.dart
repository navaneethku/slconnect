import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:slconnect/app/widgets/calendar_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:slconnect/app/widgets/db.dart';

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({Key? key}) : super(key: key);

  @override
  State<EventCalendarScreen> createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  Map<String, List> mySelectedEvents = {};

  final titleController = TextEditingController();
  final descpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;

    loadPreviousEvents();
  }

  loadPreviousEvents() async {
    List<Map<String, dynamic>> events = await DB.query(CalendarItem.table);

    setState(() {
      mySelectedEvents = {};
      for (var event in events) {
        String date = event['date'];
        if (mySelectedEvents[date] != null) {
          mySelectedEvents[date]?.add(event);
        } else {
          mySelectedEvents[date] = [event];
        }
      }
    });
  }

  List _listOfDayEvents(DateTime dateTime) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return mySelectedEvents[formattedDate] ?? [];
  }

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add New Event',
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                ),
                TextField(
                  controller: descpController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            child: const Text('Add Event'),
            onPressed: () async {
              if (titleController.text.isEmpty &&
                  descpController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Required title and description'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              } else {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(_selectedDate!);
                CalendarItem event = CalendarItem(
                  id: DateTime.now().millisecondsSinceEpoch,
                  name: titleController.text,
                  date: formattedDate,
                );

                await DB.insert(CalendarItem.table, event);

                setState(() {
                  if (mySelectedEvents[formattedDate] != null) {
                    mySelectedEvents[formattedDate]?.add(event.toMap());
                  } else {
                    mySelectedEvents[formattedDate] = [event.toMap()];
                  }
                });

                titleController.clear();
                descpController.clear();
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2022),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: DateTime.now(),
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDate, selectedDay)) {
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _listOfDayEvents,
          ),
          ..._listOfDayEvents(_selectedDate!).map(
            (myEvents) => ListTile(
              leading: const Icon(
                Icons.done,
                color: Colors.teal,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Event Title:   ${myEvents['name']}'),
              ),
              subtitle: Text('Description:   ${myEvents['date']}'),
            ),
          ),
          ElevatedButton(
            onPressed: _showAddEventDialog,
            child: const Text("Add Event"),
          ),
        ],
      ),
    );
  }
}
