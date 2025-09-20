import 'package:flutter_test/flutter_test.dart';
import 'package:study_planner_app/models/task.dart';

void main() {
  group('Task Model Tests', () {
    test('should create a task with required fields', () {
      final task = Task(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        dueDate: DateTime(2024, 1, 1, 10, 0),
      );

      expect(task.id, '1');
      expect(task.title, 'Test Task');
      expect(task.description, 'Test Description');
      expect(task.dueDate, DateTime(2024, 1, 1, 10, 0));
      expect(task.hasReminder, false);
      expect(task.isCompleted, false);
    });

    test('should convert task to JSON correctly', () {
      final task = Task(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        dueDate: DateTime(2024, 1, 1, 10, 0),
        hasReminder: true,
        isCompleted: false,
      );

      final json = task.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Test Task');
      expect(json['description'], 'Test Description');
      expect(json['dueDate'], '2024-01-01T10:00:00.000');
      expect(json['hasReminder'], true);
      expect(json['isCompleted'], false);
    });

    test('should create task from JSON correctly', () {
      final json = {
        'id': '1',
        'title': 'Test Task',
        'description': 'Test Description',
        'dueDate': '2024-01-01T10:00:00.000',
        'hasReminder': true,
        'isCompleted': false,
      };

      final task = Task.fromJson(json);

      expect(task.id, '1');
      expect(task.title, 'Test Task');
      expect(task.description, 'Test Description');
      expect(task.dueDate, DateTime(2024, 1, 1, 10, 0));
      expect(task.hasReminder, true);
      expect(task.isCompleted, false);
    });

    test('should correctly identify if task is due today', () {
      final today = DateTime.now();
      final todayTask = Task(
        id: '1',
        title: 'Today Task',
        description: '',
        dueDate: today,
      );

      final tomorrow = today.add(const Duration(days: 1));
      final tomorrowTask = Task(
        id: '2',
        title: 'Tomorrow Task',
        description: '',
        dueDate: tomorrow,
      );

      expect(todayTask.isDueToday, true);
      expect(tomorrowTask.isDueToday, false);
    });

    test('should correctly identify overdue tasks', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final overdueTask = Task(
        id: '1',
        title: 'Overdue Task',
        description: '',
        dueDate: yesterday,
        isCompleted: false,
      );

      final completedOverdueTask = Task(
        id: '2',
        title: 'Completed Overdue Task',
        description: '',
        dueDate: yesterday,
        isCompleted: true,
      );

      expect(overdueTask.isOverdue, true);
      expect(completedOverdueTask.isOverdue, false);
    });

    test('should copy task with updated fields', () {
      final originalTask = Task(
        id: '1',
        title: 'Original',
        description: 'Original Description',
        dueDate: DateTime(2024, 1, 1),
      );

      final updatedTask = originalTask.copyWith(
        title: 'Updated',
        isCompleted: true,
      );

      expect(updatedTask.id, '1');
      expect(updatedTask.title, 'Updated');
      expect(updatedTask.description, 'Original Description');
      expect(updatedTask.dueDate, DateTime(2024, 1, 1));
      expect(updatedTask.isCompleted, true);
    });
  });
}