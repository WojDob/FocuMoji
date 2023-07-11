import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/rewards_manager.dart';
import '../models/reward.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rewardsProvider = Provider.of<RewardsManager>(context);
    int uniqueEmojisCount = rewardsProvider.getUniqueEmojisCount();
    int totalEmojisCount = 1299;

    return Scaffold(
      appBar: AppBar(title: const Text('Rewards')),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '$uniqueEmojisCount/$totalEmojisCount',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/data/filtered-emoji-list.json'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var rewardData = json.decode(snapshot.data.toString());
                    var keys = rewardData.keys.toList();

                    return ListView.builder(
                      itemCount: keys.length,
                      itemBuilder: (context, index) {
                        var key = keys[index];
                        var rewardList = rewardData[key];

                        int unlockedEmojisCountInCategory = rewardsProvider
                            .getUnlockedEmojisCountForCategory(key);
                        int totalEmojisCountInCategory = rewardList.length;

                        return ExpansionTile(
                          title: Text(
                              '$key ($unlockedEmojisCountInCategory/$totalEmojisCountInCategory)'),
                          children: [
                            GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      _calculateCrossAxisCount(context),
                                  childAspectRatio: 1.0,
                                ),
                                itemCount: rewardList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, gridIndex) {
                                  var item = rewardList[gridIndex];
                                  Reward reward;

                                  if (rewardsProvider.allRewards
                                      .map((obj) => obj.symbol)
                                      .toList()
                                      .contains(item['emoji'])) {
                                    reward = rewardsProvider.allRewards
                                        .firstWhere((reward) =>
                                            reward.symbol == item['emoji']);
                                    return GestureDetector(
                                      onTap: () =>
                                          _showRewardDetails(context, reward),
                                      child: Card(
                                        color: const Color.fromRGBO(
                                            255, 215, 0, 1.0),
                                        child: Center(
                                          child: Text(
                                            reward.symbol,
                                            style:
                                                const TextStyle(fontSize: 24),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Card(
                                    child: Center(
                                      child: Text(item['emoji'],
                                          style: const TextStyle(fontSize: 24)),
                                    ),
                                  );
                                }),
                          ],
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const emojiCardWidth = 40.0;
    return (screenWidth / emojiCardWidth).floor();
  }

  void _showRewardDetails(BuildContext context, Reward reward) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(reward.symbol),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Timer Name: ${reward.timerName}'),
              const SizedBox(height: 8),
              Text(
                  'Acquired At: ${DateFormat.yMd().format(reward.acquiredAt)}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
