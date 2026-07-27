import 'package:flutter/material.dart';
import '../advisors/screens/advisor_profile_screen.dart';
import '../advisors/models/advisor_model.dart';
// Asegúrate de importar tu modelo y la pantalla de detalle correctamente:
// import '../../models/advisor.dart';
// import '../advisors/advisor_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Estados posibles: 'coldStart', 'noResults', 'results'
  String _currentState = 'coldStart';

  List<Advisor> _searchResults = [];

  // Datos mock alineados exactamente con tu modelo Advisor
  final List<Advisor> _mockAdvisors = [
    Advisor(
      name: 'Carla Ruiz',
      role: 'Marketing',
      rating: 4.9,
      reviewCount: 124,
      avatarUrl:
          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&q=80&w=200',
      about:
          'Estratega de marketing digital enfocada en crecimiento y posicionamiento de marca.',
      specialities: ['Marketing', 'Estrategia', 'Redes Sociales'],
      reviews: [],
      price: 150.0,
      durationMinutes: 60,
    ),
    Advisor(
      name: 'Carlos Mendoza',
      role: 'Technology',
      rating: 4.8,
      reviewCount: 98,
      avatarUrl:
          'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&q=80&w=200',
      about:
          'Ingeniero de software especializado en arquitectura de sistemas y desarrollo cloud.',
      specialities: ['Technology', 'AWS', 'Node.js'],
      reviews: [],
      price: 120.0,
      durationMinutes: 45,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    setState(() {
      if (query.isEmpty) {
        _currentState = 'coldStart';
        _searchResults = [];
      } else {
        _searchResults = _mockAdvisors.where((advisor) {
          return advisor.name.toLowerCase().contains(query.toLowerCase()) ||
              advisor.role.toLowerCase().contains(query.toLowerCase()) ||
              advisor.specialities.any(
                (spec) => spec.toLowerCase().contains(query.toLowerCase()),
              );
        }).toList();

        _currentState = _searchResults.isEmpty ? 'noResults' : 'results';
      }
    });
  }

  void _onQuerySelected(String query) {
    _searchController.text = query;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: _searchController.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            _SearchHeader(
              controller: _searchController,
              onClear: () {
                _searchController.clear();
                setState(() {
                  _currentState = 'coldStart';
                });
              },
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _buildBodyContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyContent() {
    switch (_currentState) {
      case 'coldStart':
        return _ColdStartState(
          onQueryTap: _onQuerySelected,
          suggestedAdvisors: _mockAdvisors,
        );
      case 'noResults':
        return _NoResultsState(query: _searchController.text);
      case 'results':
        return _ResultsState(results: _searchResults);
      default:
        return _ColdStartState(
          onQueryTap: _onQuerySelected,
          suggestedAdvisors: _mockAdvisors,
        );
    }
  }
}

// -------------------------------------------------------------------------
// CABECERA Y BARRA DE BÚSQUEDA
// -------------------------------------------------------------------------

class _SearchHeader extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClear;

  const _SearchHeader({required this.controller, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'Search',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Search for advisors, topics, or skills...',
              hintStyle: const TextStyle(
                color: Color(0xFF9E9E9E),
                fontSize: 14,
              ),
              prefixIcon: const Icon(Icons.search, color: Color(0xFF9E9E9E)),
              suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Color(0xFF9E9E9E)),
                      onPressed: onClear,
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFF2563EB),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------------
// ESTADO: COLD START (Diseño exacto de la primera captura)
// -------------------------------------------------------------------------

class _ColdStartState extends StatelessWidget {
  final ValueChanged<String> onQueryTap;
  final List<Advisor> suggestedAdvisors;

  const _ColdStartState({
    required this.onQueryTap,
    required this.suggestedAdvisors,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      children: [
        const Text(
          'Recent search',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 12),
        _RecentSearchItem(
          title: 'Marketing strategist',
          onTap: () => onQueryTap('Marketing strategist'),
        ),
        _RecentSearchItem(
          title: 'Carla Ruiz',
          onTap: () => onQueryTap('Carla Ruiz'),
        ),
        _RecentSearchItem(
          title: 'Legal advisor',
          onTap: () => onQueryTap('Legal advisor'),
        ),
        const SizedBox(height: 24),
        const Text(
          'Popular categories',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 10,
          children: [
            _CategoryChip(
              label: 'marketing',
              onTap: () => onQueryTap('marketing'),
            ),
            _CategoryChip(label: 'legal', onTap: () => onQueryTap('legal')),
            _CategoryChip(
              label: 'technology',
              onTap: () => onQueryTap('technology'),
            ),
            _CategoryChip(
              label: 'wellness',
              onTap: () => onQueryTap('wellness'),
            ),
            _CategoryChip(
              label: 'finances',
              onTap: () => onQueryTap('finances'),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Suggested for you',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'see all',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9E9E9E),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: suggestedAdvisors.length,
            itemBuilder: (context, index) {
              final advisor = suggestedAdvisors[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _SuggestedAdvisorCard(advisor: advisor),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _RecentSearchItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _RecentSearchItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.access_time, size: 18, color: Color(0xFF9E9E9E)),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _CategoryChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: Colors.white,
      side: const BorderSide(color: Color(0xFFE5E7EB)),
      labelStyle: const TextStyle(color: Color(0xFF374151), fontSize: 13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}

class _SuggestedAdvisorCard extends StatelessWidget {
  final Advisor advisor;

  const _SuggestedAdvisorCard({required this.advisor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdvisorProfileScreen()),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                advisor.avatarUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              advisor.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              advisor.role,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------------
// ESTADO: NO RESULTS (Diseño exacto de la segunda captura)
// -------------------------------------------------------------------------

class _NoResultsState extends StatelessWidget {
  final String query;

  const _NoResultsState({required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFE5DD),
              ),
              child: const Icon(
                Icons.search,
                size: 48,
                color: Color(0xFFE07A5F),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Nothing to search yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "We're onboarding our first advisors. Join the waitlist and we'll notify you the moment someone matches what you're looking for.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A3B32),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Join the waitlist',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF2F4F1),
                  foregroundColor: const Color(0xFF4A3B32),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Become an advisor',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------------
// ESTADO: RESULTS (Muestra resultados al escribir)
// -------------------------------------------------------------------------

class _ResultsState extends StatelessWidget {
  final List<Advisor> results;

  const _ResultsState({required this.results});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final advisor = results[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _AdvisorResultCard(advisor: advisor),
        );
      },
    );
  }
}

class _AdvisorResultCard extends StatelessWidget {
  final Advisor advisor;

  const _AdvisorResultCard({required this.advisor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /*
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdvisorDetailScreen(advisor: advisor),
          ),
        );
        */
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(advisor.avatarUrl),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    advisor.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    advisor.role,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
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
