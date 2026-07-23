import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // <-- Agrégala aquí


Widget getPaymentIcon(String type) {
  switch (type.toLowerCase()) {
    case 'mastercard':
      return SvgPicture.asset(
        'assets/images/ma_symbol.svg', // Ruta de tu SVG
        width: 32,
        height: 32,
      );
    case 'visa':
      return SvgPicture.asset(
        'assets/icons/visa.svg',
        width: 32,
        height: 32,
      );
    case 'paypal':
      return SvgPicture.asset(
        'assets/icons/paypal.svg',
        width: 32,
        height: 32,
      );
    default:
      return const Icon(Icons.credit_card, color: Color(0xFF4A3C38), size: 28);
  }
}