part of 'date_change_cubit_dart_cubit.dart';

enum DateChangeCubitDartStatus { initial, submitting, success }

@immutable
class DateChangeCubitDartState {
  final DateTime dateTime;
  final bool isSelected;
  final bool hasPaged;
  final int selectedIndex;
  final DateTime selectedDate;
  final Widget animatedWidget;
  final bool isPrevMonthDay;
  final bool isNextMonthDay;
  final DateChangeCubitDartStatus status;

  DateChangeCubitDartState({
    required this.dateTime,
    required this.isSelected,
    required this.hasPaged,
    required this.selectedIndex,
    required this.selectedDate,
    required this.animatedWidget,
    required this.isPrevMonthDay,
    required this.isNextMonthDay,
    required this.status,
  });

  factory DateChangeCubitDartState.initial() {
    return DateChangeCubitDartState(
      dateTime: Constants.currentDate, //DateTime.now(),
      isSelected: false,
      hasPaged: false,
      selectedIndex: 0,
      selectedDate: Constants.currentDate, //DateTime.now(),
      animatedWidget: SizedBox.shrink(),
      isPrevMonthDay: false,
      isNextMonthDay: false,
      status: DateChangeCubitDartStatus.initial,
    );
  }

  DateChangeCubitDartState copyWith({
    DateTime? dateTime,
    bool? isSelected,
    bool? hasPaged,
    int? selectedIndex,
    DateTime? selectedDate,
    Widget? animatedWidget,
    bool? isPrevMonthDay,
    bool? isNextMonthDay,
    DateChangeCubitDartStatus? status,
  }) {
    return DateChangeCubitDartState(
      dateTime: dateTime ?? this.dateTime,
      isSelected: isSelected ?? this.isSelected,
      hasPaged: hasPaged ?? this.hasPaged,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedDate: selectedDate ?? this.selectedDate,
      animatedWidget: animatedWidget ?? this.animatedWidget,
      isPrevMonthDay: isPrevMonthDay ?? this.isPrevMonthDay,
      isNextMonthDay: isNextMonthDay ?? this.isNextMonthDay,
      status: status ?? this.status,
    );
  }
}
