import 'package:flutter_test/flutter_test.dart';
import 'package:study_planner_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StudyPlannerApp());

    // Verify that the app loads with bottom navigation
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Calendar'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    // Verify Today's Tasks screen is displayed by default
    expect(find.text('Today\'s Tasks'), findsOneWidget);
  });

  testWidgets('Navigation test', (WidgetTester tester) async {
    await tester.pumpWidget(const StudyPlannerApp());

    // Test navigation to Calendar screen
    await tester.tap(find.text('Calendar'));
    await tester.pumpAndSettle();
    expect(find.text('Calendar'), findsWidgets);

    // Test navigation to Settings screen
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Statistics'), findsOneWidget);

    // Test navigation back to Today screen
    await tester.tap(find.text('Today'));
    await tester.pumpAndSettle();
    expect(find.text('Today\'s Tasks'), findsOneWidget);
  });
}