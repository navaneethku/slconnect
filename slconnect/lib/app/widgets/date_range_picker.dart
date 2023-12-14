import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slconnect/consts/colors.dart';
import 'package:slconnect/consts/common_styles.dart';

class DateRangePickerWidget extends StatefulWidget {
  final Function(DateTime _startDate, DateTime _endDate) onDateRangeSelected;

  const DateRangePickerWidget({
    Key? key,
    required this.onDateRangeSelected,
  }) : super(key: key);

  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? dateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
    );

    if (dateRange != null) {
      setState(() {
        _startDate = dateRange.start;
        _endDate = dateRange.end;
      });
      print(_startDate);
      widget.onDateRangeSelected(_startDate, _endDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDateRange(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Start",
                  style: mediumWhiteBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(16))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: primary,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        DateFormat.yMMMd().format(_startDate),
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "End",
                  style: mediumWhiteBold,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(16))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: primary,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        DateFormat.yMMMd().format(_endDate),
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
