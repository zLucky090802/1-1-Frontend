import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Estado actual del filtro: 'All', 'Upcoming', o 'Completed'
  String _selectedFilter = 'All';

  // Mock de datos de sesiones (Puedes cambiar esta lista a vacía [] para probar el estado vacío)
  final List<Map<String, dynamic>> _sessions = [
    {
      'advisor': 'Carla ruiz',
      'category': 'Astrology',
      'date': 'Oct 28, 10:00 AM',
      'status': 'Completed',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
    },
    {
      'advisor': 'Carla ruiz',
      'category': 'Astrology',
      'date': 'Oct 28, 10:00 AM',
      'status': 'Upcoming',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
    },
    {
      'advisor': 'Carla ruiz',
      'category': 'Astrology',
      'date': 'Oct 28, 10:00 AM',
      'status': 'Cancelled',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
    },
    {
      'advisor': 'Carla ruiz',
      'category': 'Astrology',
      'date': 'Oct 28, 10:00 AM',
      'status': 'Completed',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
    },
    {
      'advisor': 'Carla ruiz',
      'category': 'Astrology',
      'date': 'Oct 28, 10:00 AM',
      'status': 'Completed',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filtrar la lista de sesiones según la pestaña seleccionada
    final filteredSessions = _sessions.where((session) {
      if (_selectedFilter == 'All') return true;
      return session['status'].toLowerCase() == _selectedFilter.toLowerCase();
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF7), // Fondo cálido estilo earth-tone
      body: SafeArea(
        child: Column(
          children: [
            // Header con botón de retroceso y título
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
                      'History',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C1D11),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Espaciador para centrar el título perfectamente
                ],
              ),
            ),

            // Pestañas de Filtro (All, Upcoming, Completed)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterTab('All'),
                  _buildFilterTab('Upcoming'),
                  _buildFilterTab('Completed'),
                  _buildFilterTab('Cancelled'),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Contenido condicional: Lista de sesiones o Estado Vacío
            Expanded(
              child: filteredSessions.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                      itemCount: filteredSessions.length,
                      itemBuilder: (context, index) {
                        final session = filteredSessions[index];
                        return _buildSessionCard(session);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para las pestañas superiores de filtrado
  Widget _buildFilterTab(String title) {
    final isSelected = _selectedFilter == title;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedFilter = title;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFE8997D) : Colors.transparent,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected ? const Color(0xFFE8997D) : Colors.grey.shade300,
                width: 1.2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color(0xFFE8997D).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : [],
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF7A7A7A),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Tarjeta de sesión individual
  Widget _buildSessionCard(Map<String, dynamic> session) {
    String status = session['status'];
    Color statusColor;
    Color statusBgColor;

    if (status == 'Completed') {
      statusColor = const Color(0xFF4CAF50);
      statusBgColor = Colors.white;
    } else if (status == 'Upcoming') {
      statusColor = const Color(0xFFE8997D);
      statusBgColor = Colors.white;
    } else {
      statusColor = const Color(0xFFE53935); // Cancelled
      statusBgColor = Colors.white;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
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
      child: Row(
        children: [
          // Imagen del asesor
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              session['image'],
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          // Información principal
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session['advisor'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C1D11),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  session['category'],
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  session['date'],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2C1D11),
                  ),
                ),
              ],
            ),
          ),
          // Etiqueta de Estado con borde
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: statusColor, width: 1.2),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Vista de Estado Vacío
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono de calendario con equis/aspa minimalista
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFE8997D).withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 72,
                    color: Color(0xFFE8997D),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFDFBF7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 20,
                        color: Color(0xFFE8997D),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Sessions Yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C1D11),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your completed and upcoming advice sessions will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}