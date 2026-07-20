import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/category_chip.dart';
import '../../core/widgets/content_action_card.dart';
import '../../core/widgets/floating_bottom_nav.dart';


/// Pantalla principal (Home) del cliente.
///
/// Estado actual: la plataforma todavía no tiene asesores publicados, por
/// lo que la sección "Top Advisors" muestra una card de estado vacío en
/// lugar de la lista de expertos. Cuando haya datos reales, reemplaza
/// [_hasAdvisors] por tu condición real (p. ej. `advisors.isNotEmpty`).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  // TODO: reemplazar por tu fuente de datos real (provider / API).
  final bool _hasAdvisors = false;
  final List<String> _categories = const ['marketing', 'marketing', 'marketing', 'marketing'];

  static const double _breakpoint = 600;
  static const double _cardMaxWidth = 440;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= _breakpoint;

          final body = Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 110),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _HomeHeader(userName: 'Daniel'),
                      const SizedBox(height: 20),
                      const _SearchBar(),
                      const SizedBox(height: 22),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.textSecondary,
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text('see all', style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _categories.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 10),
                          itemBuilder: (context, index) =>
                              CategoryChip(label: _categories[index]),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // -------------------------------------------------
                      // Hero: "Start your learning journey"
                      // -------------------------------------------------
                      ContentActionCard(
                        title: 'Start your learning journey',
                        description:
                            'Connect 1:1 with an industry expert to unlock your potential. Find your match now.',
                        buttonLabel: 'start now',
                        backgroundColor: AppColors.heroCard,
                        titleColor: AppColors.textPrimary,
                        descriptionColor: const Color(0xFF4A3128),
                        onPressed: () {
                          // TODO: navegar a la búsqueda de expertos.
                        },
                      ),
                      const SizedBox(height: 28),

                      Text(
                        'Top Advisors',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 14),

                      // -------------------------------------------------
                      // Top Advisors: lista real vs. estado vacío.
                      // -------------------------------------------------
                      if (_hasAdvisors)
                        const SizedBox() // TODO: reemplazar por tu ListView/GridView de expertos.
                      else
                        ContentActionCard(
                          title: 'Our expert community is growing!',
                          description:
                              'We are onboarding top-tier mentors right now. Want to share your knowledge and earn? Join our waitlist.',
                          buttonLabel: 'start now',
                          backgroundColor: AppColors.emptyStateCard,
                          titleColor: AppColors.textPrimary,
                          descriptionColor: AppColors.emptyStateText,
                          onPressed: () {
                            // TODO: navegar al formulario de waitlist / registro de experto.
                          },
                        ),
                    ],
                  ),
                ),
              ),

              // Bottom nav flotante.
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: FloatingBottomNav(
                  currentIndex: _navIndex,
                  onTap: (index) => setState(() => _navIndex = index),
                ),
              ),
            ],
          );

          if (!isWide) return body;

          // Tablet / Desktop / Web: centrar en una tarjeta tipo "artboard",
          // igual que en las pantallas de auth.
          return Container(
            color: AppColors.background,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _cardMaxWidth),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: body,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // ----------------------------------------------------------
            // IMAGEN: avatar del usuario.
            // TODO: reemplazar imagen -> assets/images/avatar_placeholder.png
            // o cargar la foto real del usuario (NetworkImage / provider).
            // ----------------------------------------------------------
            CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.avatarPlaceholder,
              child: const Icon(Icons.person, color: Colors.white, size: 26),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Hello,', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(Icons.notifications_none, color: AppColors.textPrimary),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.inputIcon, size: 20),
          const SizedBox(width: 10),
          Text(
            'Search for advisors, topics, or skills...',
            style: TextStyle(fontSize: 13, color: AppColors.inputHint),
          ),
        ],
      ),
    );
  }
}
