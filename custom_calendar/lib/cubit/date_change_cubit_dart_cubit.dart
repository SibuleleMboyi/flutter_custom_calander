import 'package:bloc/bloc.dart';
import 'package:custom_calendar/utils/constants.dart';
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

  void isPrevMonthDay({required bool isPrevMonthDay}) {
    emit(
      state.copyWith(
        isPrevMonthDay: isPrevMonthDay,
        status: DateChangeCubitDartStatus.success,
      ),
    );
  }

  void isNextMonthDay({required bool isNextMonthDay}) {
    emit(
      state.copyWith(
        isNextMonthDay: isNextMonthDay,
        status: DateChangeCubitDartStatus.success,
      ),
    );
  }

  void viewBy({required ViewByChoices viewByChoices}) {
    emit(
      state.copyWith(
        viewByChoices: viewByChoices,
        status: DateChangeCubitDartStatus.success,
      ),
    );
  }

  void initPage({required int initialPage}) {
    emit(
      state.copyWith(
        initialPage: initialPage,
        status: DateChangeCubitDartStatus.success,
      ),
    );
  }

  void currentViewedPage({required double currentViewdPage}) {
    emit(
      state.copyWith(
        currentViewdPage: currentViewdPage,
        status: DateChangeCubitDartStatus.success,
      ),
    );
  }

  void viewByMonthOldIndex({required int value}) {
    emit(
      state.copyWith(
        initialPage: value,
        status: DateChangeCubitDartStatus.success,
      ),
    );
  }

  void isResetableViewByMonth({required bool value}) {
    emit(
      state.copyWith(
        isResetableViewByMonth: value,
        status: DateChangeCubitDartStatus.success,
      ),
    );
  }

  void isResetableViewByYear({required bool value}) {
    emit(
      state.copyWith(
        isResetableViewByYear: value,
        status: DateChangeCubitDartStatus.success,
      ),
    );
  }

  void reset() {
    emit(DateChangeCubitDartState.initial());
  }
}
