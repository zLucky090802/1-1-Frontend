import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Línea divisoria con texto "or" en el centro, igual al del diseño.
class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key, this.text = 'or'});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.inputBorder)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.inputBorder)),
      ],
    );
  }
}
