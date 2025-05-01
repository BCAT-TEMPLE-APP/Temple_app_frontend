// screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_user_app/features/creator/data/model/creator_model.dart';
import 'package:flutter_user_app/features/creator/presentation/widgets/creator_page_actions.dart';
import 'package:flutter_user_app/features/creator/presentation/widgets/creator_page_header.dart';
import 'package:flutter_user_app/features/creator/presentation/widgets/creator_page_stats.dart';
import 'package:flutter_user_app/features/creator/presentation/widgets/creator_page_tabs.dart';
import 'package:flutter_user_app/widgets/custom_widgets/custom_appbar.dart';

class CreatorPage extends StatefulWidget {
  const CreatorPage({super.key});

  @override
  State<CreatorPage> createState() => _CreatorPageState();
}

class _CreatorPageState extends State<CreatorPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late CreatorModel profile;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Initialize dummy data
    profile = CreatorModel(
      name: "Premanand Maharaj",
      rating: 4.5,
      totalReviews: 1050,
      posts: 1532,
      followers: 4310,
      following: 1310,
      recommendationPercentage: 88,
      reviews: [
        CreatorReviewModel(
          name: "Savannah Nguyen",
          rating: 4.0,
          comment:
              "Great! The place was absolutely amazing! The scenery was breathtaking and the staff was incredibly friendly. Highly recommend to visit.",
          likes: 10,
          dislikes: 2,
        ),
        CreatorReviewModel(
          name: "Savannah Nguyen",
          rating: 4.5,
          comment:
              "Great! Visiting this amazing place. The food culture and history were all too much.",
          likes: 8,
          dislikes: 1,
        ),
      ],
      donations: [
        CreatorDonationModel(
          name: "Kedarnath",
          amount: 125.00,
          time: "10:30 AM",
        ),
        CreatorDonationModel(
          name: "Badrinath",
          amount: 215.00,
          time: "11:45 AM",
        ),
        CreatorDonationModel(
          name: "Shiv Mandir",
          amount: 128.00,
          time: "12:15 PM",
        ),
      ],
      totalDonations: 12500,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            // Profile Header with Image and Name
            CreatorProfileHeader(profile: profile),

            // Profile Stats (Posts, Followers, Following)
            CreatorProfileStats(profile: profile),

            // Profile Actions (Share, Donation Received)
            CreatorProfileActions(profile: profile),

            // Profile Tabs (About, Review, Gallery, Calendar)
            CreatorProfileTabs(
              tabController: _tabController,
              profile: profile,
            ),
          ],
        ),
      ),
    );
  }
}
