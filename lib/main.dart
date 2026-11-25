import 'package:material_ui/material_ui.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: CounterPage()),
  );
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final _input = TextEditingController();
  int _total = 0;
  String? _error;

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _applyInput() {
    final text = _input.text;
    final number = int.tryParse(text, radix: 10);

    setState(() {
      if (text == 'Avada Kedavra') {
        _total = 0;
      } else if (number != null) {
        _total += number;
      } else {
        _error = 'Введіть ціле число або Avada Kedavra';
        return;
      }
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Лічильник')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Лічильник: $_total',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _input,
                  onSubmitted: (_) => _applyInput(),
                  decoration: InputDecoration(
                    labelText: 'Ціле число або команда',
                    errorText: _error,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: _applyInput,
                  child: const Text('Застосувати'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
