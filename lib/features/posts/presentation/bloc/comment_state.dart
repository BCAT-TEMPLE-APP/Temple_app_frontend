part of 'comment_bloc.dart';

sealed class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

final class CommentInitial extends CommentState {}

final class CommentLoading extends CommentState {}

final class CommentUpdating extends CommentState {}

final class CommentLoaded extends CommentState {
  final List<PostCommentEntity> comments;
  CommentLoaded(this.comments);
}

final class CommentError extends CommentState {
  final String message;
  CommentError(this.message);
}

class UpdateCommentUIState extends CommentEvent {
  final PostCommentEntity updatedComment;
  const UpdateCommentUIState(this.updatedComment);

  @override
  List<Object> get props => [updatedComment];
}
