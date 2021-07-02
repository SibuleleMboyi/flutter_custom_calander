import 'package:custom_calendar/cubit/date_change_cubit_dart_cubit.dart';
import 'package:custom_calendar/utils/constants.dart';
import 'package:custom_calendar/widgtes/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MonthWidget extends StatelessWidget {
  final DateTime dateTime;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double leftPadding;
  final double topPadding;
  final Brightness textColor;
  final ViewByChoices viewByChoices;

  const MonthWidget({
    Key? key,
    required this.dateTime,
    this.mainAxisSpacing = 60.0,
    this.crossAxisSpacing = 10,
    this.leftPadding = 30,
    this.topPadding = 50,
    this.viewByChoices = ViewByChoices.viewByMonth,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewPort = creatMonth(
        date: dateTime, textColor: textColor, viewByChoices: viewByChoices);

    return BlocBuilder<DateChangeCubitDartCubit, DateChangeCubitDartState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.fromLTRB(leftPadding, topPadding, 0, 0),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: viewPort[1].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: mainAxisSpacing,
                //mainAxisSpacing: 10,
                crossAxisSpacing: 0,
                crossAxisCount: 7,
              ),
              itemBuilder: (context, index) {
                bool isCurrentMonth = false;

                if (ViewByChoices.viewByMonth == viewByChoices) {
                  int i = 0;
                  while (isCurrentMonth == false && i < viewPort[1].length) {
                    if (viewPort[1][i] is! Text) {
                      isCurrentMonth = true;
                    }
                    i += 1;
                  }
                }
                return GestureDetector(
                  onTap: () => ViewByChoices.viewByMonth == viewByChoices
                      ? configureTappedDate(
                          context: context,
                          viewPort: viewPort,
                          index: index,
                        )
                      : {},
                  child: animatedGridCell(
                    widget: viewPort[1][index],
                    animatedWidget: state.animatedWidget,
                    stateDateTime: state.selectedDate,
                    isSelected: state.isSelected,
                    hasPaged: state.hasPaged,
                    isCurrentMonth: isCurrentMonth,
                    isInstanceOfText: (viewPort[1][index]) is Text,
                    isWithinMonth: index < (viewPort[1].length - viewPort[2]),
                    index: index,
                    stateIndex: state.selectedIndex,
                    viewByMonth: ViewByChoices.viewByMonth == viewByChoices,
                  ),
                );
              }),
        );
      },
    );
  }

  Widget animatedGridCell({
    required dynamic widget,
    required Widget animatedWidget,
    required DateTime stateDateTime,
    required bool isSelected,
    required int index,
    required bool hasPaged,
    required bool isCurrentMonth,
    required bool isInstanceOfText,
    required bool isWithinMonth,
    required int stateIndex,
    required bool viewByMonth,
  }) {
    if (!isSelected && !isInstanceOfText && stateIndex != -1 && viewByMonth) {
      return SelectedDateMarker(child: widget);
    } else if (!isSelected &&
        !isCurrentMonth &&
        isInstanceOfText &&
        stateDateTime.day.toString() == widget.data &&
        hasPaged &&
        isWithinMonth &&
        viewByMonth) {
      return SelectedDateMarker(child: widget);
    } else if (!isSelected &&
        hasPaged &&
        !isInstanceOfText &&
        isWithinMonth &&
        viewByMonth) {
      return SelectedDateMarker(child: widget);
    } else if (index == stateIndex && viewByMonth) {
      return animatedWidget;
    } else {
      return widget;
    }
  }

  void configureTappedDate({
    required BuildContext context,
    required List viewPort,
    required int index,
  }) {
    if ((index) <= (viewPort[0] - 1)) {
      //print('checks if tapping visible previous month's days');
      context.read<DateChangeCubitDartCubit>().isPrevMonthDay(
            isPrevMonthDay: true,
          );
    } else if ((index) >= (viewPort[1].length - viewPort[2])) {
      //print('checks if tapping visible next month's days');
      context.read<DateChangeCubitDartCubit>().isNextMonthDay(
            isNextMonthDay: true,
          );
    } else {
      //selected date is within the current month.
      // takes the current tapped index
      context.read<DateChangeCubitDartCubit>().selectedDate(
            isSelected: true,
            index: index,
          );

      context.read<DateChangeCubitDartCubit>().animWidget(
            widget: SelectedDateMarker(child: viewPort[1][index]),
          );
    }
  }

  // Create a Month
  // Appends visible previous month days into the viewport of this month, and color them grey.
  // Appends visible next month days into the viewport of this month, and color them grey.
  List<dynamic> creatMonth(
      {required DateTime date,
      required Brightness textColor,
      required ViewByChoices viewByChoices}) {
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
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
        );
      }
    }
    final monthCheck = visiblePrevMonthDays + currentMothDays;

    int trackLen = 0;
    for (int index = 1; index <= currentMonthNumOfDays; index++) {
      trackLen = monthCheck.length + 1;
      monthCheck.add(
        DateTime(date.year, date.month, index) ==
                DateTime(
                  Constants.currentDate.year,
                  Constants.currentDate.month,
                  Constants.currentDate.day,
                )
            ? Wrap(
                children: [
                  Container(
                    height:
                        ViewByChoices.viewByMonth != viewByChoices ? 15 : 25,
                    width: ViewByChoices.viewByMonth != viewByChoices ? 15 : 25,
                    decoration: BoxDecoration(
                      color: trackLen % 7 == 0 ? Colors.red[700] : Colors.green,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Text(
                        index.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ViewByChoices.viewByMonth == viewByChoices
                              ? 15
                              : 10,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Text(
                index.toString(),
                style: TextStyle(
                  fontSize:
                      ViewByChoices.viewByMonth == viewByChoices ? 15 : 10,
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

    int viewPortLenght = monthCheck.length;
    int check = 0;
    if (viewByChoices == ViewByChoices.viewByMonth) {
      while (viewPortLenght < 42) {
        check = viewPortLenght + 1;
        visibleNextMonthDays.add(
          check % 7 == 0
              ? Text(
                  index.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.red[300]),
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

    return [
      visiblePrevMonthDays.length,
      monthCheck + visibleNextMonthDays,
      visibleNextMonthDays.length
    ];
  }
}
