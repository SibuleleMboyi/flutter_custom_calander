import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'date_change_cubit_dart_state.dart';

class DateChangeCubitDartCubit extends Cubit<DateChangeCubitDartState> {
  DateChangeCubitDartCubit() : super(DateChangeCubitDartState.initial());

  void dateChanged({required DateTime newDate}) {
    emit(
      state.copyWith(
        dateTime: newDate,
        status: DateChangeCubitDartStatus.success,
      ),
    );
  }

  void selectedDate({required bool isSelected, required int index}) {
    emit(
      state.copyWith(
        isSelected: isSelected,
        selectedIndex: index,
        status: DateChangeCubitDartStatus.success,
      ),
    );
  }

  void selectedDateFix({required DateTime dateTime}) {
    emit(
      state.copyWith(
        selectedDate: dateTime,
        status: DateChangeCubitDartStatus.success,
      ),
    );
  }

  void animWidget({required Widget widget}) {
    emit(
      state.copyWith(
        animatedWidget: widget,
        status: DateChangeCubitDartStatus.success,
      ),
    );
  }

  void hasPaged({required bool hasPaged}) {
    emit(
      state.copyWith(
        hasPaged: hasPaged,
        status: DateChangeCubitDartStatus.success,
      ),
    );
  }
}
