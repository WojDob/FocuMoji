import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedalsScreen extends StatelessWidget {
  MedalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 300,
        height: 500,
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final sharedPrefs = await SharedPreferences.getInstance();
                  final storedEmojis =
                      sharedPrefs.getStringList('emojis') ?? [];
                  print(storedEmojis);
                },
                child: Text('View Shared Preferences'),
              ),
              // EmojiListScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class EmojiListScreen extends StatefulWidget {
  @override
  _EmojiListScreenState createState() => _EmojiListScreenState();
}

class _EmojiListScreenState extends State<EmojiListScreen> {
  List<String> emojis = [];

  @override
  void initState() {
    super.initState();
    loadEmojis();
  }

  Future<void> loadEmojis() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      emojis = sharedPrefs.getStringList('emojis') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Emojis'),
      ),
      body: ListView.builder(
        itemCount: emojis.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              emojis[index],
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          );
        },
      ),
    );
  }
}
