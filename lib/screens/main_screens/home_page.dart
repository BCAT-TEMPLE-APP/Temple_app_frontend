import 'package:flutter/material.dart';
import 'package:flutter_intern_template/screens/profile_screens/profile_page.dart';
import 'package:flutter_intern_template/screens/main_screens/search_page.dart';
import 'package:flutter_intern_template/widgets/navbar_widgets/bottom_navbar.dart';
import 'package:flutter_intern_template/widgets/custom_widgets/custom_page_bar.dart';
import 'package:flutter_intern_template/widgets/custom_widgets/post_widget.dart';
import 'package:flutter_intern_template/screens/main_screens/video_screen.dart';
import 'package:flutter_intern_template/screens/addPost_screens/add_post_page.dart';

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
    setState(() {
      _selectedIndex = index;
    });
    _controller.forward().then((_) => _controller.reverse());
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
          ListView(
            children: const [
              PostWidget(),
              PostWidget(
                username: 'sarah_parker',
                location: 'Tokyo, Japan',
                userImage: 'https://randomuser.me/api/portraits/women/32.jpg',
                postImage:
                    'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe',
                caption: 'Perfect Evening with Perfect Food...',
                likes: '1.2k',
                likedBy: 'Emma',
                timestamp: 'Thu, 26 January 2023',
              ),
              PostWidget(
                username: 'john_doe',
                location: 'Badrinath, India',
                userImage: 'https://randomuser.me/api/portraits/men/85.jpg',
                postImage:
                    'https://images.unsplash.com/photo-1552728089-57bdde30beb3?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
                caption: 'Beautiful morning at Badrinath Temple...',
                likes: '2.5k',
                likedBy: 'Sarah',
                timestamp: 'Fri, 27 January 2023',
              ),
            ],
          ),
          // Search page
          const SearchPage(),
          //add post
          const AddPostPage(),
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
