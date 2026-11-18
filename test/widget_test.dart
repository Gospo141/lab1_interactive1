import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:smart_home/main.dart';

void main() {
  testWidgets('Counter accepts integers, rejects invalid input and resets', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    final input = find.byType(TextField).last;
    final apply = find.widgetWithText(OutlinedButton, 'Застосувати');

    Future<void> submit(String value) async {
      await tester.ensureVisible(input);
      await tester.enterText(input, value);
      await tester.ensureVisible(apply);
      await tester.tap(apply);
      await tester.pumpAndSettle();
    }

    expect(find.text('Лічильник: 0'), findsOneWidget);
    await submit('7');
    expect(find.text('Лічильник: 7'), findsOneWidget);
    await submit('-2');
    expect(find.text('Лічильник: 5'), findsOneWidget);
    await submit('2.5');
    expect(find.text('Лічильник: 5'), findsOneWidget);
    expect(find.text('Введіть ціле число або Avada Kedavra'), findsOneWidget);
    await submit('Avada Kedavra');
    expect(find.text('Лічильник: 0'), findsOneWidget);
    expect(find.text('Введіть ціле число або Avada Kedavra'), findsNothing);
  });
}
