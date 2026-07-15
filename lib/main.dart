import 'package:flutter/material.dart';
import 'features/auth/presentation/screens/register_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/welcome_screen.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const AsesoriaApp());
}

class AsesoriaApp extends StatelessWidget {
  const AsesoriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asesoria 1:1',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (_) => const WelcomeScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        // '/home': (_) => const HomeScreen(), // TODO: implementar según HOME_REQUIREMENTS.md
      },
    );
  }
}
