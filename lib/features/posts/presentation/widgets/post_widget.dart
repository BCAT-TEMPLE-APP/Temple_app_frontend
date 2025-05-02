import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_user_app/features/posts/data/repository/post_comment_repository_impl.dart';
// Assuming PostModel and PostEntity are correctly imported and defined
// import 'package:flutter_user_app/features/posts/data/model/post_model.dart';
import 'package:flutter_user_app/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_user_app/features/posts/presentation/bloc/comment_bloc.dart';
// Assuming PostsBloc and LikePostEvent are correctly imported and defined
import 'package:flutter_user_app/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:flutter_user_app/features/posts/presentation/screens/posts_comments_sheet.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostWidget extends StatefulWidget {
  final PostEntity postModel;
  const PostWidget({Key? key, required this.postModel}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget>
    with SingleTickerProviderStateMixin {
  final String currentUserId =
      'currentUser'; // Consider fetching this dynamically
  final PageController _photoPageController = PageController();

  // Animation state for the heart/broken heart icon
  bool _showAnimation = false;
  bool _isAnimatingLike = true; // true for like, false for unlike

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Duration of the animation
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubicEmphasized,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0,
            curve: Curves.easeInOutBack), // Fade out in the second half
      ),
    );

    // Add a listener to reset the animation state when it completes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showAnimation = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _photoPageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Method to trigger the animation
  void _triggerAnimation(bool isLike) {
    setState(() {
      _isAnimatingLike = isLike;
      _showAnimation = true;
    });
    _animationController.forward(from: 0.0); // Start the animation
  }

  @override
  Widget build(BuildContext context) {
    final postsBloc = context.read<PostsBloc>();
    final bool isLikedByCurrentUser =
        widget.postModel.likedBy.contains(currentUserId);

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
                    onPressed: () {
                      // TODO: Implement more options logic
                    },
                  ),
                ],
              ),
            ),
            // Wrap the image area with a Stack to overlay the animation
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onDoubleTap: () {
                    HapticFeedback.mediumImpact();
                    // Determine if the double-tap results in a like or unlike
                    bool willBeLiked = !isLikedByCurrentUser;
                    _triggerAnimation(
                        willBeLiked); // Trigger animation BEFORE dispatching
                    postsBloc.add(LikePostEvent(widget.postModel.id));
                  },
                  child: SizedBox(
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
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
                              errorBuilder: (context, error, stackTrace) =>
                                  const Center(child: Icon(Icons.broken_image)),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // Animation Overlay
                if (_showAnimation)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Lottie.asset(
                        _isAnimatingLike
                            ? 'assets/lottie/like.json'
                            : 'assets/lottie/unlike1.json',
                        height: _isAnimatingLike ? 300 : 100,
                        width: _isAnimatingLike ? 300 : 100,
                      ),
                      // child: Icon(
                      //   _isAnimatingLike ? Icons.favorite : Icons.heart_broken,
                      //   color: _isAnimatingLike ? Colors.red : Colors.grey[700],
                      //   size: 100, // Adjust size as needed
                      // ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 8),
            if (widget.postModel.imageUrls.length > 1)
              Center(
                child: SmoothPageIndicator(
                  controller: _photoPageController,
                  count: widget.postModel.imageUrls.length,
                  effect: WormEffect(
                      dotHeight: 6,
                      dotWidth: 6,
                      spacing: 4,
                      activeDotColor: theme.colorScheme.primary),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  LikeButton(
                    size: 25.0,
                    isLiked: isLikedByCurrentUser,
                    likeCount: widget.postModel.likes,
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        isLiked ? Icons.favorite : Icons.favorite_outline,
                        color:
                            isLiked ? Colors.red : theme.colorScheme.onSurface,
                        size: 25.0,
                      );
                    },
                    countBuilder: (int? count, bool isLiked, String text) {
                      int displayCount = count ?? 0;
                      if (displayCount == 0) {
                        return Text(
                          "",
                          style: TextStyle(
                              color: theme.colorScheme.onSurface, fontSize: 12),
                        );
                      }
                      return Text(
                        displayCount.toString(),
                        style: TextStyle(
                            color: isLiked
                                ? Colors.red
                                : theme.colorScheme.onSurface,
                            fontSize: 12,
                            fontWeight:
                                isLiked ? FontWeight.bold : FontWeight.w500),
                      );
                    },
                    onTap: (bool isLiked) async {
                      HapticFeedback.mediumImpact();
                      // The LikeButton handles its own optimistic animation
                      // We still dispatch the BLoC event
                      postsBloc.add(LikePostEvent(widget.postModel.id));
                      return !isLiked; // Return the opposite for optimistic UI
                    },
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
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => BlocProvider(
                          create: (_) =>
                              CommentBloc(PostCommentRepositoryImpl()),
                          child: PostCommentsSheet(postId: widget.postModel.id),
                        ),
                      );
                    },
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
                    onTap: () {
                      // TODO: Implement share button logic
                    },
                  ),
                  const SizedBox(width: 8),
                  const Spacer(),
                  // TODO: Implement bookmark button logic
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
                      text: _formattedLikedByList(widget.postModel.likedBy),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const TextSpan(
                      text: ' and ',
                      style: TextStyle(fontSize: 14),
                    ),
                    TextSpan(
                      text: '${widget.postModel.likes} others',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
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

  String _formattedLikedByList(List<String> likedBy) {
    // Basic formatting, replace with your actual logic
    if (likedBy.isEmpty) {
      return '';
    } else if (likedBy.length == 1) {
      return likedBy.first;
    } else {
      return likedBy.take(2).join(', '); // Show first two likers
    }
  }

  Widget _buildAnimatedButton(
      {required Widget icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: icon,
      ),
    );
  }
}
