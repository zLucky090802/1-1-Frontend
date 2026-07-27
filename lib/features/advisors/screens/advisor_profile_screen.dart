import 'package:flutter/material.dart';
import '../models/advisor_model.dart';
import '../widgets/specialty_chip.dart';
import '../widgets/review_card.dart';
import '../widgets/day_item.dart';
import '../widgets/sticky_booking_bar.dart';
import '../widgets/full_calendar_modal.dart';

class AdvisorProfileScreen extends StatelessWidget {
  final Advisor? advisor;

  const AdvisorProfileScreen({super.key, this.advisor});

  @override
  Widget build(BuildContext context) {
    final currentAdvisor = advisor ?? Advisor(
      name: 'Carla Ruiz',
      role: 'Astrology Expert',
      rating: 4.9,
      reviewCount: 128,
      avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=300&q=80',
      about: 'Vedic Astrology is expertised with expertsing consultars bosking, accesses rie, roonirection, and doss, advice, Tarot Reading, Life Path Guidance, relationship expertived.',
      specialities: ['Vedic Astrology', 'Tarot Reading', 'Life Path Guidance', 'Relationship Advice'],
      reviews: [
        AdvisorReview(
          clientName: 'Client Daniel',
          clientAvatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=100&q=80',
          rating: 5.0,
          comment: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
        ),
         AdvisorReview(
          clientName: 'Client Sarah',
          clientAvatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=100&q=80',
          rating: 4.8,
          comment: 'Insightful session, highly recommended!',
        ),
      ],
      price: 150,
      durationMinutes: 45,
    );

    const primaryColor = Color(0xFFC47B58); 
    const textColor = Color(0xFF2C1D11);    

    return Scaffold(
      body: Container(
        // Fondo con el degradado requerido
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF9D1AE),
              Color(0xFFF9F8F4),
            ],
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 140.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
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
                          icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: textColor),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Meet the Expert',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Sección de Perfil y Marco de Foto
                  Center(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFFB29072),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(currentAdvisor.avatarUrl),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          currentAdvisor.name,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          currentAdvisor.role,
                          style: const TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${currentAdvisor.rating}', 
                              style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFC77D5C), fontSize: 14)
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.star, size: 16, color: Color(0xFFC77D5C)),
                            const SizedBox(width: 6),
                            Text(
                              '(${currentAdvisor.reviewCount} reviews)', 
                              style: const TextStyle(color: Color(0xFFC77D5C), fontSize: 13, fontWeight: FontWeight.w500)
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  
                  Text(
                    'About ${currentAdvisor.name.split(' ').first}', 
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor)
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentAdvisor.about,
                    style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.65), height: 1.6),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                      child: const Text(
                        'Read More',
                        style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 13, decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  const Text('Specialities', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: currentAdvisor.specialities
                        .map<Widget>((spec) => SpecialtyChip(
                              label: spec, 
                              color: const Color(0xFFC77D5C),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 28),
                  
                  const Text('Reviews', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
                  const SizedBox(height: 2),
                  Text('What client say', style: TextStyle(fontSize: 13, color: textColor.withOpacity(0.5))),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: currentAdvisor.reviews.length,
                      itemBuilder: (context, index) {
                        final review = currentAdvisor.reviews[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: ReviewCard(
                            clientName: review.clientName,
                            avatarUrl: review.clientAvatar,
                            comment: review.comment,
                            primaryColor: const Color(0xFFE29547),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'View All Reviews',
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600, fontSize: 13, decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Next Available Slot', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
                      GestureDetector(
                        onTap: () => _showFullCalendarModal(context, primaryColor, textColor),
                        child: const Text(
                          'See All',
                          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 13, decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        DayItem(day: 'Sun', date: '28', isSelected: false, isAvailable: false, textColor: textColor),
                        DayItem(day: 'Mon', date: '20', isSelected: false, isAvailable: true, textColor: textColor),
                        DayItem(day: 'Tue', date: '20', isSelected: false, isAvailable: false, textColor: textColor),
                        DayItem(day: 'Wed', date: '21', isSelected: true, isAvailable: true, activeColor: primaryColor, textColor: textColor),
                        DayItem(day: 'Thu', date: '19', isSelected: false, isAvailable: true, textColor: textColor),
                        DayItem(day: 'Fri', date: '16', isSelected: false, isAvailable: false, textColor: textColor),
                        DayItem(day: 'Sat', date: '17', isSelected: false, isAvailable: true, textColor: textColor),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.access_time, size: 16, color: primaryColor),
                        const SizedBox(width: 8),
                        Text('Wed, Oct 29 - 10:00 AM', style: TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Barra Inferior Fija de Reservas con fondo translúcido para que no corte el degradado bruscamente
            StickyBookingBar(
              price: currentAdvisor.price,
              durationMinutes: currentAdvisor.durationMinutes,
              primaryColor: primaryColor,
              textColor: textColor,
              backgroundColor: const Color(0xFFF9F8F4).withOpacity(0.9), // Color translúcido adaptado al fondo
              onBookPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _showFullCalendarModal(BuildContext context, Color primaryColor, Color textColor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF9EFE6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return FullCalendarModal(
          primaryColor: primaryColor,
          textColor: textColor,
          onConfirm: (day, timeSlot) {},
        );
      },
    );
  }
}