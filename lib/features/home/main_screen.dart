import 'package:material_ui/material_ui.dart';
import 'package:smart_home/features/home/device_grid.dart';
import 'package:smart_home/mock/mock_devices.dart';
import 'package:smart_home/shared/theme/app_theme.dart';
import 'package:smart_home/shared/widgets/sensor_card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мій розумний дім'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SensorCard(
              title: 'Температура вдома',
              value: '22.5 °C',
              icon: Icons.thermostat,
              subtitle: 'Оновлено щойно',
            ),
            const SizedBox(height: AppSizes.padding),
            Text(
              'Мої пристрої',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Expanded(child: DeviceGrid(devices: mockDevices)),
          ],
        ),
      ),
    );
  }
}
