import 'package:flutter/material.dart';
import '../../features/home/home_screen.dart';
import '../../features/plan/screens/plan_screen.dart';
import '../../features/chat/screen/chat_list_screen.dart';
import '../../features/search/search_screen.dart';
import '../../features/profile/screen/profile_screen.dart';
import 'floating_bottom_nav.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // El orden aquí debe coincidir EXACTAMENTE con el orden de los iconos en FloatingBottomNav
  final List<Widget> _screens = [
    const HomeScreen(),        // Índice 0: Home
    const PlanPage(),          // Índice 1: Plan / Agenda
    const ChatListScreen(),    // Índice 2: Chats
    const SearchScreen(),      // Índice 3: Search
    const ProfileScreen(),     // Índice 4: Profile
  ];

  @override
  Widget build(BuildContext context) {
    // Si estamos en el perfil (índice 4), ocultamos la barra flotante
    final bool showNavBar = _currentIndex != 4;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      body: Stack(
        children: [
          Positioned.fill(
            child: _screens[_currentIndex],
          ),
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