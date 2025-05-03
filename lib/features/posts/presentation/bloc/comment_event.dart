part of 'comment_bloc.dart';

sealed class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class LoadCommentsEvent extends CommentEvent {
  final String postId;
  final bool initiallyExpanded;
  const LoadCommentsEvent(this.postId, {this.initiallyExpanded = false});

  @override
  List<Object> get props => [postId];
}

class AddCommentsEvent extends CommentEvent {
  final PostCommentEntity comment;
  const AddCommentsEvent(this.comment);

  @override
  List<Object> get props => [comment];
}

class AddReplyEvent extends CommentEvent {
  final String parentCommentId;
  final PostCommentEntity reply;
  const AddReplyEvent({required this.parentCommentId, required this.reply});

  @override
  List<Object> get props => [parentCommentId, reply];
}

class ToggleLikeCommentEvent extends CommentEvent {
  final String commentId;
  final String userId;
  const ToggleLikeCommentEvent({required this.commentId, required this.userId});

  @override
  List<Object> get props => [commentId, userId];
}

class DeleteCommentEvent extends CommentEvent {
  final String commentId;
  const DeleteCommentEvent(this.commentId);

  @override
  List<Object> get props => [commentId];
}
