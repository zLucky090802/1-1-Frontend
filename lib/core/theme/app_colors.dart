import 'package:flutter/material.dart';

/// Paleta de colores extraída del diseño (login / welcome / register).
class AppColors {
  AppColors._();

  // Fondo oscuro exterior (solo visible en pantallas anchas/web/tablet)
  static const Color background = Color(0xFF181818);

  // Tarjeta / superficie principal
  static const Color surface = Colors.white;

  // Botón primario (oscuro, tipo "Login" / "Sign in" / "Start my journey")
  static const Color primaryButton = Color(0xFF4A2E2C);
  static const Color primaryButtonText = Colors.white;

  // Botón secundario (crema, tipo "Sign Up" / "Sign In" outline)
  static const Color secondaryButton = Color(0xFFEDEAE0);
  static const Color secondaryButtonText = Color(0xFF262626);

  // Forma/acento rosa-salmón de la pantalla "Welcome"
  static const Color accentPink = Color(0xFFF2A98D);
  static const Color accentPinkSoft = Color(0xFFF6C3B0);

  // Textos
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF8A8A8A);
  static const Color textLink = Color(0xFF1A1A1A);

  // Inputs
  static const Color inputBorder = Color(0xFFE1DEDA);
  static const Color inputHint = Color(0xFFB0ADA8);
  static const Color inputIcon = Color(0xFF9C9994);

  // ---- Home ----
  // Fondo general de la pantalla Home (crema muy claro).
  static const Color homeBackground = Color(0xFFF7F6F3);

  // Card "Start your learning journey".
  static const Color heroCard = Color(0xFFF0A385);

  // Card de estado vacío "Our expert community is growing!".
  static const Color emptyStateCard = Color(0xFFE7E6EF);
  static const Color emptyStateText = Color(0xFF5F5E67);

  // Avatar placeholder cuando no hay foto de usuario.
  static const Color avatarPlaceholder = Color(0xFFD8D6D0);
}
