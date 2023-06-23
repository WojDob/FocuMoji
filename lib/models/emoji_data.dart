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
