part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class LoadPostsEvent extends PostsEvent {}

class LikePostEvent extends PostsEvent {
  final String postId;
  LikePostEvent(this.postId);
  @override
  List<Object> get props => [postId];
}

class toggleSavePostEvent extends PostsEvent {}

class commentPostEvent extends PostsEvent {}

class sharePostEvent extends PostsEvent {}
