import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_user_app/features/posts/domain/entities/post_comment_entity.dart';
import 'package:flutter_user_app/features/posts/domain/repository/post_comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final PostCommentRepository repository;

  CommentBloc(this.repository) : super(CommentInitial()) {
    on<LoadCommentsEvent>(_onLoadComments);
    on<AddCommentsEvent>(_onAddComments);
    on<AddReplyEvent>(_onAddReply);
    on<ToggleLikeCommentEvent>(_onToggleLikeComment);
    on<DeleteCommentEvent>(_onDeleteComment);
    on<UpdateCommentUIState>(_updateCommentUIState);
  }

  FutureOr<void> _onLoadComments(
      LoadCommentsEvent event, Emitter<CommentState> emit) async {
    emit(CommentLoading());
    final result = await repository.getComments(event.postId);

    result.fold((error) => emit(CommentError(error.toString())), (comments) {
      // Process comments to set isExpanded to false by default
      final processedComments = comments
          .map((comment) => comment.copyWith(isExpanded: false))
          .toList();

      emit(CommentLoaded(processedComments));
    });
  }

  FutureOr<void> _onAddComments(
      AddCommentsEvent event, Emitter<CommentState> emit) async {
    if (state is CommentLoaded) {
      final currentComments = (state as CommentLoaded).comments;

      // Let UI know we're processing
      emit(CommentUpdating());

      try {
        final result = await repository.addComment(event.comment);

        await result.fold((error) async {
          emit(CommentError(error.toString()));
          // Return to previous state if there's an error
          emit(CommentLoaded(currentComments));
        }, (newComment) async {
          // Get fresh comments from repository to ensure consistent state
          final updatedResult =
              await repository.getComments(event.comment.postId);

          await updatedResult.fold((error) async {
            emit(CommentError(error.toString()));
            // Fall back to simple append if refresh fails
            emit(CommentLoaded([newComment, ...currentComments]));
          }, (updatedComments) async {
            emit(CommentLoaded(updatedComments));
          });
        });
      } catch (e) {
        emit(CommentError(e.toString()));
        // Return to previous state if there's an exception
        emit(CommentLoaded(currentComments));
      }
    }
  }

  Future<void> _onAddReply(
      AddReplyEvent event, Emitter<CommentState> emit) async {
    if (state is CommentLoaded) {
      final currentState = state as CommentLoaded;
      final currentComments = currentState.comments;

      // Find the parent comment
      final parentIndex =
          currentComments.indexWhere((c) => c.id == event.parentCommentId);

      if (parentIndex != -1) {
        emit(
            CommentUpdating()); // Optional micro-state to show a subtle loading indicator just for the reply

        try {
          final result =
              await repository.addReply(event.parentCommentId, event.reply);

          await result.fold(
            (error) async {
              emit(CommentError(error.toString()));
            },
            (reply) async {
              // Get updated comments to ensure we have the latest structure
              final updatedResult =
                  await repository.getComments(event.reply.postId);

              await updatedResult.fold(
                (error) async {
                  emit(CommentError(error.toString()));
                },
                (updatedComments) async {
                  emit(CommentLoaded(updatedComments));
                },
              );
            },
          );
        } catch (e) {
          emit(CommentError(e.toString()));
        }
      }
    }
  }

  FutureOr<void> _onToggleLikeComment(
      ToggleLikeCommentEvent event, Emitter<CommentState> emit) async {
    if (state is CommentLoaded) {
      final currentState = state as CommentLoaded;
      final currentComments =
          List<PostCommentEntity>.from(currentState.comments);

      // Apply optimistic update first
      final updatedComments = _updateCommentLikeStatus(
          currentComments, event.commentId, event.userId);

      // Update UI immediately (optimistic update)
      emit(CommentLoaded(updatedComments));

      // Then perform the actual API call
      final result =
          await repository.toggleLikeComment(event.commentId, event.userId);

      // Handle failure case (revert optimistic update)
      result.fold((error) {
        emit(CommentError(error.toString()));
        // Revert back to previous state if API call fails
        emit(CommentLoaded(currentComments));
      }, (_) {} // Success case already handled by optimistic update
          );
    }
  }

  // Helper method to update comment like status locally for optimistic updates
  List<PostCommentEntity> _updateCommentLikeStatus(
      List<PostCommentEntity> comments, String commentId, String userId) {
    return comments.map((comment) {
      // Check if this is the comment to update
      if (comment.id == commentId) {
        final isLiked = comment.likedBy.contains(userId);
        final updatedLikedBy = isLiked
            ? comment.likedBy.where((id) => id != userId).toList()
            : [...comment.likedBy, userId];
        final updatedLikes = isLiked ? comment.likes - 1 : comment.likes + 1;

        return comment.copyWith(
          likes: updatedLikes,
          likedBy: updatedLikedBy,
        );
      }

      // Check if the comment is in replies
      if (comment.replies != null && comment.replies!.isNotEmpty) {
        final updatedReplies = comment.replies!.map((reply) {
          if (reply.id == commentId) {
            final isLiked = reply.likedBy.contains(userId);
            final updatedLikedBy = isLiked
                ? reply.likedBy.where((id) => id != userId).toList()
                : [...reply.likedBy, userId];
            final updatedLikes = isLiked ? reply.likes - 1 : reply.likes + 1;

            return reply.copyWith(
              likes: updatedLikes,
              likedBy: updatedLikedBy,
            );
          }
          return reply;
        }).toList();

        return comment.copyWith(replies: updatedReplies);
      }

      return comment;
    }).toList();
  }

  Future<void> _onDeleteComment(
      DeleteCommentEvent event, Emitter<CommentState> emit) async {
    if (state is CommentLoaded) {
      final currentState = state as CommentLoaded;
      final currentComments = currentState.comments;

      // Apply optimistic update for comment deletion
      final updatedComments =
          _removeCommentFromList(currentComments, event.commentId);
      emit(CommentLoaded(updatedComments));

      // Make the actual API call
      final result = await repository.deleteComment(event.commentId);

      result.fold((error) {
        // Revert on error
        emit(CommentError(error.toString()));
        emit(CommentLoaded(currentComments));
      }, (_) {} // Success case handled by optimistic update
          );
    }
  }

  // Helper method to remove a comment from the list
  List<PostCommentEntity> _removeCommentFromList(
      List<PostCommentEntity> comments, String commentId) {
    // Check if it's a top-level comment
    final filteredComments = comments.where((c) => c.id != commentId).toList();

    // If length is the same, it might be a reply
    if (filteredComments.length == comments.length) {
      return comments.map((comment) {
        if (comment.replies != null && comment.replies!.isNotEmpty) {
          final filteredReplies =
              comment.replies!.where((r) => r.id != commentId).toList();

          // If we found and removed a reply
          if (filteredReplies.length < comment.replies!.length) {
            return comment.copyWith(replies: filteredReplies);
          }
        }
        return comment;
      }).toList();
    }

    return filteredComments;
  }

  FutureOr<void> _updateCommentUIState(
      UpdateCommentUIState event, Emitter<CommentState> emit) {
    if (state is CommentLoaded) {
      final currentComments = (state as CommentLoaded).comments;
      final updatedList = currentComments.map((c) {
        if (c.id == event.updatedComment.id) {
          return event.updatedComment;
        }
        return c;
      }).toList();

      emit(CommentLoading());
      emit(CommentLoaded(updatedList));
    }
  }
}
