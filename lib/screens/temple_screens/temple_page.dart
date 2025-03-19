// screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_intern_template/models/temple_model.dart';
import 'package:flutter_intern_template/widgets/custom_widgets/custom_appbar.dart';
import 'package:flutter_intern_template/widgets/temple_widgets/temple_page_actions.dart';
import 'package:flutter_intern_template/widgets/temple_widgets/temple_page_header.dart';
import 'package:flutter_intern_template/widgets/temple_widgets/temple_page_stats.dart';
import 'package:flutter_intern_template/widgets/temple_widgets/temple_page_tabs.dart';

class TemplePage extends StatefulWidget {
  const TemplePage({super.key});

  @override
  State<TemplePage> createState() => _TemplePageState();
}

class _TemplePageState extends State<TemplePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TempleModel profile;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Initialize dummy data
    profile = TempleModel(
      name: "Mahakaleshwar",
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
            ProfileHeader(profile: profile),

            // Profile Stats (Posts, Followers, Following)
            ProfileStats(profile: profile),

            // Profile Actions (Share, Donation Received)
            ProfileActions(profile: profile),

            // Profile Tabs (About, Review, Gallery, Calendar)
            ProfileTabs(
              tabController: _tabController,
              profile: profile,
            ),
          ],
        ),
      ),
    );
  }
}
