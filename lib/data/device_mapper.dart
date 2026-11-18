import 'package:smart_home/domain/models/device.dart';

Device deviceFromJson(Map<String, dynamic> json) {
  return Device(
    id: json['id'].toString(),
    name: (json['name'] ?? '').toString(),
    room: (json['room'] ?? '').toString(),
    isOn: json['isOn'] == true,
  );
}

Map<String, dynamic> deviceToJson(Device device) {
  return {
    'id': device.id,
    'name': device.name,
    'room': device.room,
    'isOn': device.isOn,
  };
}
