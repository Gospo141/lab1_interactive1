import 'package:material_ui/material_ui.dart';
import 'package:smart_home/domain/models/device.dart';
import 'package:smart_home/shared/theme/app_theme.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({required this.device, super.key});

  final Device device;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: device.isOn ? AppColors.primary : Colors.grey,
                ),
                const Spacer(),
                Switch(value: device.isOn, onChanged: null),
              ],
            ),
            Text(
              device.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(device.room, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
