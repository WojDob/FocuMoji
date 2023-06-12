import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = TimerPage();
        break;
      case 1:
        page = Placeholder();
        break;
      default:
        throw UnimplementedError("No widget for $selectedIndex");
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: false,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.timer),
                    label: Text('Timer'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.timer),
                    label: Text('Timer'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _remainingTime = 0;
  Timer? _timer;
  bool _isRunning = false;
  TextEditingController _inputController = TextEditingController();

  void _startTimer() {
    int minutes = int.tryParse(_inputController.text) ?? 0;
    setState(() {
      _remainingTime = minutes * 60; // Convert minutes to seconds
      _isRunning = true;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          _isRunning = false;
        }
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
      _remainingTime = 0;
    });
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onBackground,
    );
    return Column(
      children: [
        TextField(
          controller: _inputController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Enter duration in minutes',
          ),
        ),
        ElevatedButton(
          onPressed: _isRunning ? _stopTimer : _startTimer,
          child: Text(_isRunning ? "Stop" : "Start"),
        ),
        const SizedBox(height: 16),
        Card(
          color: theme.colorScheme.primary,
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Countdown: $_remainingTime',
              style: style,
            ),
          ),
        ),
      ],
    );
  }
}
