import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerManager extends ChangeNotifier {
  final int initialTimeInMinutes;
  int _totalRemainingSeconds;
  Timer? _timer;

  int get minutes => _totalRemainingSeconds ~/ 60;
  int get seconds => _totalRemainingSeconds % 60;
  int get totalRemainingSeconds => _totalRemainingSeconds;
  bool get timerEnded => _totalRemainingSeconds <= 0;

  TimerManager({required this.initialTimeInMinutes})
      : _totalRemainingSeconds = initialTimeInMinutes * 60;

  TimerManager.started({required this.initialTimeInMinutes})
      : _totalRemainingSeconds = initialTimeInMinutes * 60 {
    startTimer();
  }

  void setTimer(int minutes) {
    _timer?.cancel();
    _totalRemainingSeconds = 60 * minutes;
    startTimer();
    notifyListeners();
  }

  void startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(
      _getTimerDuration(),
      (_) {
        _totalRemainingSeconds--;

        if (_totalRemainingSeconds < 0) {
          _totalRemainingSeconds = 0; //sometimes the timer overdoes it
          _timer!.cancel();
        } else {
          notifyListeners();
        }
      },
    );
  }

  Duration _getTimerDuration() {
    bool isDebugMode = kDebugMode;
    return isDebugMode ? Duration(milliseconds: 10) : Duration(seconds: 1);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
