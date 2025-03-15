import 'package:flutter/material.dart';
import 'package:flutter_intern_template/provider/theme_provider.dart';
import 'package:flutter_intern_template/widgets/custom_dropdown_widget.dart';
import 'package:flutter_intern_template/widgets/custom_page_bar.dart';
import 'package:provider/provider.dart';
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
                  _buildMenuItem(
                      Icons.people, 'Following', 'Total 220 Following'),
                  _buildMenuItem(
                      Icons.bookmark, 'Saved Post', 'Saved Photos, Videos'),
                  _buildMenuItem(Icons.access_time, 'Event Reminder',
                      'Saved Events For Reminder'),
                  _buildMenuItem(
                      Icons.credit_card, 'Donation', 'Donation History'),

                  const SizedBox(height: 10),

                  // SETTINGS Section
                  _buildSectionHeader('SETTINGS'),
                  _buildDarkModeToggle(context),
                  _buildMenuItem(Icons.language, 'Language',
                      'Select Your Favourite Language'),
                  _buildMenuItem(Icons.person, 'Switch To Creator',
                      'Switch Your Account To Creator'),

                  const SizedBox(height: 10),

                  // MORE Section
                  _buildSectionHeader('MORE'),
                  _buildMenuItem(
                      Icons.phone, 'Contact Us', 'For more information'),
                  _buildMenuItem(Icons.logout, 'Logout', ''),
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

  Widget _buildMenuItem(IconData icon, String title, String subtitle) {
    final theme = Theme.of(context);
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
            child: Icon(icon, color: theme.colorScheme.onSurface),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant),
        ],
      ),
    );
  }
}
