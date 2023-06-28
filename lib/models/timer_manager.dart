import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class TimerManager extends ChangeNotifier {
  final int initialTimeInMinutes;
  final String name;
  int _totalRemainingSeconds;
  Timer? _timer;
  bool rewardsCollected = false;
  int get minutes => _totalRemainingSeconds ~/ 60;
  int get seconds => _totalRemainingSeconds % 60;
  int get totalRemainingSeconds => _totalRemainingSeconds;
  bool get timerEnded => _totalRemainingSeconds <= 0;
  int get timerRewards => initialTimeInMinutes ~/ 5;

  final Logger logger = Logger();

  TimerManager({
    required this.initialTimeInMinutes,
    required this.name,
  }) : _totalRemainingSeconds = initialTimeInMinutes * 60;

  TimerManager.started({
    required this.initialTimeInMinutes,
    required this.name,
  }) : _totalRemainingSeconds = initialTimeInMinutes * 60 {
    startTimer();
  }

  void setTimer(int minutes) {
    _timer?.cancel();
    _totalRemainingSeconds = 60 * minutes;
    startTimer();
    notifyListeners();
  }

  void startTimer() {
    logger.i("Started timer");

    _timer?.cancel();

    _timer = Timer.periodic(
      _getTimerDuration(),
      (_) {
        _totalRemainingSeconds--;

        if (_totalRemainingSeconds < 0) {
          _totalRemainingSeconds = 0; // Sometimes the timer overdoes it
          _timer!.cancel();
          logger.i("Ended timer");
        } else {
          notifyListeners();
        }
      },
    );
  }

  Duration _getTimerDuration() {
    bool isDebugMode = kDebugMode;
    return isDebugMode ? Duration(milliseconds: 1) : Duration(seconds: 1);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
