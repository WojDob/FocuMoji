import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';

class TimerManager extends ChangeNotifier {
  final int initialTimeInMinutes;
  final String name; // New name property
  int _totalRemainingSeconds;
  Timer? _timer;

  int get minutes => _totalRemainingSeconds ~/ 60;
  int get seconds => _totalRemainingSeconds % 60;
  int get totalRemainingSeconds => _totalRemainingSeconds;
  bool get timerEnded => _totalRemainingSeconds <= 0;

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
    _timer?.cancel();

    _timer = Timer.periodic(
      _getTimerDuration(),
      (_) {
        _totalRemainingSeconds--;

        if (_totalRemainingSeconds < 0) {
          _totalRemainingSeconds = 0; //sometimes the timer overdoes it
          _timer!.cancel();
          if (kDebugMode) {
            print('\n Timer "$name" finished \n');
          } // Print when the timer finishes
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

  Future<void> _saveRandomEmojis() async {
    final emojis = await loadEmojiList();
    final randomEmojis = selectRandomEmojis(5, emojis);
    await storeEmojis(randomEmojis);
  }

  Future<List<String>> loadEmojiList() async {
    final jsonString =
        await rootBundle.loadString('assets/data/emoji_list.json');
    final List<dynamic> emojis = jsonDecode(jsonString);
    return emojis.cast<String>();
  }

  List<String> selectRandomEmojis(int count, List<String> emojis) {
    final random = Random();
    final List<String> randomEmojis = [];
    while (randomEmojis.length < count) {
      final randomIndex = random.nextInt(emojis.length);
      if (!randomEmojis.contains(emojis[randomIndex])) {
        randomEmojis.add(emojis[randomIndex]);
      }
    }
    return randomEmojis;
  }

  Future<void> storeEmojis(List<String> emojis) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final List<String> storedEmojis = sharedPrefs.getStringList('emojis') ?? [];
    storedEmojis.addAll(emojis);
    sharedPrefs.setStringList('emojis', storedEmojis);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
