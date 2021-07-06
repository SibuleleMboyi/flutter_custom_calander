import 'package:custom_calendar/classes/classes.dart';
import 'package:custom_calendar/cubit/date_change_cubit_dart_cubit.dart';
import 'package:custom_calendar/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewByMonth extends StatefulWidget {
  final int initialPage;

  final Brightness checkColor;

  ViewByMonth({
    Key? key,
    required this.initialPage,
    required this.checkColor,
  }) : super(key: key);

  @override
  _ViewByMonthState createState() => _ViewByMonthState();
}

class _ViewByMonthState extends State<ViewByMonth> {
  List<String> dayNames = Constants.dayNames;

  late PageController _controller = PageController(
    initialPage: widget.initialPage,
  );

  late int prevIndex = widget.initialPage;

  late List<Widget> results = ViewByChoiceClass.viewByChoice(
    choice: ViewByChoices.viewByMonth,
    context: context,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int trackPaging = 0;

    //initPage = widget.initialPage;

    return BlocBuilder<DateChangeCubitDartCubit, DateChangeCubitDartState>(
      builder: (context, state) {
        /*  context
            .read<DateChangeCubitDartCubit>()
            .viewByMonthOldIndex(value: widget.initialPage); */

        if (state.isPrevMonthDay == true) {
          _controller.previousPage(
              duration: Duration(microseconds: 10), curve: Curves.easeIn);
        } else if (state.isNextMonthDay == true) {
          _controller.nextPage(
              duration: Duration(microseconds: 10), curve: Curves.easeIn);
        } else if (state.isResetableViewByMonth == true) {
          _controller.animateToPage(_controller.initialPage,
              duration: Duration(microseconds: 100),
              curve: Curves.fastOutSlowIn);

          context.read<DateChangeCubitDartCubit>().reset();
        }

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
              child: GridView.builder(
                itemCount: dayNames.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                ),
                itemBuilder: (context, index) {
                  return Text(
                    dayNames[index],
                    style: TextStyle(
                      color: index == 6 ? Colors.red[700] : Colors.white,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.0),
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                print('index : ' + index.toString());
                print('Oldindex : ' + prevIndex.toString());

                if (index > prevIndex) {
                  trackPaging = state.dateTime.month + 1;
                } else {
                  trackPaging = state.dateTime.month - 1;
                }
                prevIndex = index;

                print('trackPaging : ' + trackPaging.toString());

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
              children: results,
            )
          ],
        );
      },
    );
  }
}
