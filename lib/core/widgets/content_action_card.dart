import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Card grande de contenido con título, descripción y botón "start now".
/// Se reutiliza tanto para el hero "Start your learning journey" (fondo
/// coral) como para el estado vacío "Our expert community is growing!"
/// (fondo lavanda), solo cambiando los colores.
class ContentActionCard extends StatelessWidget {
  const ContentActionCard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.backgroundColor,
    required this.titleColor,
    required this.descriptionColor,
    this.onPressed,
  });

  final String title;
  final String description;
  final String buttonLabel;
  final Color backgroundColor;
  final Color titleColor;
  final Color descriptionColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: titleColor,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 13, color: descriptionColor, height: 1.5),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryButton,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }
}
