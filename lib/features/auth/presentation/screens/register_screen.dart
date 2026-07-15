import 'package:flutter/material.dart';
import'../../../../core/theme/app_colors.dart';
import'../../../../core/widgets/custom_text_field.dart';
import'../../../../core/widgets/custom_button.dart';
import'../../../../core/widgets/responsive_auth_scaffold.dart';
import 'login_screen.dart';

/// Roles disponibles al registrarse. En inglés, como pidió el diseño.
/// Ajusta esta lista según cómo definas los perfiles de tu marketplace 1:1.
enum UserRole { client, expert, both }

extension UserRoleLabel on UserRole {
  String get label {
    switch (this) {
      case UserRole.client:
        return 'Client — looking for advice';
      case UserRole.expert:
        return 'Expert / Mentor — offering advice';
      case UserRole.both:
        return 'Both';
    }
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  UserRole? _selectedRole;
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role')),
      );
      return;
    }
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must accept the Terms and Conditions')),
      );
      return;
    }
    // TODO: conectar con tu lógica de registro / backend.
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAuthScaffold(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ------------------------------------------------------------
            // IMAGEN: ilustración persona leyendo/escribiendo acostada.
            // TODO: reemplazar imagen -> assets/images/register_illustration.png
            // ------------------------------------------------------------
            Center(
              child: Image.asset(
                
                'assets/images/register.png',

                height: 200,
               
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F2EF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Coloca aquí:\nregister_illustration.png',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Connect 1:1',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Create your account and find your expert.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),

            CustomTextField(
              hint: 'Email',
              icon: Icons.email_outlined,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Enter your email' : null,
            ),
            const SizedBox(height: 14),
            CustomTextField(
              hint: 'Password',
              icon: Icons.lock_outline,
              controller: _passwordController,
              obscureText: true,
              validator: (value) =>
                  (value == null || value.isEmpty) ? 'Enter your password' : null,
            ),
            const SizedBox(height: 14),

            // Dropdown de Role — opciones en inglés.
            CustomDropdownField<UserRole>(
              hint: 'Role',
              icon: Icons.person_outline,
              value: _selectedRole,
              items: UserRole.values
                  .map((role) => DropdownMenuItem(value: role, child: Text(role.label)))
                  .toList(),
              onChanged: (role) => setState(() => _selectedRole = role),
            ),
            const SizedBox(height: 22),

            CustomButton(label: 'Start my journey', onPressed: _handleRegister),
            const SizedBox(height: 10),

            Text(
              'By clicking, you agree to our Terms and Conditions.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 22,
                  width: 22,
                  child: Checkbox(
                    value: _acceptedTerms,
                    activeColor: AppColors.primaryButton,
                    onChanged: (value) => setState(() => _acceptedTerms = value ?? false),
                  ),
                ),
                const SizedBox(width: 8),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    children: [
                      TextSpan(text: 'I agree to the '),
                      TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            Center(
              child: Text(
                'do you have an account?',
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
            ),
            const SizedBox(height: 12),

            CustomButton(
              label: 'Sing In',
              variant: ButtonVariant.secondary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
