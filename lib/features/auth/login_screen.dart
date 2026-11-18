import 'package:material_ui/material_ui.dart';
import 'package:smart_home/domain/app_exception.dart';
import 'package:smart_home/domain/repositories/auth_repository.dart';
import 'package:smart_home/domain/validators.dart';
import 'package:smart_home/injection.dart';
import 'package:smart_home/shared/widgets/auth_layout.dart';
import 'package:smart_home/shared/widgets/custom_button.dart';
import 'package:smart_home/shared/widgets/custom_text_field.dart';
import 'package:smart_home/shared/widgets/snack.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await sl<AuthRepository>().login(_email.text, _password.text);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/main');
    } on AppException catch (e) {
      if (mounted) showSnack(context, e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: 'Вхід у Smart Home',
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _email,
                label: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email,
              ),
              CustomTextField(
                controller: _password,
                label: 'Пароль',
                icon: Icons.lock_outline,
                obscure: true,
                validator: Validators.password,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        CustomButton(text: 'Увійти', loading: _loading, onPressed: _login),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/register'),
          child: const Text('Немає акаунта? Зареєструватися'),
        ),
      ],
    );
  }
}
