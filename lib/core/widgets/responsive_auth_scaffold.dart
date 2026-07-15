import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Envoltorio responsive para las pantallas de autenticación.
///
/// - En móvil (< 600px): el contenido ocupa todo el ancho, fondo blanco,
///   igual a como se vería una app nativa normal.
/// - En tablet/escritorio/web (>= 600px): se simula el "artboard" del
///   diseño -> fondo oscuro alrededor y una tarjeta blanca centrada con
///   ancho máximo de 440px y esquinas redondeadas.
///
/// Además es scrollable para que nunca haga overflow con teclado abierto
/// o pantallas bajas.
class ResponsiveAuthScaffold extends StatelessWidget {
  const ResponsiveAuthScaffold({super.key, required this.child});

  final Widget child;

  static const double _breakpoint = 600;
  static const double _cardMaxWidth = 440;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= _breakpoint;

          final content = SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
              child: child,
            ),
          );

          if (!isWide) {
            // Mobile: full width, fondo blanco directo.
            return Container(color: AppColors.surface, child: content);
          }

          // Tablet / Desktop / Web: tarjeta centrada tipo "artboard".
          return Container(
            color: AppColors.background,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _cardMaxWidth),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.35),
                      blurRadius: 40,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: content,
              ),
            ),
          );
        },
      ),
    );
  }
}
