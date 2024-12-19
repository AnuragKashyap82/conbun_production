import 'package:intl/intl.dart';

class NotificationModel {
  final String id;
  final String userId;
  final String isRead;
  final String isReadInline;
  final String date;
  final String title;
  final String description;
  final String? link; // Optional field

  NotificationModel({
    required this.id,
    required this.userId,
    required this.isRead,
    required this.isReadInline,
    required this.date,
    required this.title,
    required this.description,
    this.link,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      userId: json['userid'] ?? '',
      isRead: json['isread'] ?? '',
      isReadInline: json['isread_inline'] ?? '',
      date: json['date'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userId,
      'isread': isRead,
      'isread_inline': isReadInline,
      'date': date,
      'title': title,
      'description': description,
      'link': link,
    };
  }

  factory NotificationModel.empty() {
    return NotificationModel(
      id: '',
      userId: '',
      isRead: '',
      isReadInline: '',
      date: '',
      title: '',
      description: '',
      link: null,
    );
  }
}
