import 'package:advisersapp/features/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import '../../features/home/home_screen.dart';
import '../../features/search/search_screen.dart'; // Importa tu nueva pantalla
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
    const SearchScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Si estamos en el perfil (índice 2), ocultamos la barra flotante
    final bool showNavBar = _currentIndex != 2;

    return Scaffold(
      extendBody: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: showNavBar
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                child: FloatingBottomNav(
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
            )
          : null, // <-- Desaparece la barra al estar en el perfil
    );
  }
}