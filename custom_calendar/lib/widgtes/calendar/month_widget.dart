import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthWidget extends StatelessWidget {
  final DateTime dateTime;
  final double mainAxisSpacing;
  final Brightness textColor;

  const MonthWidget(
      {Key? key,
      required this.dateTime,
      this.mainAxisSpacing = 60.0,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewPort = creatMonth(date: dateTime, textColor: textColor);
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 60, 0, 0),
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: viewPort.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: mainAxisSpacing,
            //mainAxisSpacing: 10,
            crossAxisSpacing: 0,
            crossAxisCount: 7,
          ),
          itemBuilder: (context, index) {
            return viewPort[index];
          }),
    );
  }

  // Create a Month
  // Appends visible previous month days into the viewport of this month, and color them grey.
  // Appends visible next month days into the viewport of this month, and color them grey.
  List<Widget> creatMonth(
      {required DateTime date, required Brightness textColor}) {
    List<Widget> visiblePrevMonthDays = [];
    List<Widget> visibleNextMonthDays = [];
    List<Widget> currentMothDays = [];

    final prevMonthLastDate = DateTime(date.year, date.month, 0);
    String prvMonthNumOfDays = DateFormat.d().format(prevMonthLastDate);
    int prevMonthNumOfDays = int.parse(prvMonthNumOfDays);

    final currentMonthLastDate = DateTime(date.year, date.month + 1, 0);
    String currntMonthNumOfDays = DateFormat.d().format(currentMonthLastDate);
    int currentMonthNumOfDays = int.parse(currntMonthNumOfDays);

    final currentMonthFirstDayNumber =
        DateTime(date.year, date.month, 01).weekday;

    if (currentMonthFirstDayNumber != 1) {
      int patchFrom = prevMonthNumOfDays - currentMonthFirstDayNumber + 1;
      for (int index = 1; index < currentMonthFirstDayNumber; index++) {
        visiblePrevMonthDays.add(
          Text(
            (patchFrom + index).toString(),
            style: TextStyle(color: Colors.grey),
          ),
        );
      }
    }

    for (int index = 1; index <= currentMonthNumOfDays; index++) {
      currentMothDays.add(
        Text(
          index.toString(),
          style: TextStyle(
            color: textColor == Brightness.light ? Colors.black : Colors.white,
          ),
        ),
      );
    }

    int viewPortLenght = visiblePrevMonthDays.length + currentMothDays.length;

    int index = 1;
    while (viewPortLenght < 42) {
      visibleNextMonthDays.add(
        Text(
          index.toString(),
          style: TextStyle(color: Colors.grey),
        ),
      );

      index += 1;
      viewPortLenght += 1;
    }

    return visiblePrevMonthDays + currentMothDays + visibleNextMonthDays;
  }
}
