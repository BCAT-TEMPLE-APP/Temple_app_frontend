
// widgets/profile_tabs.dart
import 'package:flutter/material.dart';
import 'package:flutter_user_app/models/temple_model.dart';
import 'package:flutter_user_app/tabs/temple_about_tab.dart';
import 'package:flutter_user_app/tabs/temple_calender_tab.dart';
import 'package:flutter_user_app/tabs/temple_gallery_tab.dart';
import 'package:flutter_user_app/tabs/temple_review_tab.dart';

class ProfileTabs extends StatelessWidget {
  final TabController tabController;
  final TempleModel profile;

  const ProfileTabs({
    super.key,
    required this.tabController,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: 'About'),
              Tab(text: 'Review'),
              Tab(text: 'Gallery'),
              Tab(text: 'Calendar'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                AboutTab(profile: profile),
                ReviewTab(reviews: profile.reviews),
                GalleryTab(),
                CalendarTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
