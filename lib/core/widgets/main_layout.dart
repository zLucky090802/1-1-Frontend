import 'package:flutter/material.dart';
import '../../features/home/home_screen.dart';
import '../../features/search/search_screen.dart';
import '../../features/plan/screens/plan_screen.dart';
import '../../features/profile/screen/profile_screen.dart';
import 'floating_bottom_nav.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const PlanPage(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Si estamos en el perfil (índice 3), ocultamos la barra flotante
    final bool showNavBar = _currentIndex != 3;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      // Usamos Stack para controlar perfectamente el contenido y la barra flotante arriba
      body: Stack(
        children: [
          // Pantalla actual
          Positioned.fill(
            child: _screens[_currentIndex],
          ),
          
          // Barra de navegación flotante fija en la parte inferior
          if (showNavBar)
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: FloatingBottomNav(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}