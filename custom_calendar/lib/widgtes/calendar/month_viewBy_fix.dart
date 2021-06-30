import 'package:custom_calendar/classes/classes.dart';
import 'package:custom_calendar/cubit/date_change_cubit_dart_cubit.dart';
import 'package:custom_calendar/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FixViewByMonth extends StatefulWidget {
  final ViewByChoices viewByChoice;

  const FixViewByMonth({Key? key, required this.viewByChoice})
      : super(key: key);

  @override
  _FixViewByMonthState createState() => _FixViewByMonthState();
}

class _FixViewByMonthState extends State<FixViewByMonth> {
  DateTime backLimitDate = Constants.backLimitDate;
  DateTime currentDate = Constants.currentDate;
  List<String> dayNames = Constants.dayNames;

  int initialPage = 0;
  int trackPaging = 0;
  int oldIndex = 0;
  late PageController _controller;

  void initializeController() {
    if (widget.viewByChoice == ViewByChoices.viewByMonth) {
      int x = (currentDate.year - backLimitDate.year) * 12;
      initialPage = x + currentDate.month - 2;

      print(initialPage);
    } else {
      initialPage = currentDate.year - backLimitDate.year;
    }
    _controller = PageController(initialPage: initialPage);
    oldIndex = initialPage;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(ViewByChoices.viewByMonth);
    final checkColor = MediaQuery.platformBrightnessOf(context);

    List<Widget> results = ViewByChoiceClass.viewByChoice(
      choice: widget.viewByChoice,
      textColor: checkColor,
    );

    initializeController();
    return BlocBuilder<DateChangeCubitDartCubit, DateChangeCubitDartState>(
      builder: (context, state) {
        if (state.isPrevMonthDay == true) {
          _controller.previousPage(
              duration: Duration(microseconds: 10), curve: Curves.easeIn);
        } else if (state.isNextMonthDay == true) {
          _controller.nextPage(
              duration: Duration(microseconds: 10), curve: Curves.easeIn);
        }
        return Container(
          decoration: BoxDecoration(
            color:
                checkColor == Brightness.light ? Colors.white : Colors.white10,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                child: GridView.builder(
                    itemCount: dayNames.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                    ),
                    itemBuilder: (context, index) {
                      return Text(dayNames[index]);
                    }),
              ),
              SizedBox(height: 10.0),
              PageView(
                controller: _controller,
                onPageChanged: (index) {
                  if (index > oldIndex) {
                    trackPaging = currentDate.month + 1;
                  } else {
                    trackPaging = currentDate.month - 1;
                  }
                  oldIndex = index;
                  currentDate = DateTime(currentDate.year, trackPaging, 01);

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
        );
      },
    );
  }
}
