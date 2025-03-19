import 'package:flutter/material.dart';
import 'package:flutter_intern_template/helper/navigation_helper.dart';
import 'package:flutter_intern_template/provider/theme_provider.dart';

import 'package:flutter_intern_template/screens/main_screens/contact_us_page.dart';
import 'package:flutter_intern_template/screens/login_screens/login_page.dart';
import 'package:flutter_intern_template/screens/profile_screens/reminder_page.dart';
import 'package:flutter_intern_template/screens/profile_screens/saved_post.dart';
import 'package:flutter_intern_template/screens/temple_screens/temple_donation_screen.dart';
import 'package:flutter_intern_template/widgets/custom_widgets/custom_dropdown_widget.dart';
import 'package:flutter_intern_template/widgets/custom_widgets/custom_page_bar.dart';
import 'package:flutter_intern_template/widgets/custom_widgets/profile_item_widget.dart';

import 'package:provider/provider.dart';
import 'package:flutter_intern_template/screens/profile_screens/following_page.dart';
import 'profile_edit_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDarkModeEnabled = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: CustomPageBar(title: "Profile"),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            // Profile Picture & Info
            Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: theme.colorScheme.primary, width: 3),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://randomuser.me/api/portraits/men/35.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Hannah Turin',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'madhuresh@gmail.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 15),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileEditScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: BorderSide(color: theme.colorScheme.primary),
                  ),
                  child: Text(
                    'Edit',
                    style: TextStyle(color: theme.colorScheme.primary),
                  ),
                ),
              ],
            ),

            // Menu Sections
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 18),

                  // GENERAL Section
                  _buildSectionHeader('GENERAL'),

                  // Profile Items
                  ProfileItemsWidget(
                    icon: Icons.people,
                    title: 'Following',
                    subtitle: 'Total 220 Following',
                    onTap: () {
                      navigateToPage(context, const FollowingsScreen());
                    },
                  ),

                  ProfileItemsWidget(
                    icon: Icons.bookmark,
                    title: 'Saved Post',
                    subtitle: 'Saved Photos, Videos',
                    onTap: () {
                      navigateToPage(context, const SavedPostScreen());
                    },
                  ),

                  ProfileItemsWidget(
                    icon: Icons.access_time,
                    title: 'Event Reminder',
                    subtitle: 'Saved Events For Reminder',
                    onTap: () {
                      navigateToPage(context, const ReminderScreen());
                    },
                  ),

                  ProfileItemsWidget(
                    icon: Icons.credit_card,
                    title: 'Donation',
                    subtitle: 'Donation History',
                    onTap: () {
                      navigateToPage(context, DonationScreen());
                    },
                  ),

                  const SizedBox(height: 10),

                  // SETTINGS Section
                  _buildSectionHeader('SETTINGS'),
                  _buildDarkModeToggle(context),

                  ProfileItemsWidget(
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: 'Select Your Favourite Language',
                    onTap: () {},
                  ),

                  ProfileItemsWidget(
                    icon: Icons.person,
                    title: 'Switch To Creator',
                    subtitle: 'Switch Your Account To Creator',
                    onTap: () {},
                  ),

                  const SizedBox(height: 10),

                  // MORE Section
                  _buildSectionHeader('MORE'),

                  ProfileItemsWidget(
                    icon: Icons.phone,
                    title: 'Contact Us',
                    subtitle: 'For more information',
                    onTap: () {
                      navigateToPage(context, const ContactUs());
                    },
                  ),

                  ProfileItemsWidget(
                    icon: Icons.logout,
                    title: 'Logout',
                    subtitle: 'Logout from the current account',
                    onTap: () {
                      navigateToPage(context, LoginPage());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildDarkModeToggle(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final List<Map<String, dynamic>> themeModes = [
      {"label": "Light", "mode": ThemeMode.light},
      {"label": "Dark", "mode": ThemeMode.dark},
      {"label": "System", "mode": ThemeMode.system},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              themeProvider.themeMode == ThemeMode.dark
                  ? Icons.dark_mode_outlined
                  : themeProvider.themeMode == ThemeMode.light
                      ? Icons.light_mode_outlined
                      : Icons.brightness_auto,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Current: ${themeModes.firstWhere((item) => item["mode"] == themeProvider.themeMode)["label"]}',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(40),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ThemeMode>(
                  value: themeProvider.themeMode,
                  dropdownColor: theme.colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(10),
                  items:
                      themeModes.map<DropdownMenuItem<ThemeMode>>((themeMode) {
                    return DropdownMenuItem<ThemeMode>(
                      value: themeMode['mode'] as ThemeMode,
                      child: Text(
                        themeMode['label'] as String,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                  onChanged: (ThemeMode? newMode) {
                    if (newMode != null) {
                      themeProvider.setThemeMode(newMode);
                    }
                  },
                  icon: Icon(Icons.arrow_drop_down,
                      color: theme.colorScheme.onSurface),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
