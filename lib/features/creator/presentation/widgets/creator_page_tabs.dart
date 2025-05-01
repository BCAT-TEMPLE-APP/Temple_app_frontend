// widgets/profile_tabs.dart
import 'package:flutter/material.dart';
import 'package:flutter_user_app/features/creator/data/model/creator_model.dart';
import 'package:flutter_user_app/features/creator/presentation/tabs/creator_about_tab.dart';
import 'package:flutter_user_app/features/creator/presentation/tabs/creator_calender_tab.dart';
import 'package:flutter_user_app/features/creator/presentation/tabs/creator_gallery_tab.dart';

class CreatorProfileTabs extends StatelessWidget {
  final TabController tabController;
  final CreatorModel profile;

  const CreatorProfileTabs({
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
              Tab(text: 'Gallery'),
              Tab(text: 'Calendar'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                CreatorAboutTab(profile: profile),
                CreatorGalleryTab(),
                CreatorCalendarTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
