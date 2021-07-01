import 'package:custom_calendar/cubit/date_change_cubit_dart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewByYear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateChangeCubitDartCubit, DateChangeCubitDartState>(
      builder: (context, state) {
        return Container();
      },
    );
  }
}
