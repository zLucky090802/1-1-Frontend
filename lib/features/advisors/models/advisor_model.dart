class AdvisorReview {
  final String clientName;
  final String clientAvatar;
  final double rating;
  final String comment;

  AdvisorReview({
    required this.clientName,
    required this.clientAvatar,
    required this.rating,
    required this.comment,
  });
}

class Advisor {
  final String name;
  final String role;
  final double rating;
  final int reviewCount;
  final String avatarUrl;
  final String about;
  final List<String> specialities;
  final List<AdvisorReview> reviews;
  final double price;
  final int durationMinutes;

  Advisor({
    required this.name,
    required this.role,
    required this.rating,
    required this.reviewCount,
    required this.avatarUrl,
    required this.about,
    required this.specialities,
    required this.reviews,
    required this.price,
    required this.durationMinutes,
  });
}