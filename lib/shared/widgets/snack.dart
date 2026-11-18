import 'package:material_ui/material_ui.dart';
import 'package:smart_home/shared/theme/app_theme.dart';

// Показує SnackBar з повідомленням (червоний - помилка, зелений - успіх)
void showSnack(BuildContext context, String message, {bool isError = true}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? AppColors.error : AppColors.success,
    ),
  );
}
