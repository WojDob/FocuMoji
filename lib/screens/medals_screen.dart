import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/rewards_manager.dart';

class MedalsScreen extends StatelessWidget {
  const MedalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rewardsProvider = context.watch<RewardsManager>();

    return SafeArea(
        child: ListView.builder(
      itemCount: rewardsProvider.allRewards.length,
      itemBuilder: (context, index) {
        final reward = rewardsProvider.allRewards[index];
        return Text(reward.symbol);
      },
    ));
  }
}
