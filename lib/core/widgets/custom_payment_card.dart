import 'package:flutter/material.dart';

class CustomPaymentCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String? subtitle;
  final Widget trailingIcon;
  final VoidCallback onTap;

  const CustomPaymentCard({
    super.key,
    required this.icon,
    required this.title,
    required this.trailingIcon,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: 16.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF4A3C38),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            trailingIcon,
          ],
        ),
      ),
    );
  }
}
