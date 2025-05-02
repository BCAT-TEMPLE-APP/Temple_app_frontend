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
    result.fold((error) => emit(CommentError(error.toString())),
        (comments) => emit(CommentLoaded(comments)));
  }

  FutureOr<void> _onAddComments(
      AddCommentsEvent event, Emitter<CommentState> emit) async {
    if (state is CommentLoaded) {
      final currentComments = (state as CommentLoaded).comments;
      final result = await repository.addComment(event.comment);
      result.fold(
          (error) => emit(CommentError(error.toString())),
          (newComment) =>
              emit(CommentLoaded([newComment, ...currentComments])));
    }
  }

  Future<void> _onAddReply(
      AddReplyEvent event, Emitter<CommentState> emit) async {
    final result =
        await repository.addReply(event.parentCommentId, event.reply);
    if (state is CommentLoaded) {
      add(LoadCommentsEvent(event.reply.postId));
    }
  }

  FutureOr<void> _onToggleLikeComment(
      ToggleLikeCommentEvent event, Emitter<CommentState> emit) async {
    final result =
        await repository.toggleLikeComment(event.commentId, event.userId);
    if (state is CommentLoaded) {
      final currentPostId = (state as CommentLoaded).comments.first.postId;
      add(LoadCommentsEvent(currentPostId));
    }
  }

  Future<void> _onDeleteComment(
      DeleteCommentEvent event, Emitter<CommentState> emit) async {
    final result = await repository.deleteComment(event.commentId);

    result.fold(
      (error) => emit(CommentError(error.toString())),
      (_) {
        if (state is CommentLoaded) {
          final postId = (state as CommentLoaded).comments.first.postId;
          add(LoadCommentsEvent(postId));
        }
      },
    );
  }

  FutureOr<void> _updateCommentUIState(
      UpdateCommentUIState event, Emitter<CommentState> emit) {
    if (state is CommentLoaded) {
      final updatedList = (state as CommentLoaded).comments.map((c) {
        if (c.id == event.updatedComment.id) {
          return event.updatedComment;
        }
        return c;
      }).toList(growable: false); // 🔑 create new list reference

      // 🔥 Force full state update
      emit(CommentLoading());
      emit(CommentLoaded(updatedList));
    }
  }
}
