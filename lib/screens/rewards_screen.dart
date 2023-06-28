import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/rewards_manager.dart';

class MedalsScreen extends StatelessWidget {
  const MedalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rewardsProvider = context.watch<RewardsManager>();

    return Scaffold(
      appBar: AppBar(title: const Text('Rewards')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 15,
            runSpacing: 15,
            children: List<Widget>.generate(rewardsProvider.allRewards.length,
                (index) {
              final reward = rewardsProvider.allRewards[index];
              return SizedBox(
                width: 150,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          reward.symbol,
                          style: TextStyle(fontSize: 36),
                        ),
                        SizedBox(height: 5),
                        Text(reward.timerName),
                        SizedBox(height: 5),
                        Text(
                          '${DateFormat.yMd().format(reward.acquiredAt)}',
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}