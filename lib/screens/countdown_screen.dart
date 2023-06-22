import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import '../components/squares_grid.dart';
import '../models/models.dart';
import 'package:provider/provider.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class CountdownScreen extends StatelessWidget {
  const CountdownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerProvider = context.watch<TimerManager>();

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
                          await _saveRandomEmojis();
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

  Future<void> _saveRandomEmojis() async {
    print("XDDDD");
    final emojis = await loadEmojiList();
    print("XDDD22222222222D");

    final randomEmojis = selectRandomEmojis(5, emojis);
    print("XDD33333333DD");

    await storeEmojis(randomEmojis);
    print("4444444444");
  }

  Future<List<String>> loadEmojiList() async {
    final jsonString =
        await rootBundle.loadString('assets/data/emoji_list.json');
    final List<dynamic> emojis = jsonDecode(jsonString);
    return emojis.cast<String>();
  }

  List<String> selectRandomEmojis(int count, List<String> emojis) {
    final random = Random();
    final List<String> randomEmojis = [];
    while (randomEmojis.length < count) {
      final randomIndex = random.nextInt(emojis.length);
      if (!randomEmojis.contains(emojis[randomIndex])) {
        randomEmojis.add(emojis[randomIndex]);
      }
    }
    return randomEmojis;
  }

  Future<void> storeEmojis(List<String> emojis) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final List<String> storedEmojis = sharedPrefs.getStringList('emojis') ?? [];
    storedEmojis.addAll(emojis);
    sharedPrefs.setStringList('emojis', storedEmojis);
  }

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 350),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure "),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class EmojiData {
  final String emoji;
  final String acquiredAt;

  EmojiData({required this.emoji, required this.acquiredAt});

  factory EmojiData.fromJson(Map<String, dynamic> json) {
    return EmojiData(
      emoji: json['emoji'],
      acquiredAt: json['acquiredAt'],
    );
  }

  Map<String, dynamic> toJson() => {'emoji': emoji, 'acquiredAt': acquiredAt};
}
