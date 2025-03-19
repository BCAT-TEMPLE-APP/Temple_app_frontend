import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ModifiedVideoReelItem extends StatelessWidget {
  final Map<String, dynamic> videoData;
  final VideoPlayerController videoController;
  final VoidCallback onLikePressed;

  const ModifiedVideoReelItem({
    super.key,
    required this.videoData,
    required this.videoController,
    required this.onLikePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video player
        videoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: videoController.value.aspectRatio,
                child: VideoPlayer(videoController),
              )
            : const Center(child: CircularProgressIndicator()),

        // UI overlay (likes, comments, etc.)
        Positioned(
          right: 16,
          bottom: 100,
          child: Column(
            children: [
              // Like button
              IconButton(
                icon: Icon(
                  videoData['isLiked'] ? Icons.favorite : Icons.favorite_border,
                  color: videoData['isLiked'] ? Colors.red : Colors.white,
                  size: 32,
                ),
                onPressed: onLikePressed,
              ),
              Text(
                '${videoData['likes']}',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              // Comment button
              IconButton(
                icon: const Icon(
                  Icons.comment,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: () {},
              ),
              Text(
                '${videoData['comments']}',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
