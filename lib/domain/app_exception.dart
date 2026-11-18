// Наша власна помилка з повідомленням, зрозумілим користувачу
class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}
