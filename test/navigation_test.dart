import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:smart_home/main.dart';

void main() {
  for (final (width, columns) in [(375.0, 2), (1024.0, 4)]) {
    testWidgets('Navigates all screens at width $width', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = Size(width, 900);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const MyApp());
      expect(find.text('Вхід у Smart Home'), findsOneWidget);
      await tester.tap(find.text('Немає акаунта? Зареєструватися'));
      await tester.pumpAndSettle();
      expect(find.text('Реєстрація'), findsOneWidget);

      await tester.tap(find.text('Вже є акаунт? Увійти'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Увійти'));
      await tester.pumpAndSettle();
      expect(find.text('Мій розумний дім'), findsOneWidget);

      final grid = tester.widget<GridView>(find.byType(GridView));
      final layout =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(layout.crossAxisCount, columns);

      await tester.tap(find.byIcon(Icons.person_outline));
      await tester.pumpAndSettle();
      expect(find.text('Профіль'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
