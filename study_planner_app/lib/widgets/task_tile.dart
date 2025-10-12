import 'package:flutter/material.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    final dueStr = DateFormat.yMMMEd().format(task.dueDate);
    final reminderStr = task.reminderTime != null ? DateFormat.jm().format(task.reminderTime!) : 'No reminder';
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: task.isDone,
          onChanged: (_) => provider.toggleDone(task.id),
        ),
        title: Text(task.title),
        subtitle: Text('$dueStr • $reminderStr'),
        trailing: PopupMenuButton<String>(
          onSelected: (v) {
            if (v == 'edit') {
              Navigator.of(context).pushNamed('/add_edit', arguments: task); // adapt route if needed
            } else if (v == 'delete') {
              provider.deleteTask(task.id);
            }
          },
          itemBuilder: (_) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit')),
            const PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
        ),
      ),
    );
  }
}