import 'package:flutter/material.dart';
import '../widgets/plan_calendar_header.dart'; // Importa el componente del calendario

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  // Fecha base seleccionada actualmente (comienza hoy)
  DateTime _currentBaseDate = DateTime(2026, 7, 5); // O DateTime.now() según prefieras
  int _selectedDayIndex = 4; // Por defecto el índice 4 (viernes dentro de la semana generada)

  List<DateTime> _weekDays = [];

  @override
  void initState() {
    super.initState();
    _updateWeekDays();
  }

  // Genera los 7 días de la semana basados en la fecha base
  void _updateWeekDays() {
    // Encontramos el inicio de la semana (Lunes)
    final monday = _currentBaseDate.subtract(Duration(days: _currentBaseDate.weekday - 1));
    _weekDays = List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  // Cambiar de semana con las flechas laterales
  void _navigateWeeks(int direction) {
    setState(() {
      _currentBaseDate = _currentBaseDate.add(Duration(days: direction * 7));
      _updateWeekDays();
    });
  }

  // Estado de tareas de ejemplo
  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Guia nutricion', 'advisor': 'De Maria Rios', 'completed': false},
    {'title': 'Caminar 30 min', 'advisor': 'De Maria Rios', 'completed': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Calendario superior modular y funcional
              PlanCalendarHeader(
                currentDate: _currentBaseDate,
                weekDays: _weekDays,
                selectedDayIndex: _selectedDayIndex,
                onDaySelected: (index) {
                  setState(() {
                    _selectedDayIndex = index;
                    _currentBaseDate = _weekDays[index];
                  });
                },
                onNavigateWeeks: _navigateWeeks,
              ),

              const SizedBox(height: 24),

              // 2. Sección: Mis Asesores
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Mis asesores',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A3C38),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'see all',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFB29072),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _buildAdvisorsRow(),

              const SizedBox(height: 24),

              // 3. Sección: Próximas sesiones
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Próximas sesiones',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A3C38),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildSessionCard(
                name: 'Maria Rios',
                time: 'Videollamada – 10:00 am',
                imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
              ),
              _buildSessionCard(
                name: 'Juan Rodriguez',
                time: 'Videollamada – 12:00 pm',
                imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
              ),

              const SizedBox(height: 24),

              // 4. Sección: Tus planes (Tareas / Rutinas)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Tus planes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A3C38),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ..._tasks.map((task) => _buildTaskCard(task)),

              const SizedBox(height: 16),

              // 5. Progreso semanal
              _buildWeeklyProgressCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdvisorsRow() {
    final advisors = [
      {'name': 'Maria', 'img': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150'},
      {'name': 'Juan', 'img': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150'},
      {'name': 'Ana', 'img': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150'},
    ];

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: advisors.length,
        itemBuilder: (context, index) {
          final advisor = advisors[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(advisor['img']!),
                ),
                const SizedBox(height: 4),
                Text(
                  advisor['name']!,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF4A3C38), fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSessionCard({required String name, required String time, required String imageUrl}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 24, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4A3C38))),
                const SizedBox(height: 2),
                Text(time, style: const TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.videocam_outlined, color: Color(0xFF4A3C38)),
        ],
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    bool isCompleted = task['completed'];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task['title'],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isCompleted ? Colors.grey : const Color(0xFF4A3C38),
                    decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  task['advisor'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                task['completed'] = !isCompleted;
              });
            },
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green : Colors.transparent,
                border: Border.all(color: isCompleted ? Colors.green : Colors.grey.shade400, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: isCompleted
                  ? const Icon(Icons.check, size: 18, color: Colors.white)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyProgressCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('This week', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4A3C38))),
              Text('3 de 5 completadas', style: TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _progressSegment(true),
              _progressSegment(true),
              _progressSegment(true),
              _progressSegment(false),
              _progressSegment(false),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Your advisor sees this progress.', style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _progressSegment(bool active) {
    return Expanded(
      child: Container(
        height: 6,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: active ? Colors.green : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}