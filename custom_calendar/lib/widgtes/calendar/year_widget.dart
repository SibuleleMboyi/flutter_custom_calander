import 'package:custom_calendar/utils/constants.dart';
import 'package:custom_calendar/widgtes/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YearWidget extends StatelessWidget {
  final DateTime dateTime;
  final Brightness textColor;

  const YearWidget({
    Key? key,
    required this.dateTime,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return creatYear(dateTime: dateTime);
  }

  Widget creatYear({required DateTime dateTime}) {
    //print('senddddddddd +++++++' + dateTime.toString());

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 12,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        //mainAxisSpacing: 0,
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        final month = yearMonths(dateTime: dateTime)[index];
        return month;
      },
    );
  }

  List<Widget> yearMonths({required DateTime dateTime}) {
    List<Widget> year = [];
    List<String> dayNames = Constants.dayNames;
    // print('this +++++++' + dateTime.toString());
    for (int index = 0; index < 12; index++) {
      final date =
          DateTime(dateTime.year, dateTime.month + index, dateTime.day);

      // print('that +++++++' + date.toString());
      year.add(Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
        child: Stack(
          children: [
            Text(DateFormat.MMMM().format(date)),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dayNames.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //childAspectRatio: ,
                    crossAxisSpacing: 1,
                    //mainAxisExtent: 20,
                    crossAxisCount: 7,
                  ),
                  itemBuilder: (context, index) {
                    return Text(dayNames[index]);
                  }),
            ),
            MonthWidget(
              dateTime: date,
              mainAxisSpacing: 0,
              textColor: textColor,
              crossAxisSpacing: 5,
              viewByChoices: ViewByChoices.viewByYear,
            ),
          ],
        ),
      ));
    }

    return year;
  }
}
