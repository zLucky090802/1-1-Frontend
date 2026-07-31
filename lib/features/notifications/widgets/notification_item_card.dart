import 'package:flutter/material.dart';

class NotificationItemCard extends StatelessWidget {
  final String? imageUrl;
  final IconData? icon;
  final Color? iconBgColor;
  final Color? iconColor;
  final String text;
  final String time;
  final bool isUnread;

  const NotificationItemCard({
    super.key,
    this.imageUrl,
    this.icon,
    this.iconBgColor,
    this.iconColor,
    required this.text,
    required this.time,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEFECE6), width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null)
            CircleAvatar(radius: 22, backgroundImage: NetworkImage(imageUrl!))
          else if (icon != null)
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBgColor ?? Colors.amber.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor ?? Colors.orange, size: 24),
            ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4A3C38),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (isUnread)
            Container(
              margin: const EdgeInsets.only(top: 6),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}