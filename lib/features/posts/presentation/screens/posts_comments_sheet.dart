import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_user_app/features/posts/domain/entities/post_comment_entity.dart';
import 'package:flutter_user_app/features/posts/data/model/post_comment_model.dart';
import 'package:flutter_user_app/features/posts/presentation/bloc/comment_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';

class PostCommentsSheet extends StatefulWidget {
  final String postId;
  const PostCommentsSheet({super.key, required this.postId});

  @override
  State<PostCommentsSheet> createState() => _PostCommentsSheetState();
}

class _PostCommentsSheetState extends State<PostCommentsSheet> {
  final TextEditingController commentController = TextEditingController();
  String? replyingToId;

  @override
  void initState() {
    super.initState();
    context.read<CommentBloc>().add(LoadCommentsEvent(widget.postId));
  }

  void _handleSend() {
    final text = commentController.text;
    if (text.isEmpty) return;

    final newComment = PostCommentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      postId: widget.postId,
      userId: 'currentUser',
      username: 'You',
      userImage: 'https://via.placeholder.com/150',
      text: text,
      timestamp: DateTime.now().toIso8601String(),
      likes: 0,
      likedBy: [],
    );

    if (replyingToId != null) {
      context.read<CommentBloc>().add(AddReplyEvent(
            parentCommentId: replyingToId!,
            reply: newComment,
          ));
    } else {
      context.read<CommentBloc>().add(AddCommentsEvent(newComment));
    }

    setState(() {
      replyingToId = null;
      commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: 0.92,
        minChildSize: 0.86,
        maxChildSize: 0.92,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHigh,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outline,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<CommentBloc, CommentState>(
                  builder: (context, state) {
                    if (state is CommentLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is CommentLoaded) {
                      final comments = state.comments;

                      return Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Main Comment
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(comment.userImage),
                                        backgroundColor:
                                            theme.colorScheme.outline,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(comment.username,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 2),
                                            Text(comment.text),
                                            Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      replyingToId = comment.id;
                                                    });
                                                  },
                                                  style: TextButton.styleFrom(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 2)),
                                                  child: const Text('Reply'),
                                                ),
                                                if ((comment
                                                        .replies?.isNotEmpty ??
                                                    false))
                                                  TextButton(
                                                    onPressed: () => context
                                                        .read<CommentBloc>()
                                                        .add(
                                                          UpdateCommentUIState(
                                                              comment.copyWith(
                                                                  isExpanded:
                                                                      !comment
                                                                          .isExpanded)),
                                                        ),
                                                    child: Text(
                                                      comment.isExpanded
                                                          ? 'Hide replies'
                                                          : 'View ${comment.replies!.length} ${comment.replies!.length == 1 ? 'reply' : 'replies'}',
                                                      style: TextStyle(
                                                        color: theme
                                                            .colorScheme.primary
                                                            .withOpacity(0.8),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      LikeButton(
                                        isLiked: comment.likedBy
                                            .contains('currentUser'),
                                        likeCount: comment.likes,
                                        onTap: (bool isLiked) async {
                                          HapticFeedback.mediumImpact();
                                          context.read<CommentBloc>().add(
                                                ToggleLikeCommentEvent(
                                                  commentId: comment.id,
                                                  userId: 'currentUser',
                                                ),
                                              );
                                        },
                                        likeBuilder: (bool isLiked) {
                                          return Icon(
                                            isLiked
                                                ? Icons.favorite
                                                : Icons.favorite_outline,
                                            color: isLiked
                                                ? Colors.red
                                                : theme.colorScheme.onSurface,
                                            size: 25.0,
                                          );
                                        },
                                        countBuilder: (int? count, bool isLiked,
                                            String text) {
                                          int displayCount = count ?? 0;
                                          if (displayCount == 0) {
                                            return Text(
                                              "",
                                              style: TextStyle(
                                                  color: theme
                                                      .colorScheme.onSurface,
                                                  fontSize: 12),
                                            );
                                          }
                                          return Text(
                                            displayCount.toString(),
                                            style: TextStyle(
                                                color: isLiked
                                                    ? Colors.red
                                                    : theme
                                                        .colorScheme.onSurface,
                                                fontSize: 12,
                                                fontWeight: isLiked
                                                    ? FontWeight.bold
                                                    : FontWeight.w500),
                                          );
                                        },
                                      ),
                                      // IconButton(
                                      //   icon: Icon(
                                      //     Icons.favorite,
                                      //     color: comment.likedBy
                                      //             .contains('currentUser')
                                      //         ? Colors.red
                                      //         : Colors.grey,
                                      //   ),
                                      //   onPressed: () {
                                      //     context.read<CommentBloc>().add(
                                      //           ToggleLikeCommentEvent(
                                      //             commentId: comment.id,
                                      //             userId: 'currentUser',
                                      //           ),
                                      //         );
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),

                                // Replies
                                if (comment.isExpanded &&
                                    comment.replies?.isNotEmpty == true)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 56.0),
                                    child: Column(
                                      children: comment.replies!.map((reply) {
                                        return ListTile(
                                          dense: true,
                                          leading: CircleAvatar(
                                            radius: 14,
                                            backgroundImage:
                                                NetworkImage(reply.userImage),
                                            backgroundColor:
                                                theme.colorScheme.outline,
                                          ),
                                          title: Text(reply.username,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          subtitle: Text(reply.text),
                                          trailing: IconButton(
                                            icon: Icon(
                                              Icons.favorite,
                                              color: reply.likedBy
                                                      .contains('currentUser')
                                                  ? Colors.red
                                                  : Colors.grey,
                                            ),
                                            onPressed: () {
                                              context.read<CommentBloc>().add(
                                                    ToggleLikeCommentEvent(
                                                      commentId: reply.id,
                                                      userId: 'currentUser',
                                                    ),
                                                  );
                                            },
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      );
                    } else if (state is CommentError) {
                      return Text("Error: ${state.message}");
                    }

                    return const SizedBox();
                  },
                ),
                if (replyingToId != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Text(
                          'Replying to a comment',
                          style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        const Spacer(),
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            setState(() {
                              replyingToId = null;
                              commentController.text = '';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: theme.colorScheme.outline,
                        child: const Icon(Icons.person, size: 20),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            labelText: replyingToId == null
                                ? "Write a Comment"
                                : "Write a Reply",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                  color: theme.colorScheme.outline
                                      .withAlpha(0x80)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                  color: theme.colorScheme.outline
                                      .withAlpha(0x80)),
                            ),
                            filled: true,
                            fillColor:
                                theme.colorScheme.surfaceContainerHighest,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _handleSend,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/icons/send.svg',
                            width: 27,
                            height: 27,
                            colorFilter: ColorFilter.mode(
                                theme.colorScheme.onSurface, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
