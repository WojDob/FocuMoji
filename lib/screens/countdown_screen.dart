import 'package:flutter/material.dart';
import '../components/squares_grid.dart';
import '../models/models.dart';
import 'package:provider/provider.dart';

class CountdownScreen extends StatelessWidget {
  const CountdownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerProvider = context.watch<TimerManager>();
    final rewardsProvider = context.watch<RewardsManager>();
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 100,
              ),
              child: Card(
                child: SizedBox(
                  width: 300,
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
                          visible: timerProvider.timerEnded &&
                              !timerProvider
                                  .rewardsCollected, // Add condition to check if rewards were not collected
                          child: ElevatedButton(
                            onPressed: () async {
                              rewardsProvider.addRewards(
                                  timerProvider.timerRewards,
                                  timerProvider.name);
                              timerProvider.rewardsCollected =
                                  true; // Set rewardsCollected to true
                              _showModal(context);
                            },
                            child: const Text('Collect rewards!'),
                          ),
                        ),
                      ],
                    ),
                  ),
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

    final modalBackgroundColor = Theme.of(context).dialogBackgroundColor;
    final lighterColor = Color.lerp(modalBackgroundColor, Colors.white, 0.2);

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
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${rewardsProvider.newRewards.length} New Rewards!',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 22.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          for (Reward reward in rewardsProvider.newRewards)
                            Card(
                              color: lighterColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  reward.symbol,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
