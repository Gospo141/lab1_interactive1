import 'package:material_ui/material_ui.dart';
import 'package:smart_home/domain/models/user_profile.dart';
import 'package:smart_home/domain/repositories/auth_repository.dart';
import 'package:smart_home/injection.dart';
import 'package:smart_home/shared/widgets/profile_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final Future<UserProfile?> _future = sl<AuthRepository>().currentUser();

  Future<void> _logout() async {
    await sl<AuthRepository>().logout();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профіль')),
      body: FutureBuilder<UserProfile?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final user = snapshot.data;
          return ProfileView(
            name: user?.name ?? 'Невідомий',
            email: user?.email ?? '-',
            onLogout: _logout,
          );
        },
      ),
    );
  }
}
