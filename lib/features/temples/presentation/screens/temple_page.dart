import 'package:flutter/material.dart';
import 'package:flutter_user_app/features/temples/data/models/temple_model.dart';
import 'package:flutter_user_app/features/temples/presentation/widgets/temple_page_actions.dart';
import 'package:flutter_user_app/features/temples/presentation/widgets/temple_page_stats.dart';
import 'package:flutter_user_app/features/temples/presentation/widgets/temple_page_tabs.dart';

class TemplePage extends StatefulWidget {
  final TempleModel templeModel;
  const TemplePage({super.key, required this.templeModel});

  @override
  State<TemplePage> createState() => _TemplePageState();
}

class _TemplePageState extends State<TemplePage>
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
    final temple = widget.templeModel;

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
                title: Text(
                  temple.name,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: temple.imageUrl,
                      child: Image.network(
                        temple.imageUrl,
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
              ProfileStats(profile: temple),
              ProfileActions(profile: temple),
              ProfileTabs(
                tabController: _tabController,
                profile: temple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
