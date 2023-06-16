import 'package:flutter/material.dart';
import 'dart:async';

class TimerManager extends ChangeNotifier {
  int _minutes = 0;
  int _seconds = 0;
  int _remaining = 0;
  Timer? _timer;

  int get minutes => _minutes;
  int get seconds => _seconds;

  void setTimer(int minutes) {
    _remaining = 60 * minutes;
    notifyListeners();
  }

  void startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      const reduceSecondsBy = 1;

      _remaining = _remaining - reduceSecondsBy;
      if (_remaining < 0) {
        _timer!.cancel();
      } else {
        _setDigits(_remaining);
      }
      notifyListeners();
    });
  }

  void _setDigits(int remainingSeconds) {
    _minutes = (remainingSeconds / 60).toInt();
    _seconds = remainingSeconds - (_minutes * 60);
  }
}
