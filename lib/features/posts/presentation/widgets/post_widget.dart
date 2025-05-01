import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_user_app/features/posts/data/model/post_model.dart';
import 'package:flutter_user_app/features/posts/domain/post_entity.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostWidget extends StatefulWidget {
  final PostEntity postModel;
  const PostWidget({Key? key, required this.postModel}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final PageController _photoPageController = PageController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
      child: Card(
        color: theme.colorScheme.surfaceContainer,
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.postModel.userImage),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.postModel.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        widget.postModel.location,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.outline,
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
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 2, bottom: 2, left: 5, right: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: PageView.builder(
                          controller: _photoPageController,
                          itemCount: widget.postModel.imageUrls.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              widget.postModel.imageUrls[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SmoothPageIndicator(
                    controller: _photoPageController,
                    count: widget.postModel.imageUrls.length,
                    effect: WormEffect(
                        dotHeight: 6,
                        dotWidth: 6,
                        spacing: 4,
                        activeDotColor: theme.colorScheme.primary),
                  )
                ],
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
                  style: TextStyle(color: theme.colorScheme.onSurface),
                  children: [
                    const TextSpan(
                      text: 'Liked by ',
                      style: TextStyle(fontSize: 14),
                    ),
                    TextSpan(
                      text: widget.postModel.likedBy.join(', '),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const TextSpan(
                      text: ' and ',
                      style: TextStyle(fontSize: 14),
                    ),
                    TextSpan(
                      text: '${widget.postModel.likes} others',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.tag, size: 14),
                      const SizedBox(width: 4),
                      Expanded(
                        child: ReadMoreText(
                          widget.postModel.caption,
                          style: const TextStyle(fontSize: 12),
                          trimMode: TrimMode.Line,
                          trimLines: 2,
                          trimCollapsedText: 'Read More',
                          trimExpandedText: 'Read Less',
                          moreStyle: TextStyle(
                            color: theme.colorScheme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          lessStyle: TextStyle(
                            color: theme.colorScheme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.postModel.timestamp,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
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
