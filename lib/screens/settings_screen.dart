import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _totalTasks = 0;
  int _completedTasks = 0;
  int _pendingTasks = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final tasks = await StorageService.loadTasks();
      final completed = tasks.where((task) => task.isCompleted).length;
      
      setState(() {
        _totalTasks = tasks.length;
        _completedTasks = completed;
        _pendingTasks = tasks.length - completed;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _clearAllData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear All Data'),
          content: const Text(
            'Are you sure you want to delete all tasks? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Delete All',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await StorageService.saveTasks([]);
      _loadStatistics();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All tasks have been deleted'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Study Planner',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        Icons.school,
        size: 48,
        color: Colors.blue,
      ),
      children: const [
        Text(
          'A simple and effective study planner app to help students manage their tasks and deadlines.',
        ),
        SizedBox(height: 16),
        Text(
          'Features:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('• View today\'s tasks'),
        Text('• Calendar view for task management'),
        Text('• Task reminders'),
        Text('• Local data storage'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                // Statistics Section
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Statistics',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _StatisticItem(
                              label: 'Total Tasks',
                              value: _totalTasks.toString(),
                              icon: Icons.task,
                              color: Colors.blue,
                            ),
                            _StatisticItem(
                              label: 'Completed',
                              value: _completedTasks.toString(),
                              icon: Icons.check_circle,
                              color: Colors.green,
                            ),
                            _StatisticItem(
                              label: 'Pending',
                              value: _pendingTasks.toString(),
                              icon: Icons.pending,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                        if (_totalTasks > 0) ...[
                          const SizedBox(height: 16),
                          LinearProgressIndicator(
                            value: _completedTasks / _totalTasks,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Progress: ${((_completedTasks / _totalTasks) * 100).toInt()}%',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // Actions Section
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.refresh, color: Colors.blue),
                        title: const Text('Refresh Statistics'),
                        subtitle: const Text('Update task statistics'),
                        onTap: _loadStatistics,
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.delete_forever, color: Colors.red),
                        title: const Text('Clear All Data'),
                        subtitle: const Text('Delete all tasks permanently'),
                        onTap: _clearAllData,
                      ),
                    ],
                  ),
                ),

                // Information Section
                Card(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.info, color: Colors.blue),
                        title: const Text('About'),
                        subtitle: const Text('App information and version'),
                        onTap: _showAboutDialog,
                      ),
                      const Divider(height: 1),
                      const ListTile(
                        leading: Icon(Icons.storage, color: Colors.green),
                        title: Text('Data Storage'),
                        subtitle: Text('Tasks are stored locally on your device'),
                      ),
                      const Divider(height: 1),
                      const ListTile(
                        leading: Icon(Icons.notifications, color: Colors.orange),
                        title: Text('Reminders'),
                        subtitle: Text('Simulated notifications shown when app opens'),
                      ),
                    ],
                  ),
                ),

                // Footer
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      'Study Planner v1.0.0',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _StatisticItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatisticItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
          color: color,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}