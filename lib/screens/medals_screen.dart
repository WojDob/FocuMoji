import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MedalsScreen extends StatefulWidget {
  const MedalsScreen({super.key});
  @override
  _MedalsScreenState createState() => _MedalsScreenState();
}

class _MedalsScreenState extends State<MedalsScreen> {
  late Future<List<String>> emojisFuture;

  @override
  void initState() {
    super.initState();
    emojisFuture = loadEmojis();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    emojisFuture = loadEmojis();
  }

  Future<List<String>> loadEmojis() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getStringList('emojis') ?? [];
  }

  Future<void> saveEmojis(List<String> emojis) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setStringList('emojis', emojis);
  }

  void addEmoji(String emoji, List<String> emojis) {
    setState(() {
      emojis.add(emoji);
    });
    saveEmojis(emojis);
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey('myUniqueKey'),
      onVisibilityChanged: (visibilityInfo) {
        setState(() {
          emojisFuture = loadEmojis();
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Selected Emojis'),
        ),
        body: FutureBuilder<List<String>>(
          future: emojisFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final emojis = snapshot.data!;
              return ListView.builder(
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
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
