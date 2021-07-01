import 'package:custom_calendar/cubit/date_change_cubit_dart_cubit.dart';
import 'package:custom_calendar/utils/constants.dart';
import 'package:custom_calendar/widgtes/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child: CalendarWidget(viewByChoice: ViewByChoices.viewByYear),
      ),
    );
  }
}
