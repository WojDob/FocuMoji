import 'package:flutter/material.dart';
import 'dart:async';

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

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _totalRemainingSeconds--;

      if (_totalRemainingSeconds < 0) {
        _timer!.cancel();
      } else {
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
