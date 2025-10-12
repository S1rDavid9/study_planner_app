import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class StorageService {
  static const _tasksKey = 'tasks_json';
  static const _reminderEnabledKey = 'reminder_enabled';
  static const _storageMethodKey = 'storage_method';

  // Save list of tasks
  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(tasks.map((t) => t.toJson()).toList());
    await prefs.setString(_tasksKey, jsonStr);
    // save storage method label
    await prefs.setString(_storageMethodKey, 'shared_preferences (JSON)');
  }

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_tasksKey);
    if (jsonStr == null) return [];
    final decoded = jsonDecode(jsonStr) as List<dynamic>;
    return decoded.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> setReminderEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_reminderEnabledKey, enabled);
  }

  Future<bool> getReminderEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_reminderEnabledKey) ?? true;
  }

  Future<String> getStorageMethodLabel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_storageMethodKey) ?? 'shared_preferences (JSON)';
  }
}