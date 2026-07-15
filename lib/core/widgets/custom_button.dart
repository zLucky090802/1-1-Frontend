import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum ButtonVariant { primary, secondary }

/// Botón "pill" de ancho completo. Variante primary = oscuro (Login, Sign in,
/// Start my journey). Variante secondary = crema (Sign Up, Sign In).
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final isPrimary = variant == ButtonVariant.primary;

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isPrimary ? AppColors.primaryButton : AppColors.secondaryButton,
          foregroundColor: isPrimary
              ? AppColors.primaryButtonText
              : AppColors.secondaryButtonText,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
