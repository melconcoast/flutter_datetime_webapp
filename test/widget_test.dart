// This is a basic Flutter widget test for the Timezone Hub app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:flutter_datetime_webapp/main.dart';

void main() {
  setUpAll(() {
    // Initialize timezone data for tests
    tz.initializeTimeZones();
  });

  testWidgets('TimeZone Hub app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2)); // Allow time for providers to initialize

    // Verify that our app title appears
    expect(find.text('TimeZone Hub'), findsOneWidget);
    
    // Verify that the settings button is present
    expect(find.byIcon(Icons.tune_rounded), findsOneWidget);
    
    // Verify that the add timezone FAB is present
    expect(find.byIcon(Icons.add_rounded), findsOneWidget);
  });

  testWidgets('Add timezone dialog opens when FAB is tapped', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2)); // Allow time for providers to initialize

    // Find and tap the add timezone FAB
    await tester.tap(find.byIcon(Icons.add_rounded));
    await tester.pump(); // Process the tap
    await tester.pump(const Duration(milliseconds: 300)); // Allow animation to complete

    // Verify that the timezone selection dialog appears
    expect(find.text('Search Timezone'), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('Settings button is present and tappable', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2)); // Allow time for providers to initialize

    // Verify that the settings button is present and can be tapped without errors
    expect(find.byIcon(Icons.tune_rounded), findsOneWidget);
    
    // Try to tap the settings button (should not throw errors)
    await tester.tap(find.byIcon(Icons.tune_rounded));
    await tester.pump(); // Process the tap
    
    // Just verify no errors occurred during interaction
    expect(find.byIcon(Icons.tune_rounded), findsOneWidget);
  });
}