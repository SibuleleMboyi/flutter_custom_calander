import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'date_change_cubit_dart_state.dart';

class DateChangeCubitDartCubit extends Cubit<DateChangeCubitDartState> {
  DateChangeCubitDartCubit() : super(DateChangeCubitDartState.initial());

  void dateChanged({required DateTime newDate}) {
    emit(state.copyWith(
        dateTime: newDate, status: DateChangeCubitDartStatus.success));
  }
}
