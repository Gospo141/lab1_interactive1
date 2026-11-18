import 'package:material_ui/material_ui.dart';
import 'package:smart_home/domain/models/device.dart';
import 'package:smart_home/domain/repositories/device_repository.dart';
import 'package:smart_home/features/home/device_dialog.dart';
import 'package:smart_home/features/home/device_grid.dart';
import 'package:smart_home/injection.dart';
import 'package:smart_home/shared/theme/app_theme.dart';
import 'package:smart_home/shared/widgets/sensor_card.dart';
import 'package:smart_home/shared/widgets/snack.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final DeviceRepository _repo = sl<DeviceRepository>();
  List<Device> _devices = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  // READ
  Future<void> _load() async {
    final list = await _repo.getAll();
    if (!mounted) return;
    setState(() {
      _devices = list;
      _loading = false;
    });
  }

  // CREATE
  Future<void> _add() async {
    final device = await showDeviceDialog(context);
    if (device == null) return;
    await _repo.add(device);
    await _load();
  }

  // UPDATE (назва / кімната)
  Future<void> _edit(Device device) async {
    final updated = await showDeviceDialog(context, initial: device);
    if (updated == null) return;
    await _repo.update(updated);
    await _load();
  }

  // UPDATE (перемикач)
  Future<void> _toggle(Device device, bool value) async {
    await _repo.update(device.copyWith(isOn: value));
    await _load();
  }

  // DELETE
  Future<void> _delete(Device device) async {
    await _repo.delete(device.id);
    await _load();
    if (mounted) showSnack(context, 'Пристрій видалено', isError: false);
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: const Icon(Icons.add),
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
            ),
            const SizedBox(height: AppSizes.padding),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_devices.isEmpty) {
      return const Center(child: Text('Пристроїв ще немає. Натисніть +'));
    }
    return DeviceGrid(
      devices: _devices,
      onToggle: _toggle,
      onEdit: _edit,
      onDelete: _delete,
    );
  }
}
