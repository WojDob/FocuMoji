import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/rewards_manager.dart';

class MedalsScreen extends StatelessWidget {
  const MedalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rewards = context.watch<RewardsManager>();

    return SafeArea(
        child: Text("xd  ${rewards.emoji} ${rewards.rewards_count}"));
  }
}
