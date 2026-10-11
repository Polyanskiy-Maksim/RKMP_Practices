import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice4/main.dart';

void main() {
  testWidgets('Gallery scrolls horizontally and keeps rounded images', (
    tester,
  ) async {
    await tester.pumpWidget(const ProgrammingLanguagesApp());
    await tester.pumpAndSettle();

    final gallery = find.byKey(const Key('gallery'));
    expect(gallery, findsOneWidget);
    expect(
      find.descendant(of: gallery, matching: find.byType(ClipRRect)),
      findsWidgets,
    );
    await tester.drag(gallery, const Offset(-700, 0));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('gallery-item-4')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Tapping a card shows the chosen name in SnackBar', (
    tester,
  ) async {
    await tester.pumpWidget(const ProgrammingLanguagesApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('language-card-0')));
    await tester.pump();
    expect(find.text('Выбран язык: Dart'), findsOneWidget);

    final list = find.byKey(const Key('language-list'));
    await tester.drag(list, const Offset(0, -600));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('language-card-4')));
    await tester.pump();
    expect(find.text('Выбран язык: JavaScript'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Compact screen still exposes the lists and student name', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const ProgrammingLanguagesApp());
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('gallery')), findsOneWidget);
    expect(find.byKey(const Key('language-list')), findsOneWidget);
    expect(find.textContaining('Полянский Максим Дмитриевич'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
