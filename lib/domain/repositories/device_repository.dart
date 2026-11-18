import 'package:smart_home/domain/models/device.dart';

// Абстракція для CRUD пристроїв (локальна БД або REST API)
abstract class DeviceRepository {
  Future<List<Device>> getAll();

  Future<void> add(Device device);

  Future<void> update(Device device);

  Future<void> delete(String id);
}
