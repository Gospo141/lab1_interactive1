// Модель IoT-пристрою. Усі поля final - обʼєкт незмінний
class Device {
  final String id;
  final String name;
  final String room;
  final bool isOn;

  const Device({
    required this.id,
    required this.name,
    required this.room,
    this.isOn = false,
  });
}
