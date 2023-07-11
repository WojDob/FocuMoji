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
  static String pathToEmojiList = 'assets/data/filtered-emoji-list.json';

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
        symbol: emoji['emoji'],
        acquiredAt: DateTime.now(),
        timerName: timerName,
        category: emoji['category'],
      );
    }).toList();
    _allRewards.addAll(_newRewards);
    await _saveRewards();
    notifyListeners();
    logger.i(
        "Added new rewards: $newRewards\n from timer: $timerName\n total rewards: ${allRewards.length}");
  }

  Future<List<Map<String, dynamic>>> selectRandomEmojis(int count) async {
    final jsonString = await rootBundle.loadString(pathToEmojiList);
    final Map<String, dynamic> emojisJson = jsonDecode(jsonString);
    final List<Map<String, dynamic>> allAvailableEmojis = [];
    emojisJson.forEach((category, emojis) {
      for (var emoji in emojis) {
        allAvailableEmojis.add({...emoji, 'category': category});
      }
    });
    final List<Map<String, dynamic>> randomEmojis = [];
    while (randomEmojis.length < count) {
      final randomIndex = Random().nextInt(allAvailableEmojis.length);
      if (!randomEmojis.contains(allAvailableEmojis[randomIndex])) {
        randomEmojis.add(allAvailableEmojis[randomIndex]);
      }
    }
    logger.i("Selected $count random emojis");
    return randomEmojis;
  }

  int getUniqueEmojisCount() {
    final uniqueEmojis = _allRewards.map((reward) => reward.symbol).toSet();
    return uniqueEmojis.length;
  }

  int getUnlockedEmojisCountForCategory(String category) {
    final matchingRewards = _allRewards.where((reward) {
      return reward.category == category;
    }).toList();

    final uniqueEmojis = matchingRewards.map((reward) => reward.symbol).toSet();
    return uniqueEmojis.length;
  }

  void addRandomEmojisDebug() async {
    await addRewards(100, 'Debug Timer2');
  }
}
