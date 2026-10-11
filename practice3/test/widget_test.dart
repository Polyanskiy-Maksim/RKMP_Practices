import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practice3/main.dart';

void main() {
  testWidgets('Кнопка и изображение переключают пять ресурсов по кругу', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Изображение 1 из 5: Dart'), findsOneWidget);

    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.pumpAndSettle();
    expect(find.text('Изображение 2 из 5: Python'), findsOneWidget);
    expect(
      (tester.widget<Image>(find.byKey(const Key('languageImage'))).image
              as AssetImage)
          .assetName,
      'assets/images/python.png',
    );

    await tester.tap(find.byKey(const Key('imageTap')));
    await tester.pumpAndSettle();
    expect(find.text('Изображение 3 из 5: Java'), findsOneWidget);

    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.tap(find.byKey(const Key('nextButton')));
    await tester.pumpAndSettle();
    expect(find.text('Изображение 1 из 5: Dart'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('На узком экране доступны кнопка и данные студента', (
    tester,
  ) async {
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
    expect(find.byKey(const Key('nextButton')).hitTestable(), findsOneWidget);
    expect(
      find.text('Полянский Максим Дмитриевич\nИКБО-65-23'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
