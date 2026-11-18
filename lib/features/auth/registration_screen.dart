import 'package:material_ui/material_ui.dart';
import 'package:smart_home/domain/app_exception.dart';
import 'package:smart_home/domain/repositories/auth_repository.dart';
import 'package:smart_home/domain/validators.dart';
import 'package:smart_home/injection.dart';
import 'package:smart_home/shared/widgets/auth_layout.dart';
import 'package:smart_home/shared/widgets/custom_button.dart';
import 'package:smart_home/shared/widgets/custom_text_field.dart';
import 'package:smart_home/shared/widgets/snack.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await sl<AuthRepository>().register(
        _name.text,
        _email.text,
        _password.text,
      );
      if (!mounted) return;
      showSnack(
        context,
        'Реєстрація успішна. Увійдіть у акаунт',
        isError: false,
      );
      Navigator.pop(context);
    } on AppException catch (e) {
      if (mounted) showSnack(context, e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Реєстрація',
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _name,
                label: 'Імʼя',
                icon: Icons.person_outline,
                validator: Validators.name,
              ),
              CustomTextField(
                controller: _email,
                label: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email,
              ),
              CustomTextField(
                controller: _password,
                label: 'Пароль (мінімум 8 символів)',
                icon: Icons.lock_outline,
                obscure: true,
                validator: Validators.password,
              ),
              CustomTextField(
                controller: _confirm,
                label: 'Повторіть пароль',
                icon: Icons.lock_outline,
                obscure: true,
                validator: (v) =>
                    v != _password.text ? 'Паролі не збігаються' : null,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        CustomButton(
          text: 'Зареєструватися',
          loading: _loading,
          onPressed: _register,
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Вже є акаунт? Увійти'),
        ),
      ],
    );
  }
}
