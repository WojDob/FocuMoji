class Reward {
  final String symbol;
  final DateTime acquiredAt;
  final String timerName;

  Reward({
    required this.symbol,
    required this.acquiredAt,
    required this.timerName,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      symbol: json['symbol'],
      acquiredAt: DateTime.parse(json['acquiredAt']),
      timerName: json['timerName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'acquiredAt': acquiredAt.toIso8601String(),
      'timerName': timerName,
    };
  }
}
