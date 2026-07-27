import 'package:flutter/material.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  // Estados de los toggles y configuraciones
  bool _isDarkMode = false;
  bool _isBiometricEnabled = true;
  bool _isPushNotificationsEnabled = true;
  bool _isEmailAlertsEnabled = true;
  String _selectedTimeZone = 'GMT -05:00 (Bogota, Lima)';
  
  // Opción seleccionada para la pantalla de inicio
  String _startScreenOption = 'Home / Dashboard';

  final List<String> _availableStartScreens = [
    'Home / Dashboard',
    'History',
    'Currencies',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF2C1D11)),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Preferences',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C1D11),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // Contenido en lista con scroll
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                children: [
                  // Sección: General Settings
                  _buildSectionTitle('General Settings'),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildSwitchTile(
                          icon: Icons.dark_mode_outlined,
                          title: 'Dark Mode',
                          value: _isDarkMode,
                          onChanged: (val) => setState(() => _isDarkMode = val),
                        ),
                        const Divider(height: 1, indent: 56, endIndent: 16, color: Color(0xFFF0EBE1)),
                        _buildSwitchTile(
                          icon: Icons.fingerprint_outlined,
                          title: 'Biometric Lock',
                          subtitle: 'Enable/Disable all',
                          value: _isBiometricEnabled,
                          onChanged: (val) => setState(() => _isBiometricEnabled = val),
                        ),
                        const Divider(height: 1, indent: 56, endIndent: 16, color: Color(0xFFF0EBE1)),
                        _buildNavigationTile(
                          icon: Icons.access_time_outlined,
                          title: 'Time Zone',
                          trailingText: _selectedTimeZone,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sección: Notification & Alerts
                  _buildSectionTitle('Notification & Alerts'),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildSwitchTile(
                          icon: Icons.notifications_outlined,
                          title: 'Push Notifications',
                          subtitle: 'Enable/Disable all',
                          value: _isPushNotificationsEnabled,
                          onChanged: (val) => setState(() => _isPushNotificationsEnabled = val),
                        ),
                        const Divider(height: 1, indent: 56, endIndent: 16, color: Color(0xFFF0EBE1)),
                        _buildSwitchTile(
                          icon: Icons.email_outlined,
                          title: 'Email Alerts',
                          subtitle: 'Session summaries, updates',
                          value: _isEmailAlertsEnabled,
                          onChanged: (val) => setState(() => _isEmailAlertsEnabled = val),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sección: Display (Start Screen interactivo con BottomSheet)
                  _buildSectionTitle('Display'),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildNavigationTile(
                          icon: Icons.home_outlined,
                          title: 'Start Screen',
                          trailingText: _startScreenOption,
                          onTap: _showStartScreenBottomSheet,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Desplegable tipo Bottom Sheet para elegir la pantalla de inicio
  void _showStartScreenBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFFFDFBF7),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barra indicadora superior
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose Start Screen',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C1D11),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select which screen you want to see when you open the app.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),
              // Lista de opciones disponibles
              ..._availableStartScreens.map((screen) {
                final isSelected = _startScreenOption == screen;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFE8997D).withValues(alpha: 0.1) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? const Color(0xFFE8997D) : Colors.transparent,
                      width: 1.2,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      screen,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? const Color(0xFFE8997D) : const Color(0xFF2C1D11),
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: Color(0xFFE8997D), size: 20)
                        : null,
                    onTap: () {
                      setState(() {
                        _startScreenOption = screen;
                      });
                      Navigator.pop(context);
                    },
                  ),
                );
              }),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  // Título de sección
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2C1D11),
      ),
    );
  }

  // Tile con Switch
  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8997D).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFFE8997D), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C1D11),
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFFE8997D),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // Tile de navegación
  Widget _buildNavigationTile({
    required IconData icon,
    required String title,
    required String trailingText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFE8997D).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFFE8997D), size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C1D11),
                ),
              ),
            ),
            Text(
              trailingText,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}