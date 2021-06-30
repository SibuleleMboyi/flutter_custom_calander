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
  final ViewByChoices viewByChoices;
  final int initialPage;
  final double currentViewdPage;
  final DateChangeCubitDartStatus status;
  final int oldIndex;

  DateChangeCubitDartState({
    required this.dateTime,
    required this.isSelected,
    required this.hasPaged,
    required this.selectedIndex,
    required this.selectedDate,
    required this.animatedWidget,
    required this.isPrevMonthDay,
    required this.isNextMonthDay,
    required this.viewByChoices,
    required this.initialPage,
    required this.status,
    required this.currentViewdPage,
    required this.oldIndex,
  });

  factory DateChangeCubitDartState.initial() {
    return DateChangeCubitDartState(
      dateTime: Constants.currentDate, //DateTime.now(),
      isSelected: false,
      hasPaged: false,
      selectedIndex: -2,
      selectedDate: Constants.currentDate, //DateTime.now(),
      animatedWidget: SizedBox.shrink(),
      isPrevMonthDay: false,
      isNextMonthDay: false,
      viewByChoices: ViewByChoices.none,
      initialPage: 0,
      status: DateChangeCubitDartStatus.initial,
      currentViewdPage: 0,
      oldIndex: 0,
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
    ViewByChoices? viewByChoices,
    int? initialPage,
    DateChangeCubitDartStatus? status,
    double? currentViewdPage,
    int? oldIndex,
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
      viewByChoices: viewByChoices ?? this.viewByChoices,
      initialPage: initialPage ?? this.initialPage,
      status: status ?? this.status,
      currentViewdPage: currentViewdPage ?? this.currentViewdPage,
      oldIndex: oldIndex ?? this.oldIndex,
    );
  }
}
