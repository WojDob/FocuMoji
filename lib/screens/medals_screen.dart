import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/rewards_manager.dart';

class MedalsScreen extends StatelessWidget {
  const MedalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RewardsManager>(
      builder: (context, rewardsProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${rewardsProvider.allRewards.length}'),
          ),
          body: ListView.builder(
            itemCount: rewardsProvider.allRewards.length,
            itemBuilder: (context, index) {
              final reward = rewardsProvider.allRewards[index];
              return ListTile(
                title: Text(reward.symbol),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Acquired at: ${reward.acquiredAt.toString()}'),
                    Text('Timer name: ${reward.timerName}'),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
