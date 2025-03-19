import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Model class for reminder items
class ReminderItem {
  final String title;
  final String description;
  final String time;
  final String icon;

  ReminderItem({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
  });

  factory ReminderItem.fromJson(Map<String, dynamic> json) {
    return ReminderItem(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      time: json['time'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}

// Mock API service
class ApiService {
  // Simulate API call with delay
  Future<Map<String, List<ReminderItem>>> fetchReminders() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // This would be the response from your API
    final String jsonResponse = '''
    {
      "today": [
        {
          "title": "Reminder",
          "description": "Today 7:00 Event at Shiv Mandir",
          "time": "13min",
          "icon": "bell"
        },
        {
          "title": "Reminder",
          "description": "Today 7:00 Event at Shiv Mandir",
          "time": "13min",
          "icon": "bell"
        },
        {
          "title": "Reminder",
          "description": "Today 7:00 Event at Shiv Mandir",
          "time": "13min",
          "icon": "bell"
        },
        {
          "title": "Reminder",
          "description": "Today 7:00 Event at Shiv Mandir",
          "time": "13min",
          "icon": "bell"
        }
      ],
      "tomorrow": [
        {
          "title": "Reminder",
          "description": "Tomorrow 9:00 Event at Shiv Mandir",
          "time": "1d 20h",
          "icon": "bell"
        }
      ]
    }
    ''';

    Map<String, dynamic> jsonMap = json.decode(jsonResponse);
    Map<String, List<ReminderItem>> result = {};

    jsonMap.forEach((key, value) {
      result[key] =
          (value as List).map((item) => ReminderItem.fromJson(item)).toList();
    });

    return result;
  }
}

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final ApiService _apiService = ApiService();
  Map<String, List<ReminderItem>> _reminders = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final reminders = await _apiService.fetchReminders();
      setState(() {
        _reminders = reminders;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: double.infinity, // Allow leading to take full width
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // This will navigate back to previous page
              },
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reminder',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        toolbarHeight: 82,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      'Please choose what types of support do you need and let us know.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: _reminders.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                _capitalizeFirstLetter(entry.key),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ...entry.value.map(
                                (reminder) => _buildReminderItem(reminder)),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }

  Widget _buildReminderItem(ReminderItem reminder) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bell icon container
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
            child: Center(
              child: SvgPicture.asset('assets/icons/reminder.svg',
              colorFilter: const ColorFilter.mode(
                  Color(0xFF1DCAFF), // Hex color #1DCAFF
                  BlendMode.srcIn,
                ),
              ),
            ),
            ),
            // Reminder content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          reminder.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        reminder.time,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reminder.description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
