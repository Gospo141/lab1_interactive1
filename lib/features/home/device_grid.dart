import 'package:material_ui/material_ui.dart';
import 'package:smart_home/domain/models/device.dart';
import 'package:smart_home/shared/widgets/device_card.dart';

// Адаптивна сітка карток: 2 колонки на телефоні, 3-4 на планшеті
class DeviceGrid extends StatelessWidget {
  final List<Device> devices;
  const DeviceGrid({required this.devices, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width >= 900 ? 4 : (width >= 600 ? 3 : 2);
        return GridView.builder(
          itemCount: devices.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisExtent: 160,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final device = devices[index];
            return DeviceCard(device: device);
          },
        );
      },
    );
  }
}
