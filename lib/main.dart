import 'package:material_ui/material_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Розумна лампа',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const LampScreen(),
    );
  }
}

// Екран "Розумна лампа" з інтерактивними елементами
class LampScreen extends StatefulWidget {
  const LampScreen({super.key});

  @override
  State<LampScreen> createState() => _LampScreenState();
}

class _LampScreenState extends State<LampScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _counterController = TextEditingController();
  bool _isOn = false;
  double _brightness = 50;
  int _count = 0;
  String? _counterError;
  bool _nightMode = false;
  String _room = 'Вітальня';
  String _greeting = '';

  @override
  void dispose() {
    _nameController.dispose();
    _counterController.dispose();
    super.dispose();
  }

  void _applyCounterInput() {
    final input = _counterController.text;
    final increment = RegExp(r'^[+-]?[0-9]+$').hasMatch(input.trim())
        ? int.tryParse(input.trim())
        : null;

    setState(() {
      if (input == 'Avada Kedavra') {
        _count = 0;
      } else if (increment != null) {
        _count += increment;
      } else {
        _counterError = 'Введіть ціле число або Avada Kedavra';
        return;
      }
      _counterError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color lampColor = _isOn
        ? Color.fromRGBO(255, 214, 0, _brightness / 100)
        : Colors.grey.shade300;

    return Scaffold(
      appBar: AppBar(title: const Text('Розумна лампа')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Лампа змінює колір
            Icon(Icons.lightbulb, size: 100, color: lampColor),
            const SizedBox(height: 16),

            //  Switch
            SwitchListTile(
              title: const Text('Увімкнути лампу'),
              value: _isOn,
              onChanged: (value) => setState(() => _isOn = value),
            ),

            //  Slider
            Text('Яскравість: ${_brightness.round()}%'),
            Slider(
              value: _brightness,
              min: 0,
              max: 100,
              divisions: 20,
              onChanged: (value) => setState(() => _brightness = value),
            ),

            //  Checkbox
            CheckboxListTile(
              title: const Text('Нічний режим'),
              value: _nightMode,
              onChanged: (value) => setState(() => _nightMode = value ?? false),
            ),

            //  Dropdown
            DropdownButton<String>(
              value: _room,
              isExpanded: true,
              items: const [
                'Вітальня',
                'Спальня',
                'Кухня',
              ].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
              onChanged: (value) => setState(() => _room = value ?? _room),
            ),
            const SizedBox(height: 16),

            // TextField + кнопка
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Ваше імʼя',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => setState(() {
                _greeting = 'Привіт, ${_nameController.text}! Кімната: $_room';
              }),
              child: const Text('Привітатися'),
            ),
            Text(_greeting, textAlign: TextAlign.center),
            const SizedBox(height: 16),

            Text('Лічильник: $_count', textAlign: TextAlign.center),
            const SizedBox(height: 8),
            TextField(
              controller: _counterController,
              decoration: InputDecoration(
                labelText: 'Команда лічильника',
                hintText: 'Ціле число або Avada Kedavra',
                errorText: _counterError,
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => _applyCounterInput(),
            ),
            OutlinedButton(
              onPressed: _applyCounterInput,
              child: const Text('Застосувати'),
            ),
          ],
        ),
      ),
    );
  }
}
