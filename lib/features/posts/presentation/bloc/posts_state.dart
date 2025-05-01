part of 'posts_bloc.dart';

@immutable
sealed class PostsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}

final class PostLoadingState extends PostsState {}

final class PostLoadedState extends PostsState {
  final List<PostEntity> posts;
  PostLoadedState(this.posts);
  @override
  List<Object> get props => [posts];
}

final class PostErrorState extends PostsState {
  final String message;
  PostErrorState(this.message);
  @override
  List<Object> get props => [message];
}
