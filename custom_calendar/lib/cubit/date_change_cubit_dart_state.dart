part of 'date_change_cubit_dart_cubit.dart';

enum DateChangeCubitDartStatus { initial, submitting, success }

@immutable
class DateChangeCubitDartState {
  final DateTime dateTime;
  final DateChangeCubitDartStatus status;

  DateChangeCubitDartState({required this.dateTime, required this.status});

  factory DateChangeCubitDartState.init() {
    return DateChangeCubitDartState(
        dateTime: DateTime.now(), status: DateChangeCubitDartStatus.initial);
  }

  DateChangeCubitDartState copyWith({
    DateTime? dateTime,
    DateChangeCubitDartStatus? status,
  }) {
    return DateChangeCubitDartState(
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
    );
  }
}
