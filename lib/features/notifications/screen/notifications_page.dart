import 'package:flutter/material.dart';
import '../widgets/notification_item_card.dart'; // Asegúrate de importar tu widget
import '../../home/home_screen.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 120,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabecera con botón de retroceso y título
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          color: Color(0xFF4A3C38),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A3C38),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Sección: New
              const Text(
                'New',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A3C38),
                ),
              ),
              const SizedBox(height: 12),
              const NotificationItemCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
                text:
                    'Your video call with Maria is starting soon; get ready to join the room.',
                time: 'now',
                isUnread: true,
              ),
              const NotificationItemCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150',
                text:
                    'Ana has updated your weekly activities with a newly assigned plan.',
                time: '10m ago',
                isUnread: true,
              ),

              const SizedBox(height: 24),

              // Sección: Today
              const Text(
                'Today',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A3C38),
                ),
              ),
              const SizedBox(height: 12),
              const NotificationItemCard(
                icon: Icons.star_rounded,
                iconBgColor: Color(0xFFFFEFA8),
                iconColor: Color(0xFFF5A623),
                text:
                    "You're on a great streak this week—don't forget to check off your remaining tasks.",
                time: '2h ago',
                isUnread: false,
              ),
              const NotificationItemCard(
                icon: Icons.star_rounded,
                iconBgColor: Color(0xFFFFEFA8),
                iconColor: Color(0xFFF5A623),
                text:
                    "You're on a great streak this week—don't forget to check off your remaining tasks.",
                time: '2h ago',
                isUnread: false,
              ),

              const SizedBox(height: 24),

              // Sección: Yesterday
              const Text(
                'Yesterday',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A3C38),
                ),
              ),
              const SizedBox(height: 12),
              const NotificationItemCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150',
                text:
                    'Ana has updated your weekly activities with a newly assigned plan.',
                time: 'Yesterday',
                isUnread: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
