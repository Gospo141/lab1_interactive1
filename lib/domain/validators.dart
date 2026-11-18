// Бізнес-правила перевірки даних. null означає "все гаразд"
class Validators {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) return 'Введіть імʼя';
    if (RegExp(r'\d').hasMatch(value)) return 'Імʼя не може містити цифри';
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Введіть email';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim());
    if (!ok) return 'Email має містити @ та домен (наприклад, a@b.com)';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Введіть пароль';
    if (value.length < 8) return 'Пароль має містити мінімум 8 символів';
    return null;
  }

  static String? required(String? value, String field) {
    if (value == null || value.trim().isEmpty) {
      return '$field не може бути порожнім';
    }
    return null;
  }
}
