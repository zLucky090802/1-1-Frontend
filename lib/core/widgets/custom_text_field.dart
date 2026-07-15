import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Campo de texto tipo "pill" con icono a la izquierda, igual al del diseño
/// (Email, Password).
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
  });

  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, size: 20, color: AppColors.inputIcon),
      ),
    );
  }
}

/// Dropdown con el mismo estilo "pill" que los text fields (usado en Role).
class CustomDropdownField<T> extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    required this.hint,
    required this.icon,
    required this.items,
    required this.onChanged,
    this.value,
  });

  final String hint;
  final IconData icon;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final T? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.inputIcon),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, size: 20, color: AppColors.inputIcon),
      ),
    );
  }
}
