import 'package:flutter/cupertino.dart';

class TrackDateProvider extends ChangeNotifier {
  DateTime _currentDate = DateTime(2021, 01, 01);
  final List<DateTime> dates = [];
  DateTime get date => _currentDate;
  void setDate({required DateTime newDate}) {
    print(newDate);
    //dates.add(newDate);
    //print(dates);
    _currentDate = newDate;
    notifyListeners();
  }
}
