// widgets/profile_actions.dart
import 'package:flutter/material.dart';
import 'package:flutter_user_app/features/temples/data/models/temple_model.dart';
import 'package:flutter_user_app/features/temples/presentation/screens/temple_donation_screen.dart';

class ProfileActions extends StatelessWidget {
  final TempleModel profile;

  const ProfileActions({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildButton(text: 'Follow', onPressed: () {}, context: context),
          SizedBox(width: 10),
          _buildButton(text: 'Maps', onPressed: () {}, context: context),
          SizedBox(width: 10),
          _buildButton(
              text: 'Donations',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DonationScreen(),
                  ),
                );
              },
              context: context),
        ],
      ),
    );
  }

  Widget _buildButton(
      {required String text,
      required VoidCallback onPressed,
      required BuildContext context}) {
    final theme = Theme.of(context);
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(text),
      ),
    );
  }
}
