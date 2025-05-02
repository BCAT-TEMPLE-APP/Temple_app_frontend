import 'package:flutter/material.dart';
import 'package:flutter_user_app/features/creator/data/model/creators_model.dart';
import 'package:flutter_user_app/features/creator/presentation/widgets/creator_page_actions.dart';
import 'package:flutter_user_app/features/creator/presentation/widgets/creator_page_stats.dart';
import 'package:flutter_user_app/features/creator/presentation/widgets/creator_page_tabs.dart';
import 'package:flutter_user_app/features/temples/presentation/widgets/temple_page_tabs.dart';

class CreatorPage extends StatefulWidget {
  final CreatorsModel creatorsModel;
  const CreatorPage({super.key, required this.creatorsModel});

  @override
  State<CreatorPage> createState() => _CreatorPageState();
}

class _CreatorPageState extends State<CreatorPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final creator = widget.creatorsModel;

    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Text(
                    creator.name,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: creator.imageUrl,
                      child: Image.network(
                        creator.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Overlay gradient for better readability
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            theme.colorScheme.surface.withAlpha(130)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          body: Column(
            children: [
              CreatorProfileStats(profile: creator),
              CreatorProfileActions(profile: creator),
              CreatorProfileTabs(
                tabController: _tabController,
                profile: creator,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
