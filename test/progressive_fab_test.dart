import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:progressive_fab/progressive_fab.dart';

void main() {
  testWidgets('ProgressiveFAB renders with default values', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(floatingActionButton: ProgressiveFAB(progress: 50)),
      ),
    );
    expect(find.byType(ProgressiveFAB), findsOneWidget);
    expect(find.byType(RawMaterialButton), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
  });

  testWidgets('ProgressiveFAB calls onPressed when tapped', (
    WidgetTester tester,
  ) async {
    bool pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: ProgressiveFAB(
            progress: 75,
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );
    await tester.tap(find.byType(RawMaterialButton));
    expect(pressed, isTrue);
  });

  testWidgets('ProgressiveFAB displays custom icon and colors', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: ProgressiveFAB(
            progress: 30,
            fabColor: Colors.red,
            borderColor: Colors.green,
            progressColor: Colors.yellow,
            icon: Icon(Icons.star),
            iconColor: Colors.black,
          ),
        ),
      ),
    );
    expect(find.byIcon(Icons.star), findsOneWidget);
  });
}
