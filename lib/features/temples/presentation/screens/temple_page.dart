// screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_user_app/features/temples/data/models/review_model.dart';

import 'package:flutter_user_app/features/temples/data/models/temple_model.dart';
import 'package:flutter_user_app/widgets/custom_widgets/custom_appbar.dart';
import 'package:flutter_user_app/features/temples/presentation/widgets/temple_page_actions.dart';
import 'package:flutter_user_app/features/temples/presentation/widgets/temple_page_header.dart';
import 'package:flutter_user_app/features/temples/presentation/widgets/temple_page_stats.dart';
import 'package:flutter_user_app/features/temples/presentation/widgets/temple_page_tabs.dart';

import '../../data/models/donation_model.dart';

class TemplePage extends StatefulWidget {
  final TempleModel templeModel;
  const TemplePage({super.key, required this.templeModel});

  @override
  State<TemplePage> createState() => _TemplePageState();
}

class _TemplePageState extends State<TemplePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TempleModel templeModel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Initialize dummy data
    templeModel = widget.templeModel;
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
            ProfileHeader(profile: templeModel),

            // Profile Stats (Posts, Followers, Following)
            ProfileStats(profile: templeModel),

            // Profile Actions (Share, Donation Received)
            ProfileActions(profile: templeModel),

            // Profile Tabs (About, Review, Gallery, Calendar)
            ProfileTabs(
              tabController: _tabController,
              profile: templeModel,
            ),
          ],
        ),
      ),
    );
  }
}
