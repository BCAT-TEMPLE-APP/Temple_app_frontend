// widgets/profile_actions.dart
import 'package:flutter/material.dart';

import 'package:flutter_user_app/features/creator/data/model/creator_model.dart';
import 'package:flutter_user_app/features/profile/presentation/screens/following_page.dart';

class CreatorProfileActions extends StatelessWidget {
  final CreatorModel profile;

  const CreatorProfileActions({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('Share'),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FollowingsScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text('Followers'),
            ),
          ),
        ],
      ),
    );
  }
}
