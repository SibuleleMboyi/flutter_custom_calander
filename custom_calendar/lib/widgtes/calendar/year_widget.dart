import 'package:custom_calendar/cubit/date_change_cubit_dart_cubit.dart';
import 'package:custom_calendar/utils/constants.dart';
import 'package:custom_calendar/widgtes/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class YearWidget extends StatelessWidget {
  final DateTime dateTime;
  final BuildContext context;

  const YearWidget({
    Key? key,
    required this.dateTime,
    required this.context,
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
                int initialPage =
                    ((dateTime.year - Constants.backLimitDate.year) * 12) +
                        index;
                print(initialPage);
                context.read<DateChangeCubitDartCubit>().initPage(
                      initialPage: initialPage,
                    );
                context.read<DateChangeCubitDartCubit>().viewByMonthOldIndex(
                      value: initialPage,
                    );

                context.read<DateChangeCubitDartCubit>().dateChanged(
                      newDate: DateTime(dateTime.year, index + 1, 01),
                    );

                context.read<DateChangeCubitDartCubit>().viewBy(
                      viewByChoices: ViewByChoices.viewByMonth,
                    );
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
            DateTime(date.year, date.month, 01) ==
                    DateTime(Constants.currentDate.year,
                        Constants.currentDate.month, 01)
                ? Text(
                    DateFormat.MMMM().format(date),
                    style: TextStyle(color: Colors.green[400]),
                  )
                : Text(DateFormat.MMMM().format(date)),
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
                      color: index == 6 ? Colors.red[700] : Colors.white,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
            MonthWidget(
              dateTime: date,
              mainAxisSpacing: 0,
              topPadding: 40,
              leftPadding: 0,
              context: context,
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
