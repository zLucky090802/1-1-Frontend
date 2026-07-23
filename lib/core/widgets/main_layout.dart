import 'package:advisersapp/features/profile/profile_screen.dart';
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
  // 1. Inicia en 0 (que corresponde al Home)
  int _currentIndex = 0;

  // 2. Lista de pantallas correspondientes a cada ícono
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen(), // Placeholder para el perfil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody hace que el contenido de las pantallas baje hasta el fondo,
      // quedando por "debajo" de la barra flotante (ideal para listas largas).
      extendBody: true, 
      
      // 3. Muestra la pantalla correspondiente al índice actual
      body: _screens[_currentIndex],
      
      // 4. Ubica tu barra flotante en la parte inferior
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
          child: FloatingBottomNav(
            currentIndex: _currentIndex,
            onTap: (index) {
              // 5. Actualiza el estado al hacer clic
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}