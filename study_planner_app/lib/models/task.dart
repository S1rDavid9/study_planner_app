import 'package:flutter/foundation.dart';

class Task {
  String id;
  String title;
  String? description;
  DateTime dueDate;          
  DateTime? reminderTime;   
  bool isDone;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.dueDate,
    this.reminderTime,
    this.isDone = false,
  });

  factory Task.fromJson(Map<String, dynamic> j) => Task(
    id: j['id'] as String,
    title: j['title'] as String,
    description: j['description'] as String?,
    dueDate: DateTime.parse(j['dueDate'] as String),
    reminderTime: j['reminderTime'] != null ? DateTime.parse(j['reminderTime'] as String) : null,
    isDone: j['isDone'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'dueDate': dueDate.toIso8601String(),
    'reminderTime': reminderTime?.toIso8601String(),
    'isDone': isDone,
  };
}