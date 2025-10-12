import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0A1732),
      body: SafeArea(
        child: FutureBuilder<String>(
          future: provider.storage?.getStorageMethodLabel() ??
              Future.value('shared_preferences (JSON)'),
          builder: (context, snap) {
            final storageLabel = snap.data ?? 'shared_preferences (JSON)';

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Reminders toggle
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SwitchListTile(
                      title: const Text(
                        'Enable Reminders',
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        'Simulated popup on app launch',
                        style: TextStyle(color: Colors.white54),
                      ),
                      value: provider.remindersEnabled,
                      activeColor: Colors.yellow,
                      onChanged: (v) => provider.setRemindersEnabled(v),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Storage info
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.storage, color: Colors.yellow),
                      title: const Text('Storage Method',
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text(storageLabel,
                          style: const TextStyle(color: Colors.white54)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Task count
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.checklist, color: Colors.yellow),
                      title: const Text('Total Tasks',
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text(
                        '${provider.tasks.length}',
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
