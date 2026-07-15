import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auth_divider.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/responsive_auth_scaffold.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Quitamos LayoutBuilder, ConstrainedBox y SingleChildScrollView de aquí,
    // ya que ResponsiveAuthScaffold debería encargarse de la estructura base.
    return ResponsiveAuthScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),

            // 1. IMAGEN O FORMA PERSONALIZADA
            SizedBox(
              height: 220,
              child: Image.asset(
                'assets/images/welcome.png',
                errorBuilder: (context, error, stackTrace) => const _WelcomeHeroShape(),
              ),
            ),
            const SizedBox(height: 32),

            // 2. TEXTOS PRINCIPALES
            Text(
              'Connect. Learn. Grow.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'Your private space for 1:1 encounters that transform ideas into results.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            
            // 3. ESPACIADO FIJO Y SEGURO (Previene el bucle de infinitos)
            const SizedBox(height: 64),

            // 4. BOTONES DE ACCIÓN
            CustomButton(
              label: 'Sign in',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            const AuthDivider(),
            const SizedBox(height: 20),
            CustomButton(
              label: 'Sign Up',
              variant: ButtonVariant.secondary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// Recreación simple (100% widgets, sin imagen) de la forma rosa de fondo
/// con el icono de gráfico arriba, por si no quieres usar un PNG externo
/// para esta pantalla.
class _WelcomeHeroShape extends StatelessWidget {
  const _WelcomeHeroShape();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: _HillClipper(),
          child: Container(height: 160, color: AppColors.accentPink),
        ),
        Positioned(
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.textPrimary, width: 1.5),
            ),
            child: const Icon(Icons.show_chart, size: 26),
          ),
        ),
        const Positioned(
          bottom: 20,
          child: Icon(
            Icons.people_alt_outlined,
            size: 40,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _HillClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width * 0.25,
      0,
      size.width * 0.5,
      size.height * 0.4,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.8,
      size.width,
      size.height * 0.2,
    );
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
