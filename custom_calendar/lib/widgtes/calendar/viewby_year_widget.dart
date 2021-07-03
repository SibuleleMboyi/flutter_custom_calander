import 'package:custom_calendar/classes/classes.dart';
import 'package:custom_calendar/cubit/date_change_cubit_dart_cubit.dart';
import 'package:custom_calendar/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewByYear extends StatefulWidget {
  final int initialPage;

  final Brightness checkColor;

  const ViewByYear(
      {Key? key, required this.initialPage, required this.checkColor})
      : super(key: key);
  @override
  _ViewByYearState createState() => _ViewByYearState();
}

class _ViewByYearState extends State<ViewByYear> {
  int trackPaging = 0;
  late int prevIndex = widget.initialPage;

  late PageController _controller = PageController(
    initialPage: widget.initialPage,
  );
  late List<Widget> results = ViewByChoiceClass.viewByChoice(
    choice: ViewByChoices.viewByYear,
    textColor: widget.checkColor,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateChangeCubitDartCubit, DateChangeCubitDartState>(
      builder: (context, state) {
        if (state.isResetableViewByYear == true) {
          print(_controller.initialPage);
          _controller.animateToPage(_controller.initialPage,
              duration: Duration(microseconds: 100),
              curve: Curves.fastOutSlowIn);

          context.read<DateChangeCubitDartCubit>().reset();
        }

        return PageView(
          controller: _controller,
          onPageChanged: (index) {
            if (index > prevIndex) {
              trackPaging = state.dateTime.year + 1;
            } else {
              trackPaging = state.dateTime.year - 1;
            }
            print(prevIndex);
            DateTime currentDate = DateTime(trackPaging, 01, 01);
            print(currentDate);

            context
                .read<DateChangeCubitDartCubit>()
                .dateChanged(newDate: currentDate);

            context
                .read<DateChangeCubitDartCubit>()
                .selectedDateFix(dateTime: currentDate);

            context.read<DateChangeCubitDartCubit>().hasPaged(hasPaged: true);

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
        );
      },
    );
  }
}
