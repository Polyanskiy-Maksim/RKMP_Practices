import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice2/main.dart';

void main() {
  testWidgets('Страница содержит тему, изображение, список и автора', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Языки программирования'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('1. Dart\n2. Python\n3. Java\n4. C++'), findsOneWidget);
    expect(
      find.text('Полянский Максим Дмитриевич\nИКБО-65-23'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Узкий экран прокручивается без переполнения', (tester) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();
    expect(
      find.text('Полянский Максим Дмитриевич\nИКБО-65-23').hitTestable(),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
