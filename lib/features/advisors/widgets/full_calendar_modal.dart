import 'package:flutter/material.dart';

class FullCalendarModal extends StatefulWidget {
  final Color primaryColor;
  final Color textColor;
  final Function(int day, String timeSlot)? onConfirm;

  const FullCalendarModal({
    super.key,
    required this.primaryColor,
    required this.textColor,
    this.onConfirm,
  });

  @override
  State<FullCalendarModal> createState() => _FullCalendarModalState();
}

class _FullCalendarModalState extends State<FullCalendarModal> {
  int selectedDayModal = 21;
  String selectedTimeSlot = '10:00 AM';

  final List<String> timeSlots = [
    '09:00 AM', '10:00 AM', '11:30 AM', 
    '02:00 PM', '03:30 PM', '05:00 PM'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Select Date & Time',
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              color: Color(0xFF2C1D11),
            ),
          ),
          const SizedBox(height: 20),
          
          // Selector de Días horizontal
          const Text(
            'October 2026', 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFFC77D5C)),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 75,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                int dateNum = 18 + index;
                bool isSelected = selectedDayModal == dateNum;
                List<String> daysName = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDayModal = dateNum;
                    });
                  },
                  child: Container(
                    width: 55,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? widget.primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? widget.primaryColor : Colors.brown.withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          daysName[index],
                          style: TextStyle(
                            fontSize: 12, 
                            color: isSelected ? Colors.white : Colors.grey, 
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$dateNum',
                          style: TextStyle(
                            fontSize: 16, 
                            color: isSelected ? Colors.white : widget.textColor, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 24),
          const Text(
            'Available Time Slots', 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFFC77D5C)),
          ),
          const SizedBox(height: 12),
          
          // Cuadrícula de Horarios
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: timeSlots.map((time) {
              bool isTimeSelected = selectedTimeSlot == time;
              return ChoiceChip(
                label: Text(time),
                selected: isTimeSelected,
                selectedColor: widget.primaryColor,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: isTimeSelected ? Colors.white : widget.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                onSelected: (selected) {
                  setState(() {
                    selectedTimeSlot = time;
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () {
                if (widget.onConfirm != null) {
                  widget.onConfirm!(selectedDayModal, selectedTimeSlot);
                }
                Navigator.pop(context);
              },
              child: const Text('Confirm Slot', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}