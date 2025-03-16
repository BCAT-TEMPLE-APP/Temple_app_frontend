import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_intern_template/widgets/video_reel_item.dart';  // Add this import
import '../widgets/custom_page_bar.dart';  // Add this import

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // Sample data for videos
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

  @override
  void dispose() {
    _pageController.dispose();
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
              return VideoReelItem(
                videoData: _videos[index],
                onLikePressed: () {
                  setState(() {
                    _videos[index]['isLiked'] = !_videos[index]['isLiked'];
                    if (_videos[index]['isLiked']) {
                      _videos[index]['likes']++;
                    } else {
                      _videos[index]['likes']--;
                    }
                  });
                },
              );
            },
          ),
          
          // Remove the existing top navigation bar since we now use CustomPageBar
        ],
      ),
    );
  }
}



