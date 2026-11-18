import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/data/device_mapper.dart';
import 'package:smart_home/domain/models/device.dart';
import 'package:smart_home/domain/repositories/device_repository.dart';

// Локальна реалізація CRUD (SharedPreferences, JSON-рядок)
class LocalDeviceRepository implements DeviceRepository {
  static const String _key = 'devices';

  final SharedPreferences _prefs;

  LocalDeviceRepository(this._prefs);

  @override
  Future<List<Device>> getAll() async {
    final raw = _prefs.getString(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list.map((e) => deviceFromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> _saveAll(List<Device> devices) async {
    final data = devices.map(deviceToJson).toList();
    await _prefs.setString(_key, jsonEncode(data));
  }

  @override
  Future<void> add(Device device) async {
    final list = await getAll();
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    list.add(
      Device(id: id, name: device.name, room: device.room, isOn: device.isOn),
    );
    await _saveAll(list);
  }

  @override
  Future<void> update(Device device) async {
    final list = await getAll();
    final updated = list.map((d) => d.id == device.id ? device : d).toList();
    await _saveAll(updated);
  }

  @override
  Future<void> delete(String id) async {
    final list = await getAll();
    list.removeWhere((d) => d.id == id);
    await _saveAll(list);
  }
}
