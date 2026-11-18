import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:smart_home/main.dart';

void main() {
  testWidgets('Adds integers, rejects invalid input and resets', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: CounterPage()));

    Future<void> submit(String value) async {
      await tester.enterText(find.byType(TextField), value);
      await tester.tap(find.text('Застосувати'));
      await tester.pump();
    }

    expect(find.text('Лічильник: 0'), findsOneWidget);
    await submit('7');
    await submit('-2');
    expect(find.text('Лічильник: 5'), findsOneWidget);

    for (final invalid in ['abc', '2.5', '0x10', 'avada kedavra']) {
      await submit(invalid);
      expect(find.text('Лічильник: 5'), findsOneWidget);
      expect(find.text('Введіть ціле число або Avada Kedavra'), findsOneWidget);
    }

    await submit('Avada Kedavra');
    expect(find.text('Лічильник: 0'), findsOneWidget);
    expect(find.text('Введіть ціле число або Avada Kedavra'), findsNothing);
  });
}
