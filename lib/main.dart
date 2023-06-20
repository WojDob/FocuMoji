import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'home.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';

void main() {
  runApp(const SquareTimer());
}

class SquareTimer extends StatelessWidget {
  const SquareTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = TimerTheme.dark();
    return MaterialApp(
      theme: theme,
      title: 'SquareTimer',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TabManager()),
        ],
        child: Home(),
      ),
    );
  }
}
