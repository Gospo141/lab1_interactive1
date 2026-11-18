import 'package:material_ui/material_ui.dart';
import 'package:smart_home/domain/models/device.dart';
import 'package:smart_home/domain/validators.dart';
import 'package:smart_home/shared/widgets/custom_text_field.dart';

// Показує діалог створення (initial == null) або редагування пристрою
Future<Device?> showDeviceDialog(BuildContext context, {Device? initial}) {
  return showDialog<Device>(
    context: context,
    builder: (_) => DeviceDialog(initial: initial),
  );
}

class DeviceDialog extends StatefulWidget {
  final Device? initial;

  const DeviceDialog({super.key, this.initial});

  @override
  State<DeviceDialog> createState() => _DeviceDialogState();
}

class _DeviceDialogState extends State<DeviceDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name = TextEditingController(
    text: widget.initial?.name ?? '',
  );
  late final TextEditingController _room = TextEditingController(
    text: widget.initial?.room ?? '',
  );

  @override
  void dispose() {
    _name.dispose();
    _room.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final base = widget.initial ?? const Device(id: '', name: '', room: '');
    Navigator.pop(
      context,
      base.copyWith(name: _name.text.trim(), room: _room.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isNew = widget.initial == null;
    return AlertDialog(
      title: Text(isNew ? 'Новий пристрій' : 'Редагувати пристрій'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: _name,
              label: 'Назва',
              icon: Icons.devices,
              validator: (v) => Validators.required(v, 'Назва'),
            ),
            CustomTextField(
              controller: _room,
              label: 'Кімната',
              icon: Icons.meeting_room_outlined,
              validator: (v) => Validators.required(v, 'Кімната'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Скасувати'),
        ),
        TextButton(onPressed: _save, child: const Text('Зберегти')),
      ],
    );
  }
}
