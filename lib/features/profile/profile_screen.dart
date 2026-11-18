import 'package:material_ui/material_ui.dart';
import 'package:smart_home/shared/widgets/profile_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профіль')),
      body: ProfileView(
        name: 'Andriy Rudyk',
        email: 'student@example.com',
        onLogout: () => Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false,
        ),
      ),
    );
  }
}
