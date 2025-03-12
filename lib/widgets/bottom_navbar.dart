import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNav extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabChange;
  final PageController pageController;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
    required this.pageController,
  });

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  void _onItemTapped(int index) {
    widget.onTabChange(index);
    widget.pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linearToEaseOut);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Material(
        child: Container(
          height: 65,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: theme.colorScheme.outline,
                width: 0.1,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: GNav(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              rippleColor: theme.colorScheme.primary.withValues(alpha: 0.1),
              gap: 8,
              activeColor: theme.colorScheme.primary,
              iconSize: 22,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: theme.colorScheme.secondaryContainer,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              textStyle: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
              haptic: true,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  leading: SvgPicture.asset(
                    'assets/icons/home.svg',
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      widget.selectedIndex == 0
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                  leading: SvgPicture.asset(
                    'assets/icons/search.svg',
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      widget.selectedIndex == 1
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                GButton(
                  icon: Icons.add,
                  text: 'Add',
                  leading: SvgPicture.asset(
                    'assets/icons/add_circle.svg',
                    height: 25,
                    colorFilter: ColorFilter.mode(
                      widget.selectedIndex == 2
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                  leading: SvgPicture.asset(
                    'assets/icons/profile.svg',
                    height: 20,
                    colorFilter: ColorFilter.mode(
                      widget.selectedIndex == 3
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
              selectedIndex: widget.selectedIndex,
              onTabChange: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
