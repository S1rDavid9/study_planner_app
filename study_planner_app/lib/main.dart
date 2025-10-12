import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart' as task_provider;
import 'services/storage_service.dart';
import 'screens/today_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/add_edit_task_screen.dart';
import 'models/task.dart';

void main() {
  runApp(const StudyPlannerApp());
}

class StudyPlannerApp extends StatelessWidget {
  const StudyPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = StorageService();

    return ChangeNotifierProvider(
      create: (_) => task_provider.TaskProvider(storage: storage)..load(),
      child: MaterialApp(
        title: 'Study Planner',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF0A1732), // Navy background
          primaryColor: const Color(0xFFFFC300), // Yellow
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF0A1732),
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFFFC300),
            foregroundColor: Colors.black,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF0A1732),
            selectedItemColor: Color(0xFFFFC300),
            unselectedItemColor: Colors.white70,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
          useMaterial3: true,
        ),
        home: const MainShell(),
        routes: {
          AddEditTaskScreen.routeName: (_) => const AddEditTaskScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;
  final _pages = [
    const TodayScreen(),
    const CalendarScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkReminders());
  }

  Future<void> _checkReminders() async {
    final provider = Provider.of<task_provider.TaskProvider>(context, listen: false);
    final now = DateTime.now();
    final due = provider.dueReminders(now);
    if (due.isNotEmpty) {
      for (final task in due) {
        if (!mounted) return;
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: const Color(0xFF0A1732),
            title: Text(
              'Reminder: ${task.title}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            content: Text(task.description ?? 'No description',
                style: const TextStyle(color: Colors.white70)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK', style: TextStyle(color: Color(0xFFFFC300))),
              ),
            ],
          ),
        );
      }
    }
  }

  void _onTap(int idx) => setState(() => _selectedIndex = idx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Planner'),
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: _selectedIndex != 2
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).pushNamed(AddEditTaskScreen.routeName),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Today'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}