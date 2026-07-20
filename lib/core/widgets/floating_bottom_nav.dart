import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Barra de navegación inferior flotante, tipo "pill", con 3 ítems.
/// El ítem activo se muestra con un círculo oscuro de fondo (como en el
/// diseño: Home activo).
class FloatingBottomNav extends StatelessWidget {
  const FloatingBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    Icons.home_filled,
    Icons.search,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_items.length, (index) {
          final isActive = index == currentIndex;
          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryButton : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _items[index],
                size: 22,
                color: isActive ? Colors.white : AppColors.textPrimary,
              ),
            ),
          );
        }),
      ),
    );
  }
}
