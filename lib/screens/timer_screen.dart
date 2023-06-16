import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class TimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerManager>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            child: SizedBox(
              width: 300,
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${timerProvider.minutes.toString().padLeft(2, '0')}:${timerProvider.seconds.toString().padLeft(2, '0')}',
                        style: TextStyle(fontSize: 48),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        child: Text("Start"),
                        onPressed: () => timerProvider.startTimer(),
                      ),
                    ],
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: timerProvider.minutes.toDouble(),
                      min: 0,
                      max: 60,
                      divisions: 12,
                      onChanged: (value) {
                        timerProvider.setTimer(value.toInt());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
