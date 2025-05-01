// widgets/profile_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_user_app/features/creator/data/model/creator_model.dart';

class CreatorProfileHeader extends StatelessWidget {
  final CreatorModel profile;
  const CreatorProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          // Background Image
          ClipRRect(
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(
                  image: Image.network(
                          'https://imgeng.jagran.com/images/2025/01/21/article/image/premanand-ji-maharaj-hd-wallpaper-1737454318592_v.webp')
                      .image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Profile Info

          Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          '${profile.rating} (${profile.totalReviews} Reviews)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '+ Website',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
