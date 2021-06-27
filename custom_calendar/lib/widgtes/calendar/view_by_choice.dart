import 'package:custom_calendar/utils/constants.dart';
import 'package:custom_calendar/widgtes/widgets.dart';
import 'package:flutter/material.dart';

class ViewByChoiceClass {
  static DateTime backLimitDate = Constants.backLimitDate;
  static DateTime frontLimitDate = Constants.frontLimitDate;

  static List<Widget> viewByChoice(
      {required ViewByChoices choice, required Brightness textColor}) {
    switch (choice) {
      case ViewByChoices.viewByMonth:
        return viewByMonth(textColor: textColor);

      case ViewByChoices.viewByYear:
        return viewByYear(textColor: textColor);

      default:
        return [];
    }
  }

  static List<Widget> viewByMonth({required Brightness textColor}) {
    List<Widget> monthsList = [];
    int numberOfMonths = (frontLimitDate.year - backLimitDate.year) * 12;
    for (int index = 1; index <= numberOfMonths; index++) {
      final dateTime = DateTime(
          backLimitDate.year, backLimitDate.month + index, backLimitDate.day);

      monthsList.add(MonthWidget(
        dateTime: dateTime,
        textColor: textColor,
      ));
    }
    print('months lenght :::' + monthsList.length.toString());
    return monthsList;
  }

  static List<Widget> viewByYear({required Brightness textColor}) {
    List<Widget> yearList = [];
    int numberOfYears = (frontLimitDate.year - backLimitDate.year);
    for (int index = 1; index <= numberOfYears; index++) {
      final dateTime = DateTime(
          backLimitDate.year, backLimitDate.month + index, backLimitDate.day);

      yearList.add(YearWidget(dateTime: dateTime, textColor: textColor));
    }

    return yearList;
  }
}
