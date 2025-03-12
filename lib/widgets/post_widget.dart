import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostWidget extends StatelessWidget {
  final String username;
  final String location;
  final String userImage;
  final String postImage;
  final String caption;
  final String likes;
  final String likedBy;
  final String timestamp;

  const PostWidget({
    Key? key,
    this.username = 'cameron_will',
    this.location = 'New Delhi, India',
    this.userImage = 'https://randomuser.me/api/portraits/women/44.jpg',
    this.postImage =
        'https://images.unsplash.com/photo-1552728089-57bdde30beb3?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
    this.caption = 'Million Parrots in India Like a Family...',
    this.likes = '903',
    this.likedBy = 'Lucas',
    this.timestamp = 'Wed, 25 January 2023',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userImage),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              postImage,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              _buildAnimatedButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onTap: () {},
              ),
              const SizedBox(width: 8),
              _buildAnimatedButton(
                icon: SvgPicture.asset(
                  'assets/icons/chat.svg',
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
                onTap: () {},
              ),
              const SizedBox(width: 8),
              _buildAnimatedButton(
                icon: SvgPicture.asset(
                  'assets/icons/share.svg',
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                  height: 28,
                ),
                onTap: () {},
              ),
              const SizedBox(width: 8),
              const Spacer(),
              const Icon(Icons.bookmark_border),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                const TextSpan(
                  text: 'Liked by ',
                  style: TextStyle(fontSize: 14),
                ),
                TextSpan(
                  text: likedBy,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const TextSpan(
                  text: ' and ',
                  style: TextStyle(fontSize: 14),
                ),
                TextSpan(
                  text: '$likes others',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.tag, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    caption,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      '(More)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                timestamp,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildAnimatedButton(
      {required Widget icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 200),
        tween: Tween<double>(begin: 1, end: 1),
        builder: (context, double value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: icon,
      ),
    );
  }
}
