import 'package:custom_calendar/cubit/date_change_cubit_dart_cubit.dart';
import 'package:custom_calendar/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewByMonth extends StatefulWidget {
  final ViewByChoices viewByChoice;
  final int intialPageInitialization;
  final int oldIndex;
  final List<Widget> results;
  final List<String> dayNames;
  final DateTime currentDate;

  ViewByMonth({
    Key? key,
    this.viewByChoice = ViewByChoices.viewByMonth,
    required this.intialPageInitialization,
    required this.oldIndex,
    required this.results,
    required this.dayNames,
    required this.currentDate,
  }) : super(key: key);

  @override
  _ViewByMonthState createState() => _ViewByMonthState();
}

class _ViewByMonthState extends State<ViewByMonth> {
  late int initialPage;
  late PageController _controller = PageController(
    initialPage: initialPage,
  );

/*   void initializeController() {
    int initialPage = 0;

    int x = (Constants.currentDate.year - Constants.backLimitDate.year) * 12;
    initialPage = x + Constants.currentDate.month - 2;

    _controller = PageController(
      initialPage: initialPage,
    );
  } */

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final checkColor = MediaQuery.platformBrightnessOf(context);

    int trackPaging = 0;

    initialPage = widget.intialPageInitialization;
    //initializeController();

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
                  itemCount: widget.dayNames.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                  ),
                  itemBuilder: (context, index) {
                    return Text(widget.dayNames[index]);
                  },
                ),
              ),
              SizedBox(height: 10.0),
              PageView(
                controller: _controller,
                onPageChanged: (index) {
                  print('index : ' + index.toString());
                  print('Oldindex : ' + state.viewByMonthOldIndex.toString());

                  if (index > state.viewByMonthOldIndex) {
                    trackPaging = state.dateTime.month + 1;
                  } else {
                    trackPaging = state.dateTime.month - 1;
                  }

                  print('trackPaging : ' + trackPaging.toString());
                  context
                      .read<DateChangeCubitDartCubit>()
                      .viewByMonthOldIndex(value: index);

                  final currentDateCopy =
                      DateTime(state.dateTime.year, trackPaging, 01);
                  print(currentDateCopy);

                  context
                      .read<DateChangeCubitDartCubit>()
                      .dateChanged(newDate: currentDateCopy);

                  context
                      .read<DateChangeCubitDartCubit>()
                      .selectedDateFix(dateTime: currentDateCopy);

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
                children: widget.results,
              )
            ],
          ),
        );
      },
    );
  }
}
