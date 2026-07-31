import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FloatingBottomNav extends StatelessWidget {
  const FloatingBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  // El orden de estos iconos corresponde 1 a 1 con la lista _screens de MainLayout
  static const _items = [
    Icons.home_filled,                 // Índice 0: Home
    Icons.calendar_today_rounded,      // Índice 1: Plan
    Icons.chat_bubble_outline_rounded, // Índice 2: Chat
    Icons.search,                      // Índice 3: Search
    Icons.person_outline,              // Índice 4: Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
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
              child: Icon(
                _items[index],
                size: isActive ? 26 : 22,
                color: isActive ? AppColors.primaryButton : AppColors.textPrimary,
              ),
            ),
          );
        }),
      ),
    );
  }
}