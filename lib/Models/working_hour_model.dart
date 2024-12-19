
class Schedule {
  final String id;
  final String day;
  final String openAt;
  final String closeAt;

  Schedule({
    required this.id,
    required this.day,
    required this.openAt,
    required this.closeAt,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      day: json['day'],
      openAt: json['open_at'],
      closeAt: json['close_at'],
    );
  }
}
