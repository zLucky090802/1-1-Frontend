import 'package:flutter/material.dart';
import '../widgets/plan_calendar_header.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  DateTime _currentBaseDate = DateTime(2026, 7, 5);
  int _selectedDayIndex = 4;

  List<DateTime> _weekDays = [];

  @override
  void initState() {
    super.initState();
    _updateWeekDays();
  }

  void _updateWeekDays() {
    final monday = _currentBaseDate.subtract(Duration(days: _currentBaseDate.weekday - 1));
    _weekDays = List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  void _navigateWeeks(int direction) {
    setState(() {
      _currentBaseDate = _currentBaseDate.add(Duration(days: direction * 7));
      _updateWeekDays();
    });
  }

  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Nutrition Guide', 'advisor': 'By Maria Rios', 'completed': false},
    {'title': 'Walk 30 min', 'advisor': 'By Maria Rios', 'completed': true},
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
              // 1. Calendario superior modular
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

              const SizedBox(height: 20),

              // 2. Tarjeta "This week" colocada de primera
              _buildWeeklyProgressCard(),

              const SizedBox(height: 24),

              // 3. Sección: My Advisors (Sin el "see all")
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'My Advisors',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A3C38),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildAdvisorsRow(),

              const SizedBox(height: 24),

              // 4. Sección: Upcoming Sessions
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Upcoming Sessions',
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
                time: 'Video call – 10:00 am',
                imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
              ),
              _buildSessionCard(
                name: 'Juan Rodriguez',
                time: 'Video call – 12:00 pm',
                imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
              ),

              const SizedBox(height: 24),

              // 5. Sección: Your Plans
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Your Plans',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A3C38),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ..._tasks.map((task) => _buildTaskCard(task)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyProgressCard() {
    final int totalTasks = _tasks.length;
    final int completedTasks = _tasks.where((task) => task['completed'] == true).length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'This week',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4A3C38)),
              ),
              Text(
                '$completedTasks of $totalTasks completed',
                style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalTasks > 0 ? totalTasks : 1, (index) {
              final isActive = index < completedTasks;
              return _progressSegment(isActive);
            }),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your advisor sees this progress.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
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
}