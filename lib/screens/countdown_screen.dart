import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import '../components/squares_grid.dart';
import '../models/models.dart';
import 'package:provider/provider.dart';

class CountdownScreen extends StatelessWidget {
  const CountdownScreen({Key? key}) : super(key: key);

  Future<void> _initializeRewardsProvider(BuildContext context) async {
    final rewardsProvider = context.read<RewardsManager>();
    await rewardsProvider.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = context.watch<TimerManager>();

    _initializeRewardsProvider(context); // Call the initialization method here
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: SizedBox(
              width: 300,
              height: 500,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Text(timerProvider.name),
                    _buildTimeText(timerProvider),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SquaresGrid(
                        totalNumberOfSquares:
                            timerProvider.initialTimeInMinutes,
                      ),
                    ),
                    Visibility(
                      visible: timerProvider.timerEnded,
                      child: ElevatedButton(
                        onPressed: () async {
                          _showModal(context);
                        },
                        child: const Text('Open Modal'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Text _buildTimeText(TimerManager timerProvider) {
    return Text(
      '${timerProvider.minutes.toString().padLeft(2, '0')}:${timerProvider.seconds.toString().padLeft(2, '0')}',
      style: const TextStyle(fontSize: 48),
    );
  }

  void _showModal(BuildContext context) {
    final rewardsProvider = context.read<RewardsManager>();
    rewardsProvider.addRewards(5, "xd");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 350),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${rewardsProvider.newRewards.map((emoji) => emoji.symbol)}"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
