/*import 'package:custom_calendar/cubit/date_change_cubit_dart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: BlocProvider<DateChangeCubitDartCubit>(
        create: (_) => DateChangeCubitDartCubit(),
        child: CalendarWidget(),
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime currentDate = DateTime(2021, 01, 01);
  //DateTime backLimitDate = DateTime(1912, 01, 01);

  late String monthName;
  int pageTrack = 1;
  @override
  Widget build(BuildContext context) {
    final checkColor = MediaQuery.platformBrightnessOf(context);
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    monthName = DateFormat.MMM().format(currentDate);
    //final dayNames = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    //final todayDate = DateTime.now();
    // DateTime todayDate = DateTime(2021, 06, 01);
    //final monthName = DateFormat.MMM().format(todayDate);

    return BlocConsumer<DateChangeCubitDartCubit, DateChangeCubitDartState>(
      listener: (context, state) {
        if (state.status == DateChangeCubitDartStatus.success) {
          // return;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backwardsCompatibility: false,
            systemOverlayStyle: checkColor == Brightness.dark
                ? SystemUiOverlayStyle(
                    statusBarColor: Colors.black,
                    statusBarIconBrightness: Brightness.light)
                : SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
            foregroundColor:
                checkColor == Brightness.light ? Colors.black : Colors.white,
            backgroundColor:
                checkColor == Brightness.light ? Colors.white : Colors.black,
            title: Text(state.dateTime.year.toString() +
                ' ' +
                DateFormat.MMM().format(state.dateTime)),
            leading: Icon(Icons.menu),
            actions: [Icon(Icons.home)],
          ),
          backgroundColor: Colors.black,
          body: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white12),
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
                PageView.builder(
                    controller: PageController(initialPage: currentDate.month),
                    onPageChanged: (index) {
                      final newDate = DateTime(currentDate.year, index + 1, 01);
                      context
                          .read<DateChangeCubitDartCubit>()
                          .dateChanged(newDate: newDate);
                    },
                    itemBuilder: (context, index) {
                      final newDate = DateTime(currentDate.year, index + 1, 01);

                      return displayMonth(
                        dateTime: newDate,
                        context: context,
                      );
                    })
              ],
            ),
          ),
        );
      },
    );
  }

  Widget displayMonth(
      {required DateTime dateTime, required BuildContext context}) {
    final viewPort = createMonth(todayDate: dateTime);
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 60, 0, 0),
      child: GridView.builder(
          itemCount: viewPort.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 60,
            crossAxisCount: 7,
          ),
          itemBuilder: (context, index) {
            return viewPort[index];
          }),
    );
  }

  List<Widget> createMonth({required DateTime todayDate}) {
    /*  DateTime toDate = DateTime(2021, 05, 01);
    final previousMonthNumOfDays = DateTime(toDate.year, toDate.month, 0)
        .difference(DateTime(toDate.year, toDate.month - 1, 0))
        .inDays;
    print(previousMonthNumOfDays);
 */

    final prevMonthLastDate = DateTime(todayDate.year, todayDate.month, 0);
    final prevMonthNumOfDays = DateFormat.d().format(prevMonthLastDate);

    final currentMonthLastDate =
        DateTime(todayDate.year, todayDate.month + 1, 0);
    final currentMonthNumOfDays = DateFormat.d().format(currentMonthLastDate);

    final currentMonthFirstDayNumber =
        DateTime(todayDate.year, todayDate.month, 01).weekday;

    final currentMonthLastDayNumber =
        DateTime(todayDate.year, todayDate.month + 1, 0).weekday;

    return creatOneMonth(
      prevMonthNumOfDays: int.parse(prevMonthNumOfDays),
      currentMonthFirstDayNumber: currentMonthFirstDayNumber,
      currentMonthLastDayNumber: currentMonthLastDayNumber,
      currentMonthNumOfDays: int.parse(currentMonthNumOfDays),
    );
  }

  List<Widget> creatOneMonth({
    required int prevMonthNumOfDays,
    required int currentMonthFirstDayNumber,
    required int currentMonthLastDayNumber,
    required int currentMonthNumOfDays,
  }) {
    List<Widget> visiblePrevMonthDays = [];
    List<Widget> visibleNextMonthDays = [];
    List<Widget> currentMothDays = [];

    if (currentMonthFirstDayNumber != 1) {
      int patchFrom = prevMonthNumOfDays - currentMonthFirstDayNumber + 1;
      for (int index = 1; index < currentMonthFirstDayNumber; index++) {
        visiblePrevMonthDays.add(
          Text(
            (patchFrom + index).toString(),
            style: TextStyle(color: Colors.grey),
          ),
        );
      }
    }

    for (int index = 1; index <= currentMonthNumOfDays; index++) {
      currentMothDays.add(
        Text(
          index.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    int viewPortLenght = visiblePrevMonthDays.length + currentMothDays.length;

    int index = 1;
    while (viewPortLenght < 42) {
      visibleNextMonthDays.add(
        Text(
          index.toString(),
          style: TextStyle(color: Colors.grey),
        ),
      );

      index += 1;
      viewPortLenght += 1;
    }

    return visiblePrevMonthDays + currentMothDays + visibleNextMonthDays;
  }
}

 */

/* import 'package:custom_calendar/cubit/date_change_cubit_dart_cubit.dart';
import 'package:custom_calendar/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MonthWidget extends StatelessWidget {
  final DateTime dateTime;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final Brightness textColor;
  final ViewByChoices viewByChoices;

  const MonthWidget(
      {Key? key,
      required this.dateTime,
      this.mainAxisSpacing = 60.0,
      this.crossAxisSpacing = 10,
      this.viewByChoices = ViewByChoices.viewByMonth,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewPort = creatMonth(date: dateTime, textColor: textColor);

    return BlocBuilder<DateChangeCubitDartCubit, DateChangeCubitDartState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: viewPort[1].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: mainAxisSpacing,
                //mainAxisSpacing: 10,
                crossAxisSpacing: 0,
                crossAxisCount: 7,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    //Text text = Text('Mandelaaaaaaaaaaaaaaaaaaaaaaa');
                    // print(viewPort[0]);
                    //print(viewPort[2]);

                    print(' itemBuilder index is :' + index.toString());
                    print('viewPort::::' + viewPort[0].toString());
                    if ((index) <= (viewPort[0] - 1)) {
                      print('Oops! out of the bounds');
                    } else if ((index) >= (viewPort[1].length - viewPort[2])) {
                      print('Oops! out of the END bounds');
                    } else {
                      context.read<DateChangeCubitDartCubit>().selectedDate(
                            !state.isSelected,
                            index,
                          ); // isSelected is initially 'false'. This sets it to 'true.
                      print('seleced state index: ' + index.toString());
                      context
                          .read<DateChangeCubitDartCubit>()
                          .animWidget(Container(
                            decoration: BoxDecoration(
                              //color: Colors.yellow,
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: viewPort[1][index],
                          )); //
                    }
                    print('state date');
                    print(state.selectedDate.day);

                    /*   Container(
                      decoration: BoxDecoration(
                        //color: Colors.yellow,
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: viewPort[1][index],
                    ); */
                  },
                  child: (viewPort[1][index]).data == 28
                      ? state.animatedWidget
                      : animatedGridCell(
                          widget: viewPort[1][index],
                          animatedWidget: state.animatedWidget,
                          stateDateTime: state.selectedDate,
                          isSelected: state.isSelected,
                          index: index,
                          stateIndex: state.selectedIndex,
                        ),
                );
              }),
        );
      },
    );
  }

  Widget animatedGridCell({
    required Widget widget,
    required Widget animatedWidget,
    required DateTime stateDateTime,
    required bool isSelected,
    required int index,
    int? stateIndex,
  }) {
    if (index == stateIndex) {
      return animatedWidget;
    } else {
      return widget;
    }
  }

  // Create a Month
  // Appends visible previous month days into the viewport of this month, and color them grey.
  // Appends visible next month days into the viewport of this month, and color them grey.
  List<dynamic> creatMonth(
      {required DateTime date, required Brightness textColor}) {
    List<Widget> visiblePrevMonthDays = [];
    List<Widget> visibleNextMonthDays = [];
    List<Widget> currentMothDays = [];

    final prevMonthLastDate = DateTime(date.year, date.month, 0);
    String prvMonthNumOfDays = DateFormat.d().format(prevMonthLastDate);
    int prevMonthNumOfDays = int.parse(prvMonthNumOfDays);

    final currentMonthLastDate = DateTime(date.year, date.month + 1, 0);
    String currntMonthNumOfDays = DateFormat.d().format(currentMonthLastDate);
    int currentMonthNumOfDays = int.parse(currntMonthNumOfDays);

    final currentMonthFirstDayNumber =
        DateTime(date.year, date.month, 01).weekday;

    if (currentMonthFirstDayNumber != 1) {
      int patchFrom = prevMonthNumOfDays - currentMonthFirstDayNumber + 1;
      for (int index = 1; index < currentMonthFirstDayNumber; index++) {
        visiblePrevMonthDays.add(
          Text(
            viewByChoices == ViewByChoices.viewByMonth
                ? (patchFrom + index).toString()
                : '',
            style: TextStyle(color: Colors.grey),
          ),
        );
      }
    }
    final monthCheck = visiblePrevMonthDays + currentMothDays;
    print(date);
    final currentDate = DateTime.now();
    int trackLen = 0;
    for (int index = 1; index <= currentMonthNumOfDays; index++) {
      trackLen = monthCheck.length + 1;
      monthCheck.add(
        DateTime(date.year, date.month, index) ==
                DateTime(currentDate.year, currentDate.month, currentDate.day)
            ? Text(
                index.toString(),
                style: TextStyle(
                  color: textColor == Brightness.light
                      ? trackLen % 7 == 0
                          ? Colors.white
                          : Colors.black
                      : Colors.white,
                ),
              )
            : Text(
                index.toString(),
                style: TextStyle(
                  color: textColor == Brightness.light
                      ? trackLen % 7 == 0
                          ? Colors.red[700]
                          : Colors.black
                      : trackLen % 7 == 0
                          ? Colors.red[700]
                          : Colors.white,
                ),
              ),
      );
    }

    int index = 1;

    print('added next days :::::::::::::::::');
    int viewPortLenght = monthCheck.length;
    int check = 0;
    if (viewByChoices == ViewByChoices.viewByMonth) {
      while (viewPortLenght < 42) {
        check = viewPortLenght + 1;
        visibleNextMonthDays.add(
          check % 7 == 0
              ? Text(
                  index.toString(),
                  style: TextStyle(color: Colors.red[300]),
                )
              : Text(
                  index.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
        );
        index += 1;
        viewPortLenght += 1;
      }
    }

    return [
      visiblePrevMonthDays.length,
      monthCheck + visibleNextMonthDays,
      visibleNextMonthDays.length
    ];
  }
}

 */
