import 'package:flutter/material.dart';
import 'dart:async';

class TimerManager extends ChangeNotifier {
  int initialTimeInMinutes = 1;
  int _minutes = 0;
  int _seconds = 0;
  int _totalRemainingSeconds = 0;
  bool isRunning = false;
  Timer? _timer;

  int get minutes => _minutes;
  int get seconds => _seconds;
  int get totalRemainingSeconds => _totalRemainingSeconds;

  TimerManager();
  TimerManager.started(this.initialTimeInMinutes) {
    isRunning = true;
    setTimer(initialTimeInMinutes);
  }

  void setTimer(int minutes) {
    _timer?.cancel();
    _totalRemainingSeconds = 60 * minutes;
    _setDigits(_totalRemainingSeconds);
    startTimer();
    notifyListeners();
  }

  void startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      const reduceSecondsBy = 1;

      _totalRemainingSeconds = _totalRemainingSeconds - reduceSecondsBy;
      if (_totalRemainingSeconds < 0) {
        isRunning = false;

        notifyListeners();
        _timer!.cancel();
      } else {
        _setDigits(_totalRemainingSeconds);
        notifyListeners();
      }
    });
  }

  void _setDigits(int remainingSeconds) {
    _minutes = remainingSeconds ~/ 60;
    _seconds = remainingSeconds - (_minutes * 60);
  }

  @override
  void dispose() {
    _timer?.cancel();
    isRunning = false;

    super.dispose();
  }
}
