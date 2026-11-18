import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/data/local_auth_repository.dart';
import 'package:smart_home/data/local_device_repository.dart';
import 'package:smart_home/domain/repositories/auth_repository.dart';
import 'package:smart_home/domain/repositories/device_repository.dart';

// Глобальний контейнер залежностей (кожен обʼєкт створюється один раз)
final GetIt sl = GetIt.instance;

Future<void> setupDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  // UI працює тільки з абстракціями AuthRepository / DeviceRepository.
  // Щоб замінити сховище, змінюємо реалізацію тільки тут.
  sl.registerSingleton<AuthRepository>(LocalAuthRepository(prefs));
  sl.registerSingleton<DeviceRepository>(LocalDeviceRepository(prefs));
}
