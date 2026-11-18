import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/data/local_auth_repository.dart';
import 'package:smart_home/data/local_device_repository.dart';
import 'package:smart_home/domain/app_exception.dart';
import 'package:smart_home/domain/models/device.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('Validates registration and authenticates a saved user', () async {
    final prefs = await SharedPreferences.getInstance();
    final auth = LocalAuthRepository(prefs);
    const name = 'Тестовий користувач';
    const email = 'student@example.com';
    const password = 'TestPass123';

    await expectLater(
      auth.register('Ім’я1', 'invalid', 'short'),
      throwsA(isA<AppException>()),
    );
    await auth.register(name, email, password);
    await expectLater(
      auth.login(email, 'WrongPass123'),
      throwsA(isA<AppException>()),
    );
    final profile = await auth.login(email, password);
    expect(profile.name, name);
    expect(profile.email, email);
  });

  test('Reads, updates and deletes a device from local storage', () async {
    final prefs = await SharedPreferences.getInstance();
    final devices = LocalDeviceRepository(prefs);
    await devices.add(const Device(id: '', name: 'Лампа', room: 'Кухня'));

    await prefs.reload();
    final reopened = LocalDeviceRepository(prefs);
    final saved = (await reopened.getAll()).single;
    expect(saved.name, 'Лампа');
    expect(saved.room, 'Кухня');

    await reopened.update(saved.copyWith(room: 'Вітальня', isOn: true));
    final edited = (await reopened.getAll()).single;
    expect(edited.room, 'Вітальня');
    expect(edited.isOn, isTrue);

    await reopened.delete(edited.id);
    expect(await reopened.getAll(), isEmpty);
  });
}
