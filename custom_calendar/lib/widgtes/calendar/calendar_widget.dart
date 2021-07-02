import 'package:custom_calendar/cubit/date_change_cubit_dart_cubit.dart';
import 'package:custom_calendar/utils/constants.dart';
import 'package:custom_calendar/widgtes/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  final ViewByChoices viewByChoice;

  const CalendarWidget({
    Key? key,
    this.viewByChoice = ViewByChoices.viewByMonth,
  }) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime backLimitDate = Constants.backLimitDate;
  DateTime currentDate = Constants.currentDate;
  List<String> dayNames = Constants.dayNames;

  int initialPage = 0;
  int trackPaging = 0;

  void initializeController() {
    if (widget.viewByChoice == ViewByChoices.viewByMonth) {
      int x = (currentDate.year - backLimitDate.year) * 12;
      initialPage = x + currentDate.month - 1;
    } else {
      initialPage = currentDate.year - backLimitDate.year;
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkColor = MediaQuery.platformBrightnessOf(context);

    initializeController();
    print('initialPage');
    print(initialPage);
    return BlocBuilder<DateChangeCubitDartCubit, DateChangeCubitDartState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backwardsCompatibility: false,
            systemOverlayStyle: checkColor == Brightness.dark
                ? SystemUiOverlayStyle(
                    statusBarColor: Colors.black,
                    statusBarIconBrightness: Brightness.light,
                  )
                : SystemUiOverlayStyle(
                    statusBarColor: Colors.grey[200],
                    statusBarIconBrightness: Brightness.dark,
                  ),
            foregroundColor:
                checkColor == Brightness.light ? Colors.black : Colors.white,
            backgroundColor: checkColor == Brightness.light
                ? Colors.grey[200]
                : Colors.black,
            title: widget.viewByChoice == ViewByChoices.viewByMonth ||
                    state.viewByChoices == ViewByChoices.viewByMonth
                ? Text(state.dateTime.year.toString() +
                    ' ' +
                    DateFormat.MMM().format(state.dateTime))
                : Text(state.dateTime.year.toString()),
            leading: Icon(Icons.menu),
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 10, 10),
                child: GestureDetector(
                  onTap: () {
                    widget.viewByChoice == ViewByChoices.viewByYear &&
                            state.viewByChoices != ViewByChoices.viewByMonth
                        ? context
                            .read<DateChangeCubitDartCubit>()
                            .isResetableViewByYear(
                              value: true,
                            )
                        : context
                            .read<DateChangeCubitDartCubit>()
                            .isResetableViewByMonth(
                              value: true,
                            );
                  },
                  child: SelectedDateMarker(
                    child: Center(
                      child: Text(Constants.currentDate.day.toString()),
                    ),
                  ),
                ),
              )
            ],
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
            child: widget.viewByChoice == ViewByChoices.viewByYear &&
                    state.viewByChoices != ViewByChoices.viewByMonth
                ? ViewByYear(initialPage: initialPage, checkColor: checkColor)
                : ViewByMonth(
                    checkColor: checkColor,
                    initialPage: state.initialPage != 0
                        ? state.initialPage
                        : initialPage,
                  ),
          ),
        );
      },
    );
  }
}
