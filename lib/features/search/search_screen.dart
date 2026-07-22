// lib/screens/search_screen.dart
import 'package:flutter/material.dart';
// import '../../core/theme/app_colors.dart'; // Asegúrate de actualizar tus colores aquí
// import '../../core/widgets/floating_bottom_nav.dart';

/// -----------------------------------------------------------------------
/// MODELO
/// -----------------------------------------------------------------------
class Advisor {
  Advisor({
    required this.name,
    required this.category,
    required this.rating,
    required this.price,
    this.imageAsset,
    this.isFavorite = false,
  });

  final String name;
  final String category;
  final double rating;
  final double price;
  final String? imageAsset;
  bool isFavorite;
}

enum _SearchViewState { coldStart, idle, noResults, results }

/// -----------------------------------------------------------------------
/// PANTALLA
/// -----------------------------------------------------------------------
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  // TODO: reemplazar por tu fuente de datos real
  final bool _hasAdvisorsOnPlatform = true;

  final List<String> _recentSearches = [
    'Marketing strategist',
    'Carla Ruiz',
    'Legal advisor',
  ];

  final List<String> _categories = const [
    'marketing',
    'legal',
    'technology',
    'wellness',
    'finances',
  ];

  final List<Advisor> _suggested = [
    Advisor(name: 'Carla Ruiz', category: 'Marketing', rating: 4.9, price: 25),
    Advisor(name: 'Carla Ruiz', category: 'Marketing', rating: 4.9, price: 25),
    Advisor(name: 'Carla Ruiz', category: 'Marketing', rating: 4.9, price: 25),
  ];

  final List<Advisor> _allAdvisors = [
    Advisor(name: 'Carla Ruiz', category: 'Astrology', rating: 4.9, price: 25),
    Advisor(name: 'Carla Ruiz', category: 'Astrology', rating: 4.9, price: 25),
    Advisor(name: 'Carla Ruiz', category: 'Astrology', rating: 4.9, price: 25),
    Advisor(name: 'Carla Ruiz', category: 'Astrology', rating: 4.9, price: 25),
  ];

  int _activeFilterIndex = 0; 

  List<Advisor> get _results {
    final query = _controller.text.trim().toLowerCase();
    if (query.isEmpty) return [];
    return _allAdvisors
        .where((a) =>
            a.name.toLowerCase().contains(query) ||
            a.category.toLowerCase().contains(query))
        .toList();
  }

  _SearchViewState get _state {
    if (!_hasAdvisorsOnPlatform) return _SearchViewState.coldStart;
    if (_controller.text.trim().isEmpty) return _SearchViewState.idle;
    if (_results.isEmpty) return _SearchViewState.noResults;
    return _SearchViewState.results;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fondo de pantalla base (gris muy claro basado en el mock)
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F5), 
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SearchHeader(onBack: () => Navigator.of(context).maybePop()),
                      const SizedBox(height: 24),
                      _SearchBar(
                        controller: _controller,
                        onChanged: (_) => setState(() {}),
                        onClear: () => setState(() => _controller.clear()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(child: _buildBody()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_state) {
      case _SearchViewState.coldStart:
        return _ColdStartState(
          onJoinWaitlist: () {},
          onBecomeAdvisor: () {},
        );

      case _SearchViewState.idle:
        return _IdleState(
          recentSearches: _recentSearches,
          categories: _categories,
          suggested: _suggested,
          onRecentTap: (term) => setState(() {
            _controller.text = term;
          }),
          onCategoryTap: (category) => setState(() {
            _controller.text = category;
          }),
          onClearRecent: () => setState(() => _recentSearches.clear()),
        );

      case _SearchViewState.noResults:
        return _NoResultsState(query: _controller.text.trim());

      case _SearchViewState.results:
        return _ResultsState(
          results: _results,
          activeFilterIndex: _activeFilterIndex,
          onFilterTap: (index) => setState(() => _activeFilterIndex = index),
          onFavoriteTap: (advisor) => setState(() => advisor.isFavorite = !advisor.isFavorite),
        );
    }
  }
}

/// -----------------------------------------------------------------------
/// HEADER + SEARCH BAR
/// -----------------------------------------------------------------------
class _SearchHeader extends StatelessWidget {
  const _SearchHeader({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onBack,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
              ],
            ),
            child: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          ),
        ),
        const SizedBox(width: 16),
        const Text(
          'Search',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }
}
class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              decoration: const InputDecoration(
                // Forzamos la eliminación de cualquier borde o padding interno sobrante
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: 'Search for advisors, topics, or skills...',
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            GestureDetector(
              onTap: onClear,
              child: const Icon(Icons.close, color: Colors.grey, size: 20),
            ),
        ],
      ),
    );
  }
}

/// -----------------------------------------------------------------------
/// ESTADO 1 · COLD START 
/// -----------------------------------------------------------------------
class _ColdStartState extends StatelessWidget {
  const _ColdStartState({required this.onJoinWaitlist, required this.onBecomeAdvisor});

