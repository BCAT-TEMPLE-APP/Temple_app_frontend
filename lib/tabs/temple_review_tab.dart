// tabs/review_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_intern_template/models/temple_model.dart';

class ReviewTab extends StatelessWidget {
  final List<ReviewModel> reviews;

  const ReviewTab({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<String>(
                value: 'Newest',
                items: [
                  DropdownMenuItem(
                    value: 'Newest',
                    child: Text('Newest'),
                  ),
                  DropdownMenuItem(
                    value: 'Oldest',
                    child: Text('Oldest'),
                  ),
                  DropdownMenuItem(
                    value: 'Highest Rating',
                    child: Text('Highest Rating'),
                  ),
                ],
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: reviews.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final review = reviews[index];
              return _buildReviewItem(review);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem(ReviewModel review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: review.profileImageUrl != null
                  ? NetworkImage(review.profileImageUrl!)
                  : null,
              child: review.profileImageUrl == null
                  ? Icon(Icons.person)
                  : null,
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      i < review.rating.floor()
                          ? Icons.star
                          : i < review.rating
                              ? Icons.star_half
                              : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Great!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(review.comment),
        SizedBox(height: 8),
        Row(
          children: [
            Row(
              children: [
                Icon(Icons.thumb_up, size: 16),
                SizedBox(width: 4),
                Text('${review.likes}'),
              ],
            ),
            SizedBox(width: 16),
            Row(
              children: [
                Icon(Icons.thumb_down, size: 16),
                SizedBox(width: 4),
                Text('${review.dislikes}'),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
      ],
    );
  }
}