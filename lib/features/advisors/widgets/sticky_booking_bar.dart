import 'package:flutter/material.dart';

class StickyBookingBar extends StatelessWidget {
  final double price;
  final int durationMinutes;
  final Color primaryColor;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onBookPressed;

  const StickyBookingBar({
    super.key,
    required this.price,
    required this.durationMinutes,
    required this.primaryColor,
    required this.textColor,
    required this.backgroundColor,
    required this.onBookPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          // --- AQUÍ ESTÁ EL REDONDEADO DE LAS ESQUINAS SUPERIORES ---
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24.0),
          ),
          // -----------------------------------------------------------
          border: Border(top: BorderSide(color: Colors.black.withValues(alpha: 0.05))),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Price: ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor.withValues(alpha: 0.7),
                    ),
                  ),
                  Text(
                    '\$$price / $durationMinutes min',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 0,
                ),
                onPressed: onBookPressed,
                child: const Text('Book Carla Now', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}