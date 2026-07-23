import 'package:flutter/material.dart';

class CustomStatusModal extends StatelessWidget {
  final bool isSuccess;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const CustomStatusModal({
    super.key,
    required this.isSuccess,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final primaryColor = isSuccess
        ? const Color(0xFF5E8D5A)
        : const Color(0xFFD96B64);

    final backgroundColor = isSuccess
        ? const Color(0xFFE8F2E6)
        : const Color(0xFFF9E4E2);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle
              ),
              child: Icon(
                isSuccess ? Icons.check_rounded : Icons.close_rounded,
                size: 50,
                color: primaryColor,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF4A3C38),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                
               style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  elevation: 0,
                ),
                onPressed: onButtonPressed,
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                
              ),

            )

          ],
        ),
      ),
    )
  }
}
