import 'package:flutter/material.dart';
import 'package:flutter_user_app/features/reels/presentation/widgets/modified_reel_video.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_user_app/features/reels/presentation/widgets/video_reel_item.dart';
import '../../../../widgets/custom_widgets/custom_page_bar.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // Sample data for videos - now all pointing to the same video
  final List<Map<String, dynamic>> _videos = [
    {
      'videoUrl': 'assets/video/vid.mp4',
      'likes': 346,
      'comments': 65,
      'isLiked': false,
    },
    {
      'videoUrl': 'assets/video/vid.mp4',
      'likes': 129,
      'comments': 32,
      'isLiked': false,
    },
    {
      'videoUrl': 'assets/video/vid.mp4',
      'likes': 508,
      'comments': 98,
      'isLiked': false,
    },
  ];

  // Add a controller for the shared video
  late VideoPlayerController _sharedController;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize the shared controller
    _sharedController = VideoPlayerController.asset('assets/video/vid.mp4')
      ..initialize().then((_) {
        setState(() {
          _isControllerInitialized = true;
        });
        _sharedController.setLooping(true);
        _sharedController.play();
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _sharedController.dispose(); // Make sure to dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomPageBar(title: 'Videos'),
      body: Stack(
        children: [
          // Video PageView for scrolling
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: _videos.length,
            itemBuilder: (context, index) {
              // Modified VideoReelItem that uses shared controller instead of creating new ones
              return _isControllerInitialized
                  ? ModifiedVideoReelItem(
                      videoData: _videos[index],
                      videoController: _sharedController,
                      onLikePressed: () {
                        setState(() {
                          _videos[index]['isLiked'] =
                              !_videos[index]['isLiked'];
                          if (_videos[index]['isLiked']) {
                            _videos[index]['likes']++;
                          } else {
                            _videos[index]['likes']--;
                          }
                        });
                      },
                    )
                  : const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}

// Create a modified version of VideoReelItem that uses a shared controller

