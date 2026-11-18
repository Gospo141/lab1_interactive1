import 'package:smart_home/domain/models/user_profile.dart';

// Абстракція авторизації. UI знає тільки про неї, а не про сховище
abstract class AuthRepository {
  Future<void> register(String name, String email, String password);

  Future<UserProfile> login(String email, String password);

  Future<UserProfile?> currentUser();

  Future<void> logout();
}
