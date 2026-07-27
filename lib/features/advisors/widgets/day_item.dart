import 'package:flutter/material.dart';

class DayItem extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  final bool isAvailable; // Nueva propiedad
  final Color? activeColor;
  final Color textColor;
  final VoidCallback? onTap; // Nueva propiedad opcional para el evento de clic

  const DayItem({
    super.key,
    required this.day,
    required this.date,
    required this.isSelected,
    this.isAvailable = true, // Por defecto asumimos que está disponible
    this.activeColor,
    required this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Definimos los colores basados en si está disponible y si está seleccionado
    final Color backgroundColor = isSelected 
        ? (activeColor ?? Colors.blue) 
        : Colors.transparent;
        
    final Color dayColor = isSelected 
        ? Colors.white 
        : (isAvailable ? Colors.grey[600]! : Colors.grey[400]!.withOpacity(0.5));
        
    final Color dateColor = isSelected 
        ? Colors.white 
        : (isAvailable ? textColor : Colors.grey[400]!);

    return GestureDetector(
      onTap: isAvailable ? onTap : null, // Si no está disponible, el tap es nulo (deshabilitado)
      child: Opacity(
        opacity: isAvailable ? 1.0 : 0.5, // Efecto visual translúcido para los no disponibles
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: !isSelected && !isAvailable 
                ? Border.all(color: Colors.grey.withOpacity(0.2)) 
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                day, 
                style: TextStyle(fontSize: 12, color: dayColor, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                date, 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: dateColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}