  final VoidCallback onJoinWaitlist;
  final VoidCallback onBecomeAdvisor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(color: Color(0xFFF3C7B7), shape: BoxShape.circle),
              child: const Icon(Icons.search, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 32),
            const Text(
              'Nothing to search yet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 16),
            const Text(
              "We're onboarding our first advisors.\nJoin the waitlist and we'll notify you the\nmoment someone matches what\nyou're looking for.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.5),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: onJoinWaitlist,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A3C38),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                child: const Text('Join the waitlist'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: onBecomeAdvisor,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF3F1ED),
                  foregroundColor: const Color(0xFF4A3C38),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                child: const Text('Become an advisor'),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

/// -----------------------------------------------------------------------
/// ESTADO 2 · IDLE
/// -----------------------------------------------------------------------
class _IdleState extends StatelessWidget {
  const _IdleState({
    required this.recentSearches,
    required this.categories,
    required this.suggested,
    required this.onRecentTap,
    required this.onCategoryTap,
    required this.onClearRecent,
  });

  final List<String> recentSearches;
  final List<String> categories;
  final List<Advisor> suggested;
  final ValueChanged<String> onRecentTap;
  final ValueChanged<String> onCategoryTap;
  final VoidCallback onClearRecent;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
      children: [
        if (recentSearches.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent search',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
              GestureDetector(
                onTap: onClearRecent,
                child: const Text('clear', style: TextStyle(fontSize: 13, color: Colors.grey)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...recentSearches.map(
            (term) => InkWell(
              onTap: () => onRecentTap(term),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, size: 18, color: Colors.grey),
                    const SizedBox(width: 12),
                    Text(term, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
        const Text('Popular categories',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: categories
              .map((c) => _PillChip(label: c, onTap: () => onCategoryTap(c)))
              .toList(),
        ),
        const SizedBox(height: 36),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Suggested for you',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
            const Text('see all', style: TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180, // Ajustado para dar más proporción a la tarjeta
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: suggested.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) => _SuggestedAdvisorCard(advisor: suggested[index]),
          ),
        ),
      ],
    );
  }
}

class _PillChip extends StatelessWidget {
  const _PillChip({required this.label, this.onTap});
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
      ),
    );
  }
}

class _SuggestedAdvisorCard extends StatelessWidget {
  const _SuggestedAdvisorCard({required this.advisor});
  final Advisor advisor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: advisor.imageAsset != null
                  ? Image.asset(advisor.imageAsset!, width: double.infinity, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _photoPlaceholder())
                  : _photoPlaceholder(),
            ),
          ),
          const SizedBox(height: 12),
          Text(advisor.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 4),
          Text(advisor.category, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _photoPlaceholder() => Container(
        width: double.infinity,
        color: const Color(0xFFD6D3CE), // Color gris claro de placeholder
        child: const Center(
          child: Icon(Icons.person, color: Colors.white, size: 40),
        ),
      );
}

/// -----------------------------------------------------------------------
/// ESTADO 3 · NO RESULTS
/// -----------------------------------------------------------------------
class _NoResultsState extends StatelessWidget {
  const _NoResultsState({required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(color: Color(0xFFEBEBEB), shape: BoxShape.circle),
              child: const Icon(Icons.sentiment_dissatisfied, size: 50, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Text(
              'No advisors for "$query"',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 16),
            const Text(
              "We couldn't find a match. Try a\ndifferent keyword or explore one of\nthese categories instead.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.5),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

/// -----------------------------------------------------------------------
/// ESTADO 4 · RESULTS
/// -----------------------------------------------------------------------
class _ResultsState extends StatelessWidget {
  const _ResultsState({
    required this.results,
    required this.activeFilterIndex,
    required this.onFilterTap,
    required this.onFavoriteTap,
  });

  final List<Advisor> results;
  final int activeFilterIndex;
  final ValueChanged<int> onFilterTap;
  final ValueChanged<Advisor> onFavoriteTap;

  static const _filterLabels = ['Filters', 'Price', 'Rating'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 44,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: _filterLabels.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final isActive = index == activeFilterIndex;
              return InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => onFilterTap(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF4A3C38) : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: isActive
                        ? []
                        : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, offset: const Offset(0, 2))],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _filterLabels[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                      color: isActive ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
            itemCount: results.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) =>
                _AdvisorResultCard(advisor: results[index], onFavoriteTap: () => onFavoriteTap(results[index])),
          ),
        ),
      ],
    );
  }
}

class _AdvisorResultCard extends StatelessWidget {
  const _AdvisorResultCard({required this.advisor, required this.onFavoriteTap});

  final Advisor advisor;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: advisor.imageAsset != null
                ? Image.asset(advisor.imageAsset!, height: 80, width: 100, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _photoPlaceholder())
                : _photoPlaceholder(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(advisor.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                  const SizedBox(height: 4),
                  Text(advisor.category, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text('\$${advisor.price.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(advisor.rating.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 13, color: Colors.black54)),
                    const SizedBox(width: 4),
                    const Icon(Icons.star, size: 16, color: Color(0xFFF2A341)), // Naranja
                  ],
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: onFavoriteTap,
                  child: Icon(
                    advisor.isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 22,
                    color: const Color(0xFFE28B8B), // Rosa pálido
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _photoPlaceholder() => Container(
        height: 80,
        width: 100,
        color: const Color(0xFFD6D3CE),
        child: const Icon(Icons.person, color: Colors.white, size: 30),
      );
}