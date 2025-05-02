import 'package:flutter/material.dart';
import 'package:flutter_user_app/features/posts/data/model/dummy_post.dart';
import 'package:flutter_user_app/features/profile/presentation/screens/profile_page.dart';
import 'package:flutter_user_app/features/search/presentation/screens/search_page.dart';
import 'package:flutter_user_app/widgets/navbar_widgets/bottom_navbar.dart';
import 'package:flutter_user_app/widgets/custom_widgets/custom_page_bar.dart';
import 'package:flutter_user_app/features/posts/presentation/screens/post_screen.dart';
import 'package:flutter_user_app/features/reels/presentation/screens/video_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onTabChange(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 1000), // Adjust duration as needed
      curve: Curves
          .easeInOutCirc, // Experiment with different curves (e.g., easeOutQuint, fastLinearToSlowEaseIn)
    );
    // You can keep the controller animation for the icon if you like,
    // but the page transition is now handled by animateToPage.
    // _controller.forward().then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex != 0 ? null : CustomPageBar(title: "Explore"),
      // Replace the direct body with a PageView
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swiping
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          // Home page content
          const PostsScreen(),
          // Search page
          const SearchPage(),

          // Add page
          const VideosScreen(),
          // Profile page
          const ProfilePage(),
        ],
      ),
      // Replace the current bottom navigation bar with CustomBottomNav
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onTabChange: _onTabChange,
        pageController: _pageController,
      ),
    );
  }
}
