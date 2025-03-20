// widgets/profile_stats.dart
import 'package:flutter/material.dart';
import 'package:flutter_user_app/models/temple_model.dart';

class ProfileStats extends StatelessWidget {
  final TempleModel profile;

  const ProfileStats({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStat('${profile.posts}', 'Posts'),
          _buildStat('${profile.followers}', 'Followers'),
          _buildStat('${profile.following}', 'Following'),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}