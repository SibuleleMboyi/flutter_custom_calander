import 'package:custom_calendar/cubit/date_change_cubit_dart_cubit.dart';
import 'package:custom_calendar/utils/constants.dart';
import 'package:custom_calendar/widgtes/calendar/view_by_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatelessWidget {
  final ViewByChoices viewByChoice;

  const CalendarWidget({
    Key? key,
    this.viewByChoice = ViewByChoices.viewByMonth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(ViewByChoices.viewByMonth);
    final checkColor = MediaQuery.platformBrightnessOf(context);
    int trackPaging = 0;

    DateTime backLimitDate = Constants.backLimitDate;
    DateTime currentDate = Constants.currentDate;
    List<Widget> results = ViewByChoiceClass.viewByChoice(
      choice: viewByChoice,
      textColor: MediaQuery.platformBrightnessOf(context),
    );
    List<String> dayNames = Constants.dayNames;

    final int initialPage;

    if (viewByChoice == ViewByChoices.viewByMonth) {
      int x = (currentDate.year - backLimitDate.year) * 12;
      initialPage = x + currentDate.month - 2;

      print(initialPage);
    } else {
      initialPage = currentDate.year - backLimitDate.year;
    }
    int oldIndex = initialPage;
    final _controller = PageController(initialPage: initialPage);

    return BlocBuilder<DateChangeCubitDartCubit, DateChangeCubitDartState>(
      builder: (context, state) {
        if (state.isPrevMonthDay == true) {
          _controller.previousPage(
              duration: Duration(microseconds: 10), curve: Curves.easeIn);
        } else if (state.isNextMonthDay == true) {
          _controller.nextPage(
              duration: Duration(microseconds: 10), curve: Curves.easeIn);
        }
        return Scaffold(
          // print(DateTime.now().toString());
          //print(state.dateTime);
          appBar: AppBar(
            elevation: 0.0,
            backwardsCompatibility: false,
            systemOverlayStyle: checkColor == Brightness.dark
                ? SystemUiOverlayStyle(
                    statusBarColor: Colors.black,
                    statusBarIconBrightness: Brightness.light)
                : SystemUiOverlayStyle(
                    statusBarColor: Colors.grey[200],
                    statusBarIconBrightness: Brightness.dark),
            foregroundColor:
                checkColor == Brightness.light ? Colors.black : Colors.white,
            backgroundColor: checkColor == Brightness.light
                ? Colors.grey[200]
                : Colors.black,
            title: viewByChoice == ViewByChoices.viewByMonth
                ? Text(state.dateTime.year.toString() +
                    ' ' +
                    DateFormat.MMM().format(state.dateTime))
                : Text(state.dateTime.year.toString()),
            leading: Icon(Icons.menu),
            actions: [Icon(Icons.home)],
          ),
          backgroundColor:
              checkColor == Brightness.light ? Colors.grey[200] : Colors.black,
          body: Container(
            decoration: BoxDecoration(
              color: checkColor == Brightness.light
                  ? Colors.white
                  : Colors.white10,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Stack(
              children: [
                viewByChoice == ViewByChoices.viewByMonth
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                        child: GridView.builder(
                            itemCount: dayNames.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                            ),
                            itemBuilder: (context, index) {
                              return Text(dayNames[index]);
                            }),
                      )
                    : SizedBox.shrink(),
                SizedBox(height: 10.0),
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    if (index > oldIndex) {
                      trackPaging = viewByChoice == ViewByChoices.viewByMonth
                          ? currentDate.month + 1
                          : currentDate.year + 1;
                    } else {
                      trackPaging = viewByChoice == ViewByChoices.viewByMonth
                          ? currentDate.month - 1
                          : currentDate.year - 1;
                    }
                    oldIndex = index;
                    currentDate = viewByChoice == ViewByChoices.viewByMonth
                        ? DateTime(currentDate.year, trackPaging, 01)
                        : DateTime(trackPaging, 01, 01);

                    print(trackPaging);
                    context
                        .read<DateChangeCubitDartCubit>()
                        .dateChanged(newDate: currentDate);

                    context
                        .read<DateChangeCubitDartCubit>()
                        .selectedDateFix(dateTime: currentDate);

                    context
                        .read<DateChangeCubitDartCubit>()
                        .hasPaged(hasPaged: true);

                    context
                        .read<DateChangeCubitDartCubit>()
                        .selectedDate(isSelected: false, index: -1);

                    context.read<DateChangeCubitDartCubit>().isPrevMonthDay(
                          isPrevMonthDay: false,
                        );

                    context.read<DateChangeCubitDartCubit>().isNextMonthDay(
                          isNextMonthDay: false,
                        );
                  },
                  children: results,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
