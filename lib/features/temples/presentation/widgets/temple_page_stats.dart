// widgets/profile_stats.dart
import 'package:flutter/material.dart';
import 'package:flutter_user_app/features/temples/data/models/temple_model.dart';

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
          _buildStat('${profile.posts}', 'Posts', context),
          _buildStat('${profile.followers}', 'Followers', context),
          _buildStat('${profile.following}', 'Following', context),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label, BuildContext context) {
    final theme = Theme.of(context);
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
            color: theme.colorScheme.outline,
          ),
        ),
      ],
    );
  }
}
