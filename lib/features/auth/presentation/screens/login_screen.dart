import 'package:advisersapp/core/widgets/main_layout.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../home/home_screen.dart';
import '../../../../core/widgets/responsive_auth_scaffold.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/auth_divider.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: conectar con tu lógica de autenticación / backend.
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAuthScaffold(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    '¡Welcome back!',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Log in and make things happen today. Your dashboard is waiting for you.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // ------------------------------------------------------------
                  // IMAGEN: ilustración persona relajada en silla reclinable.
                  // TODO: reemplazar imagen -> assets/images/login_illustration.png
                  // Sugerencia: ilustración estilo unDraw / Storyset en tonos
                  // negro-blanco-rosa para mantener coherencia visual.
                  // ------------------------------------------------------------
                  Center(
                    child: Image.asset(
                      'assets/images/login.png',
                      height: 200,
                      errorBuilder: (context, error, stackTrace) =>
                          _ImagePlaceholder(label: 'login.png'),
                    ),
                  ),
                  const SizedBox(height: 24),

                  CustomTextField(
                    hint: 'Email',
                    icon: Icons.email_outlined,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Enter your email'
                        : null,
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    hint: 'Password',
                    icon: Icons.lock_outline,
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Enter your password'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // TODO: navegar a recuperación de contraseña.
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.textSecondary,
                      ),
                      child: const Text('forgot password?'),
                    ),
                  ),
                  const SizedBox(height: 10),

                  CustomButton(
                    label: 'Login',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const MainLayout()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const AuthDivider(),
                  const SizedBox(height: 20),

                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                        children: [
                          const TextSpan(text: 'need an account? '),
                          TextSpan(
                            text: 'Sing Up',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizerBuilder.of(() {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const RegisterScreen(),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Placeholder visual mientras no se agrega la imagen real.
class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F2EF),
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: Text(
        'Coloca aquí:\n$label',
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
      ),
    );
  }
}

/// Pequeño helper para usar TapGestureRecognizer sin importar
/// flutter/gestures.dart en cada archivo repetidamente.
class TapGestureRecognizerBuilder {
  static GestureRecognizer of(VoidCallback onTap) {
    return TapGestureRecognizer()..onTap = onTap;
  }
}
