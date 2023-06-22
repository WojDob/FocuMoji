import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class MedalsScreen extends StatelessWidget {
  MedalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emoji = EmojiParser();
    return SafeArea(child: Text('${emoji.emojify(':rocket:')}'));
  }
}
