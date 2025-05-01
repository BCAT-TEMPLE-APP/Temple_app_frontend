class CreatorModel {
  final String name;
  final double rating;
  final int totalReviews;
  final int posts;
  final int followers;
  final int following;
  final int recommendationPercentage;
  final List<CreatorReviewModel> reviews;
  final List<CreatorDonationModel> donations;
  final double totalDonations;

  CreatorModel({
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
class CreatorReviewModel {
  final String name;
  final double rating;
  final String comment;
  final int likes;
  final int dislikes;
  final String? profileImageUrl;

  CreatorReviewModel({
    required this.name,
    required this.rating,
    required this.comment,
    required this.likes,
    required this.dislikes,
    this.profileImageUrl,
  });
}

// models/donation_model.dart
class CreatorDonationModel {
  final String name;
  final double amount;
  final String time;
  final String? imageUrl;

  CreatorDonationModel({
    required this.name,
    required this.amount,
    required this.time,
    this.imageUrl,
  });
}

// models/event_model.dart
class CreatorEventModel {
  final String title;
  final String description;
  final DateTime dateTime;

  CreatorEventModel({
    required this.title,
    required this.description,
    required this.dateTime,
  });
}
