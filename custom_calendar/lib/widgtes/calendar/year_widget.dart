import 'package:custom_calendar/cubit/date_change_cubit_dart_cubit.dart';
import 'package:custom_calendar/utils/constants.dart';
import 'package:custom_calendar/widgtes/calendar/viewby_month.dart';
import 'package:custom_calendar/widgtes/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class YearWidget extends StatelessWidget {
  final DateTime dateTime;
  final Brightness textColor;
  static int intialPageInitialization = 31;

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

    return BlocBuilder<DateChangeCubitDartCubit, DateChangeCubitDartState>(
      builder: (context, state) {
        return GridView.builder(
          //physics: NeverScrollableScrollPhysics(),
          itemCount: 12,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            mainAxisSpacing: 40,
            childAspectRatio:
                0.9, // controlls the size of each grid element or item
            //mainAxisSpacing: 0,
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            final month = yearMonths(dateTime: dateTime)[index];
            return GestureDetector(
              onTap: () {
                context.read<DateChangeCubitDartCubit>().viewBy(
                      viewByChoices: ViewByChoices.viewByMonth,
                    );
                int initialPage =
                    ((dateTime.year - Constants.backLimitDate.year) * 12) +
                        index -
                        1;
                context.read<DateChangeCubitDartCubit>().initPage(
                      initialPage: initialPage,
                    );

                intialPageInitialization = initialPage;

                context.read<DateChangeCubitDartCubit>().dateChanged(
                      newDate: DateTime(dateTime.year, index + 1, 01),
                    );

                // TODO create Route for this method to work
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewByMonth(
                              results: [],
                              dayNames: Constants.dayNames,
                              oldIndex: 0,
                              currentDate: dateTime,
                              intialPageInitialization: initialPage,
                            )));
              },
              child: month,
            );
          },
        );
      },
    );
  }

  List<Widget> yearMonths({required DateTime dateTime}) {
    List<Widget> year = [];
    List<String> dayNames = Constants.dayNames;

    for (int index = 0; index < 12; index++) {
      final date =
          DateTime(dateTime.year, dateTime.month + index, dateTime.day);

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
                    return Text(
                      dayNames[index],
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    );
                  }),
            ),
            MonthWidget(
              dateTime: date,
              mainAxisSpacing: 0,
              topPadding: 40,
              leftPadding: 0,
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
