import 'package:flutter/material.dart';

class PlanCalendarHeader extends StatelessWidget {
  const PlanCalendarHeader({
    super.key,
    required this.currentDate,
    required this.weekDays,
    required this.selectedDayIndex,
    required this.onDaySelected,
    required this.onNavigateWeeks,
  });

  final DateTime currentDate;
  final List<DateTime> weekDays;
  final int selectedDayIndex;
  final ValueChanged<int> onDaySelected;
  final ValueChanged<int> onNavigateWeeks; // -1 para semana anterior, +1 para semana siguiente

  // Formadores de mes y día en español/inglés según prefieras
  String _getMonthYearString(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _getDayName(DateTime date) {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[date.weekday - 1];
  }

  String _getDayLetter(DateTime date) {
    const letters = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return letters[date.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = weekDays[selectedDayIndex];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            _getDayName(selectedDate),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF4A3C38)),
          ),
          const SizedBox(height: 4),
          Text(
            _getMonthYearString(selectedDate),
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.grey),
                onPressed: () => onNavigateWeeks(-1),
              ),
              ...List.generate(weekDays.length, (index) {
                final day = weekDays[index];
                final isSelected = index == selectedDayIndex;
                return GestureDetector(
                  onTap: () => onDaySelected(index),
                  child: Column(
                    children: [
                      Text(
                        _getDayLetter(day),
                        style: TextStyle(
                          color: isSelected ? const Color(0xFFB29072) : Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFB29072) : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF4A3C38),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.grey),
                onPressed: () => onNavigateWeeks(1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}