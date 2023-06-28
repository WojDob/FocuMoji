import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:logger/logger.dart';
import 'reward.dart';

class RewardsManager extends ChangeNotifier {
  List<Reward> _allRewards = [];
  List<Reward> _newRewards = [];
  List<Reward> get allRewards => _allRewards;
  List<Reward> get newRewards => _newRewards;
  late SharedPreferences _sharedPreferences;
  final Logger logger = Logger();

  Future<void> initialize() async {
    logger.i("Initializing RewardsManager");
    _sharedPreferences = await SharedPreferences.getInstance();
    await _loadRewards();
    notifyListeners();
    logger.i("Finished initializing RewardsManager");
  }

  Future<void> _loadRewards() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final rewardsJson = _sharedPreferences.getStringList('rewards');
    if (rewardsJson != null) {
      _allRewards = rewardsJson
          .map((rewardJson) => Reward.fromJson(jsonDecode(rewardJson)))
          .toList();
    }
    logger.i("Loaded rewards from shared preferences");
  }

  Future<void> _saveRewards() async {
    final rewardsJson =
        _allRewards.map((reward) => jsonEncode(reward.toJson())).toList();
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setStringList('rewards', rewardsJson);
    logger.i("Saved rewards to shared preferences");
  }

  Future<void> addRewards(int count, String timerName) async {
    logger.i("Adding $count rewards from $timerName");
    _newRewards = [];
    final randomEmojis = await selectRandomEmojis(count);
    _newRewards = randomEmojis.map((emoji) {
      return Reward(
        symbol: emoji,
        acquiredAt: DateTime.now(),
        timerName: timerName,
      );
    }).toList();
    _allRewards.addAll(_newRewards);
    await _saveRewards();
    notifyListeners();
    logger.i(
        "Added new rewards: $newRewards\n from timer: $timerName\n total rewards: ${allRewards.length}");
  }

  Future<List<String>> selectRandomEmojis(int count) async {
    final jsonString =
        await rootBundle.loadString('assets/data/emoji_list.json');
    final List<dynamic> emojis = jsonDecode(jsonString);
    final List<String> randomEmojis = [];
    while (randomEmojis.length < count) {
      final randomIndex = Random().nextInt(emojis.length);
      if (!randomEmojis.contains(emojis[randomIndex])) {
        randomEmojis.add(emojis[randomIndex]);
      }
    }
    logger.i("Selected $count random emojis ");
    return randomEmojis;
  }
}
