import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vercel/main.dart';

void main() {
  testWidgets('Wedding invitation renders hero section', (WidgetTester tester) async {
    await tester.pumpWidget(const WeddingApp());
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('WE ARE GETTING MARRIED'), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
