import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app_theme.dart';
import 'login.dart';
import 'package:provider/provider.dart';
import 'models/models.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        child: LoginScreen(),
      ),
    );
  }
}
