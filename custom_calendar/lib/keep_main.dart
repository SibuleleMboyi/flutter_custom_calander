/* import 'package:custom_calendar/cubit/date_change_cubit_dart_cubit.dart';
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
  //DateTime currentDate = DateTime(2021, 06, 01);
  DateTime backLimitDate = DateTime(2015, 01, 01); // 2100 from google calendar
  DateTime frontLimitDate = DateTime(2024, 01, 01);
  bool isDisplayMonth = true;
  //final monthsL = monthsList();
  //DateTime backLimitDate = DateTime(1912, 01, 01);

  late String monthName;
  int pageTrack = 1;
  int oldIndex = -1;
  @override
  Widget build(BuildContext context) {
    final checkColor = MediaQuery.platformBrightnessOf(context);
    DateTime currentDate = DateTime(2021, 06, 01);
    int trackPaging = 0;

    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final initialPage = (((frontLimitDate.year - backLimitDate.year) * 12) -
            ((frontLimitDate.year - currentDate.year) * 12)) +
        currentDate.month -
        2;

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
                PageView(
                  controller: PageController(
                    initialPage: initialPage,
                  ), // initialPage: 76
                  onPageChanged: (index) {
                    print('index ::: ' + index.toString());
                    print('reduced index ::: ' +
                        (index - initialPage).toString());
                    print(currentDate);

                    if (index > oldIndex) {
                      trackPaging = currentDate.month + 1;
                    } else {
                      trackPaging = currentDate.month - 1;
                    }
                    oldIndex = index;
                    currentDate = DateTime(currentDate.year, trackPaging, 01);
                    context
                        .read<DateChangeCubitDartCubit>()
                        .dateChanged(newDate: currentDate);
                    print('check check ckecj');
                    print(state.dateTime);
                  },
                  children: monthsList(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget displayYearlyCalendar({required DateTime dateTime}) {
    return GridView.builder(
        itemCount: 12,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return displayMonth(
            dateTime:
                DateTime(dateTime.year, dateTime.month + index, dateTime.day),
          );
        });
  }

  List<Widget> monthsList() {
    List<Widget> months = [];
    for (int index = 1; index <= 108; index++) {
      months.add(displayMonth(
          dateTime: DateTime(backLimitDate.year, backLimitDate.month + index,
              backLimitDate.day)));
    }
    print('months lenght :::' + months.length.toString());
    return months;
  }

  Widget displayMonth({required DateTime dateTime}) {
    final viewPort = createMonth(todayDate: dateTime);
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 60, 0, 0),
      child: GridView.builder(
          itemCount: viewPort.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 60,
            //mainAxisSpacing: 10,
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

/* import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthWidget extends StatelessWidget {
  final DateTime dateTime;
  final double mainAxisSpacing;

  const MonthWidget(
      {Key? key, required this.dateTime, this.mainAxisSpacing = 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewPort = creatMonth(date: dateTime);
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 60, 0, 0),
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: viewPort.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: mainAxisSpacing,
            //mainAxisSpacing: 10,
            childAspectRatio: 3,
            mainAxisExtent: 20,
            crossAxisCount: 7,
          ),
          itemBuilder: (context, index) {
            return viewPort[index];
          }),
    );
  }

  // Create a Month
  // Appends visible previous month days into the viewport of this month, and color them grey.
  // Appends visible next month days into the viewport of this month, and color them grey.
  List<Widget> creatMonth({required DateTime date}) {
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
} */
