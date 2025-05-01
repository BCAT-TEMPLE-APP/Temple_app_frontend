import 'package:flutter/material.dart';
import 'package:flutter_user_app/features/temples/data/models/temple_model.dart';

class TempleCard extends StatefulWidget {
  final TempleModel templeModel;

  const TempleCard({
    super.key,
    required this.templeModel
  });

  @override
  State<TempleCard> createState() => _TempleCardState();
}

class _TempleCardState extends State<TempleCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      // Use a ConstrainedBox to ensure minimum and maximum height
      constraints: const BoxConstraints(maxWidth: 200, maxHeight: 180),
      margin: const EdgeInsets.symmetric(
          vertical: 8, horizontal: 4), // Reduced vertical margin
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.3)),
      ),

      child: Padding(
        padding: const EdgeInsets.all(10), // Slightly reduced padding
        child: Column(
          mainAxisSize: MainAxisSize.min, // Use minimum space needed
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container with fixed height
            Container(
              height: 100, // Slightly reduced height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(widget.templeModel.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8), // Reduced spacing
            // Temple name with constrained height
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Text(
                widget.templeModel.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Location info with constrained height
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: SizedBox(
                height: 20, // Fixed height for location row
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: theme.colorScheme.primary,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.templeModel.location,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
