import 'package:flutter_user_app/features/creator/data/model/creators_model.dart';
import 'package:flutter_user_app/features/creator/data/model/donation_model.dart';

final List<CreatorsModel> dummyCreators = [
  CreatorsModel(
    name: 'Swami Avdheshanand Giri',
    title: 'Acharya Mahamandaleshwar of Juna Akhara',
    description: 'Swami Avdheshanand Giri is a spiritual leader and the Acharya Mahamandaleshwar of Juna Akhara, one of the largest and oldest orders of Hindu saints and monks in India. He has been instrumental in spreading spiritual knowledge and conducting various humanitarian activities.',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/e/ef/Shri_Hit_Premanand_Govind_Sharan_Ji_Maharaj_002_year_2023_%28cropped%29.jpg',
    rating: 4.9,
    totalReviews: 250,
    posts: 150,
    followers: 15000,
    following: 50,
    recommendationPercentage: 98,
    donations: [
      DonationModel(
        name: "Anonymous Devotee",
        amount: 1100.00,
        time: "09:15 AM",
      ),
      DonationModel(
        name: "Rajesh Kumar",
        amount: 551.00,
        time: "10:30 AM",
      ),
    ],
    totalDonations: 150000,
    location: 'Haridwar, Uttarakhand',
  ),
  
  CreatorsModel(
    name: 'Sadhguru Jaggi Vasudev',
    title: 'Founder of Isha Foundation',
    description: 'Sadhguru is a yogi, mystic, and visionary. He has established Isha Foundation, a non-profit organization dedicated to raising human consciousness through yoga and meditation programs.',
    imageUrl: 'https://static.gujaratsamachar.com/content_image/content_image_89567c18-f9e9-4baf-8f37-53e5daebe829.jpeg',
    rating: 4.8,
    totalReviews: 320,
    posts: 200,
    followers: 25000,
    following: 30,
    recommendationPercentage: 96,
    donations: [
      DonationModel(
        name: "Priya Sharma",
        amount: 2100.00,
        time: "11:45 AM",
      ),
      DonationModel(
        name: "Anonymous",
        amount: 1008.00,
        time: "02:30 PM",
      ),
    ],
    totalDonations: 280000,
    location: 'Coimbatore, Tamil Nadu',
  ),

  CreatorsModel(
    name: 'Gaur Gopal Das',
    title: 'ISKCON Spiritual Leader & Life Coach',
    description: 'Gaur Gopal Das is a lifestyle coach and monk in the International Society for Krishna Consciousness (ISKCON). He is known for his practical wisdom and modern approach to spirituality.',
    imageUrl: 'https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2024/11/baba-bageshwar-1732616904.webp',
    rating: 4.7,
    totalReviews: 180,
    posts: 120,
    followers: 12000,
    following: 45,
    recommendationPercentage: 94,
    donations: [
      DonationModel(
        name: "Amit Patel",
        amount: 501.00,
        time: "03:15 PM",
      ),
      DonationModel(
        name: "Meera Singh",
        amount: 1001.00,
        time: "04:45 PM",
      ),
    ],
    totalDonations: 120000,
    location: 'Mumbai, Maharashtra',
  ),
];