import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/domain/app_exception.dart';
import 'package:smart_home/domain/models/user_profile.dart';
import 'package:smart_home/domain/repositories/auth_repository.dart';
import 'package:smart_home/domain/validators.dart';

// Зберігає користувачів та сесію в SharedPreferences
class LocalAuthRepository implements AuthRepository {
  static const String _usersKey = 'users';
  static const String _sessionKey = 'session';

  final SharedPreferences _prefs;

  LocalAuthRepository(this._prefs);

  List<Map<String, dynamic>> _readUsers() {
    final raw = _prefs.getString(_usersKey);
    if (raw == null) return [];
    return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
  }

  @override
  Future<void> register(String name, String email, String password) async {
    final error =
        Validators.name(name) ??
        Validators.email(email) ??
        Validators.password(password);
    if (error != null) throw AppException(error);

    final users = _readUsers();
    final cleanEmail = email.trim().toLowerCase();
    if (users.any((u) => u['email'] == cleanEmail)) {
      throw const AppException('Користувач з таким email вже існує');
    }
    users.add({'name': name.trim(), 'email': cleanEmail, 'password': password});
    await _prefs.setString(_usersKey, jsonEncode(users));
  }

  @override
  Future<UserProfile> login(String email, String password) async {
    final error = Validators.email(email) ?? Validators.password(password);
    if (error != null) throw AppException(error);

    final cleanEmail = email.trim().toLowerCase();
    final matches = _readUsers().where(
      (u) => u['email'] == cleanEmail && u['password'] == password,
    );
    if (matches.isEmpty) throw const AppException('Невірний email або пароль');

    final user = matches.first;
    final profile = UserProfile(
      name: user['name'] as String,
      email: cleanEmail,
    );
    await _prefs.setString(
      _sessionKey,
      jsonEncode({'name': profile.name, 'email': profile.email}),
    );
    return profile;
  }

  @override
  Future<UserProfile?> currentUser() async {
    final raw = _prefs.getString(_sessionKey);
    if (raw == null) return null;
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return UserProfile(
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  @override
  Future<void> logout() async {
    await _prefs.remove(_sessionKey);
  }
}
