
class TempleModel {
  final String name;
  final double rating;
  final int totalReviews;
  final int posts;
  final int followers;
  final int following;
  final int recommendationPercentage;
  final List<ReviewModel> reviews;
  final List<DonationModel> donations;
  final double totalDonations;

  TempleModel({
    required this.name,
    required this.rating,
    required this.totalReviews,
    required this.posts,
    required this.followers,
    required this.following,
    required this.recommendationPercentage,
    required this.reviews,
    required this.donations,
    required this.totalDonations,
  });
}

// models/review_model.dart
class ReviewModel {
  final String name;
  final double rating;
  final String comment;
  final int likes;
  final int dislikes;
  final String? profileImageUrl;

  ReviewModel({
    required this.name,
    required this.rating,
    required this.comment,
    required this.likes,
    required this.dislikes,
    this.profileImageUrl,
  });
}

// models/donation_model.dart
class DonationModel {
  final String name;
  final double amount;
  final String time;
  final String? imageUrl;

  DonationModel({
    required this.name,
    required this.amount,
    required this.time,
    this.imageUrl,
  });
}

// models/event_model.dart
class EventModel {
  final String title;
  final String description;
  final DateTime dateTime;

  EventModel({
    required this.title,
    required this.description,
    required this.dateTime,
  });
}