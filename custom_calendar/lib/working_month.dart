/* import 'package:custom_calendar/cubit/date_change_cubit_dart_cubit.dart';
import 'package:custom_calendar/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MonthWidget extends StatelessWidget {
  final DateTime dateTime;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final Brightness textColor;
  final ViewByChoices viewByChoices;

  const MonthWidget(
      {Key? key,
      required this.dateTime,
      this.mainAxisSpacing = 60.0,
      this.crossAxisSpacing = 10,
      this.viewByChoices = ViewByChoices.viewByMonth,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewPort = creatMonth(date: dateTime, textColor: textColor);
    return BlocBuilder<DateChangeCubitDartCubit, DateChangeCubitDartState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
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
                return GestureDetector(
                  onTap: () {
                    Text text = Text('Mandelaaaaaaaaaaaaaaaaaaaaaaa');
                    print(text.data.toString());

                    print('tapped::::' + index.toString());
                    context.read<DateChangeCubitDartCubit>().selectedDate(
                          !state.isSelected,
                        ); // isSelected is initially 'false'. This sets it to 'true.
                  },
                  child: state.isSelected == true && index == index
                      ? Container(
                          decoration: BoxDecoration(
                            //color: Colors.yellow,
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: viewPort[index],
                        )
                      : viewPort[index],
                );
              }),
        );
      },
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
            viewByChoices == ViewByChoices.viewByMonth
                ? (patchFrom + index).toString()
                : '',
            style: TextStyle(color: Colors.grey),
          ),
        );
      }
    }
    final monthCheck = visiblePrevMonthDays + currentMothDays;
    print(date);
    final currentDate = DateTime.now();
    int trackLen = 0;
    for (int index = 1; index <= currentMonthNumOfDays; index++) {
      trackLen = monthCheck.length + 1;
      monthCheck.add(
        DateTime(date.year, date.month, index) ==
                DateTime(currentDate.year, currentDate.month, currentDate.day)
            ? Wrap(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: trackLen % 7 == 0 ? Colors.red[700] : Colors.green,
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Text(
                      index.toString(),
                      style: TextStyle(
                        color: textColor == Brightness.light
                            ? trackLen % 7 == 0
                                ? Colors.white
                                : Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            : Text(
                index.toString(),
                style: TextStyle(
                  color: textColor == Brightness.light
                      ? trackLen % 7 == 0
                          ? Colors.red[700]
                          : Colors.black
                      : trackLen % 7 == 0
                          ? Colors.red[700]
                          : Colors.white,
                ),
              ),
      );
    }

    int index = 1;

    print('added next days :::::::::::::::::');
    int viewPortLenght = monthCheck.length;
    int check = 0;
    if (viewByChoices == ViewByChoices.viewByMonth) {
      while (viewPortLenght < 42) {
        check = viewPortLenght + 1;
        visibleNextMonthDays.add(
          check % 7 == 0
              ? Text(
                  index.toString(),
                  style: TextStyle(color: Colors.red[300]),
                )
              : Text(
                  index.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
        );
        index += 1;
        viewPortLenght += 1;
      }
    }

    return monthCheck + visibleNextMonthDays;
  }
} */
