import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:square_timer/screens/countdown_screen.dart';
import '../models/models.dart';

class TimerScreen extends StatefulWidget {
  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            child: SizedBox(
              width: 300,
              height: 200,
              child: Stack(
                children: [
                  _buildSliderAndValue(),
                  _buildStartButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliderAndValue() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(
            value: _sliderValue,
            min: 0,
            max: 120,
            divisions: 120,
            onChanged: (newValue) {
              setState(() {
                _sliderValue = newValue;
              });
            },
          ),
          Text(
            _sliderValue.round().toString(),
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Visibility(
          visible: _sliderValue != 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton(
              child: const Text("Start"),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => ChangeNotifierProvider(
                      create: (context) => TimerManager.started(
                        initialTimeInMinutes: _sliderValue.toInt(),
                      ),
                      builder: (context, child) => CountdownScreen(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
