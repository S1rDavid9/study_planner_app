class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool hasReminder;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.hasReminder = false,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'hasReminder': hasReminder,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['dueDate']),
      hasReminder: json['hasReminder'] ?? false,
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? hasReminder,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      hasReminder: hasReminder ?? this.hasReminder,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  bool get isDueToday {
    final now = DateTime.now();
    return dueDate.year == now.year && 
           dueDate.month == now.month && 
           dueDate.day == now.day;
  }

  bool get isOverdue {
    final now = DateTime.now();
    return dueDate.isBefore(DateTime(now.year, now.month, now.day)) && !isCompleted;
  }
}