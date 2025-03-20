import 'package:flutter/material.dart';

class CreatorCard extends StatelessWidget {
  final String image;
  final String name;
  final String subtitle;

  const CreatorCard({
    super.key,
    required this.image,
    required this.name,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      // Add constraints to control the size
      constraints: const BoxConstraints(maxWidth: 120, maxHeight: 180),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
       color: Colors.white, // Changed to white color
        borderRadius: BorderRadius.circular(16),
        // Removed border and added shadow
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20), // Reduce padding
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 70, // Reduce size slightly
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 6), // Reduced spacing
          Text(
            name,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: theme.colorScheme.outline,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8), // Reduced spacing
          SizedBox(
            width: 80,
            height: 28, // Reduced height
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.zero,
                minimumSize: Size.zero, // Allow smaller button size
              ),
              child: const Text(
                'Follow',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
