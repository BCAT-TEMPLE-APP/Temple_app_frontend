import 'package:dartz/dartz.dart';
import 'package:flutter_user_app/features/posts/data/model/dummy_post_comments.dart';
import 'package:flutter_user_app/features/posts/data/model/post_comment_model.dart';
import 'package:flutter_user_app/features/posts/domain/entities/post_comment_entity.dart';
import 'package:flutter_user_app/features/posts/domain/repository/post_comment_repository.dart';

class PostCommentRepositoryImpl implements PostCommentRepository {
  // Replace with the actual api
  final Map<String, List<PostCommentEntity>> _commentsStore = dummyPostComments;

  // getComments Implementation
  @override
  Future<Either<Exception, List<PostCommentEntity>>> getComments(
      String postId) async {
    try {
      // Network delay
      await Future.delayed(Duration(milliseconds: 300));

      // Return Comments for the specified post
      final comments = _commentsStore[postId] ?? [];
      return Right(comments);
    } catch (e) {
      return Left(Exception('Failed to fetch the comments'));
    }
  }

  // addComment Implementation
  @override
  Future<Either<Exception, PostCommentEntity>> addComment(
      PostCommentEntity comment) async {
    try {
      // Network delay
      await Future.delayed(Duration(milliseconds: 300));

      // Create a new comment
      final postCommentModel = comment is PostCommentModel
          ? comment
          : PostCommentModel(
              id: comment.id,
              postId: comment.postId,
              userId: comment.userId,
              username: comment.username,
              userImage: comment.userImage,
              text: comment.text,
              timestamp: comment.timestamp,
              replies: comment.replies,
              likes: comment.likes,
              likedBy: comment.likedBy,
              isExpanded: comment.isExpanded,
            );

      // When there is a new comment for the firt time
      if (!_commentsStore.containsKey(comment.postId)) {
        _commentsStore[comment.postId] = [];
      }
      // insert a new comment at the top of the list
      _commentsStore[comment.postId]!.insert(0, postCommentModel);
      return Right(postCommentModel);
    } catch (e) {
      return Left(Exception('Failed to add the comment: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, PostCommentEntity>> addReply(
      String commentId, PostCommentEntity reply) async {
    try {
      // Network delay
      await Future.delayed(Duration(milliseconds: 300));

      // find the parent comment
      PostCommentEntity? parentComment;
      String? postId;

      for (final entry in _commentsStore.entries) {
        final commentIndex = entry.value.indexWhere((c) => c.id == commentId);
        if (commentIndex != -1) {
          parentComment = entry.value[commentIndex];
          postId = entry.key;
          break;
        }
      }

      if (parentComment == null || postId == null) {
        return Left(Exception('Failed to find the parent comment'));
      }
      // Create a new reply
      final postCommentReplyModel = reply is PostCommentModel
          ? reply
          : PostCommentModel(
              id: reply.id,
              postId: reply.postId,
              userId: reply.userId,
              username: reply.username,
              userImage: reply.userImage,
              text: reply.text,
              timestamp: reply.timestamp,
              replies: reply.replies,
              likes: reply.likes,
              likedBy: reply.likedBy,
              isExpanded: reply.isExpanded,
            );

      // add a new reply to the parent comment
      final List<PostCommentEntity> updatedReplies = [
        ...(parentComment.replies ?? []),
        postCommentReplyModel
      ];

      // Update parent comment for a new reply
      final updatedComment =
          parentComment.copyWith(replies: updatedReplies, isExpanded: true);

      // replace the old comment with the updated one
      final commentIndex =
          _commentsStore[postId]!.indexWhere((c) => c.id == commentId);
      _commentsStore[postId]![commentIndex] = updatedComment;

      return Right(postCommentReplyModel);
    } catch (e) {
      return Left(Exception('Failed to add the reply: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, PostCommentEntity>> toggleLikeComment(
      String commentId, String userId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 200));

      PostCommentEntity? targetComment;
      String? postId;
      int? commentIndex;

      // Find the comment to like/unlike
      for (final entry in _commentsStore.entries) {
        // Check main comments
        final mainCommentIndex =
            entry.value.indexWhere((c) => c.id == commentId);

        if (mainCommentIndex != -1) {
          targetComment = entry.value[mainCommentIndex];
          postId = entry.key;
          commentIndex = mainCommentIndex;
          break;
        }

        // Check replies if not found in main comments
        for (var i = 0; i < entry.value.length; i++) {
          final comment = entry.value[i];
          if (comment.replies != null) {
            final replyIndex =
                comment.replies!.indexWhere((r) => r.id == commentId);
            if (replyIndex != -1) {
              targetComment = comment.replies![replyIndex];
              postId = entry.key;

              // Update like status for the reply
              final isLiked = targetComment.likedBy.contains(userId);
              final updatedLikedBy = isLiked
                  ? targetComment.likedBy.where((id) => id != userId).toList()
                  : [...targetComment.likedBy, userId];

              final updatedLikes =
                  isLiked ? targetComment.likes - 1 : targetComment.likes + 1;

              final updatedReply = targetComment.copyWith(
                likes: updatedLikes,
                likedBy: updatedLikedBy,
              );

              // Create new replies list with the updated reply
              final updatedReplies =
                  List<PostCommentEntity>.from(comment.replies!);
              updatedReplies[replyIndex] = updatedReply;

              // Update the parent comment with the updated replies
              final updatedComment = comment.copyWith(replies: updatedReplies);

              // Update in the store
              _commentsStore[postId]![i] = updatedComment;

              return Right(updatedReply);
            }
          }
        }
      }

      if (targetComment == null || postId == null || commentIndex == null) {
        return Left(Exception('Comment not found'));
      }

      // Toggle like status
      final isLiked = targetComment.likedBy.contains(userId);
      final updatedLikedBy = isLiked
          ? targetComment.likedBy.where((id) => id != userId).toList()
          : [...targetComment.likedBy, userId];

      final updatedLikes =
          isLiked ? targetComment.likes - 1 : targetComment.likes + 1;

      final updatedComment = targetComment.copyWith(
        likes: updatedLikes,
        likedBy: updatedLikedBy,
      );

      // Update in the store
      _commentsStore[postId]![commentIndex] = updatedComment;

      return Right(updatedComment);
    } catch (e) {
      return Left(Exception('Failed to toggle like: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, bool>> deleteComment(String commentId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));

      bool commentFound = false;

      // Search for the comment to delete
      for (final entry in _commentsStore.entries) {
        // Check if it's a main comment
        final commentIndex = entry.value.indexWhere((c) => c.id == commentId);

        if (commentIndex != -1) {
          // It's a main comment, remove it
          _commentsStore[entry.key]!.removeAt(commentIndex);
          commentFound = true;
          break;
        }

        // Check if it's a reply
        for (var i = 0; i < entry.value.length; i++) {
          final comment = entry.value[i];
          if (comment.replies != null) {
            final replyIndex =
                comment.replies!.indexWhere((r) => r.id == commentId);

            if (replyIndex != -1) {
              // It's a reply, remove it from the replies list
              final updatedReplies =
                  List<PostCommentEntity>.from(comment.replies!);
              updatedReplies.removeAt(replyIndex);

              // Update the parent comment with the modified replies list
              final updatedComment = comment.copyWith(replies: updatedReplies);
              _commentsStore[entry.key]![i] = updatedComment;

              commentFound = true;
              break;
            }
          }
        }

        if (commentFound) {
          break;
        }
      }

      if (!commentFound) {
        return Left(Exception('Comment not found'));
      }

      return const Right(true);
    } catch (e) {
      return Left(Exception('Failed to delete comment: ${e.toString()}'));
    }
  }
}
