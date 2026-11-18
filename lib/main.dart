import 'package:material_ui/material_ui.dart';
import 'package:smart_home/features/auth/login_screen.dart';
import 'package:smart_home/features/auth/registration_screen.dart';
import 'package:smart_home/features/home/main_screen.dart';
import 'package:smart_home/features/profile/profile_screen.dart';
import 'package:smart_home/shared/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home IoT',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: '/login',
      // Іменовані маршрути між екранами
      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegistrationScreen(),
        '/main': (_) => const MainScreen(),
        '/profile': (_) => const ProfileScreen(),
      },
    );
  }
}
