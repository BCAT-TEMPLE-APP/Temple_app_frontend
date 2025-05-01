import 'package:flutter_user_app/features/temples/data/models/donation_model.dart';
import 'package:flutter_user_app/features/temples/data/models/review_model.dart';
import 'package:flutter_user_app/features/temples/data/models/temple_model.dart';

final List<TempleModel> dummyTemples = [
  TempleModel(
    name: 'Kedarnath Mandir',
    description:
        'Kedarnath is a town and Nagar Panchayat in Rudraprayag district of Uttarakhand, India, known primarily for the Kedarnath Temple. It is approximately 86.5 kilometres from Rudraprayag, the district headquarters. Kedarnath is the most remote of the four Chota Char Dham pilgrimage sites.',
    imageUrl:
        'https://himalayandreamtreks.in/wp-content/uploads/2023/10/Kedarnath-Temple-min.jpg',
    rating: 4.8,
    totalReviews: 120,
    posts: 10,
    followers: 5000,
    following: 100,
    recommendationPercentage: 95,
    reviews: [],
    donations: [],
    totalDonations: 100000,
    location: 'Kedarnath, Uttarakhand',
  ),
  TempleModel(
    name: 'Badrinath Temple',
    description:
        'Badrinath is a town and nagar panchayat in Chamoli district in the state of Uttarakhand, India. It is a Hindu holy place, and is one of the four sites in India\'s Char Dham pilgrimage. It is also part of India\'s Chota Char Dham pilgrimage circuit and gets its name from the Badrinath Temple.',
    imageUrl:
        'https://www.chardham-pilgrimage-tour.com/assets/images/badrinath-banner3.webp',
    rating: 4.7,
    totalReviews: 98,
    posts: 5,
    followers: 3200,
    following: 80,
    recommendationPercentage: 92,
    reviews: [],
    donations: [],
    totalDonations: 87000,
    location: 'Badrinath, Uttarakhand',
  ),

  TempleModel(
    name: "Mahakaleshwar",
    location: "Ujjain, India",
    description: "Mahakaleshwar is a famous temple in Ujjain, India.",
    imageUrl:
        'https://static.toiimg.com/photo/msid-94055833,width-96,height-65.cms',
    rating: 4.5,
    totalReviews: 1050,
    posts: 1532,
    followers: 4310,
    following: 1310,
    recommendationPercentage: 88,
    reviews: [
      ReviewModel(
        name: "Savannah Nguyen",
        rating: 4.0,
        comment:
            "Great! The place was absolutely amazing! The scenery was breathtaking and the staff was incredibly friendly. Highly recommend to visit.",
        likes: 10,
        dislikes: 2,
      ),
      ReviewModel(
        name: "Savannah Nguyen",
        rating: 4.5,
        comment:
            "Great! Visiting this amazing place. The food culture and history were all too much.",
        likes: 8,
        dislikes: 1,
      ),
    ],
    donations: [
      DonationModel(
        name: "Kedarnath",
        amount: 125.00,
        time: "10:30 AM",
      ),
      DonationModel(
        name: "Badrinath",
        amount: 215.00,
        time: "11:45 AM",
      ),
      DonationModel(
        name: "Shiv Mandir",
        amount: 128.00,
        time: "12:15 PM",
      ),
    ],
    totalDonations: 12500,
  ),
  // Add more temples as needed
];
