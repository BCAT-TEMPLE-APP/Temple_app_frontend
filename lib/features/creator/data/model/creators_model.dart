import 'donation_model.dart';

class CreatorsModel {
  final String name;
  final String title;
  final String description;
  final String imageUrl;
  final double rating;
  final int totalReviews;
  final int posts;
  final int followers;
  final int following;
  final int recommendationPercentage;
  final List<DonationModel> donations;
  final double totalDonations;
  final String location;

  CreatorsModel({
    required this.name,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.totalReviews,
    required this.posts,
    required this.followers,
    required this.following,
    required this.recommendationPercentage,
    required this.donations,
    required this.totalDonations,
    required this.location,
  });
}
