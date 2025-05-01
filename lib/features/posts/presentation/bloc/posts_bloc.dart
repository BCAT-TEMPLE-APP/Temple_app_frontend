import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_user_app/features/posts/domain/get_posts_usecase.dart';
import 'package:flutter_user_app/features/posts/domain/post_entity.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsUsecase getPostsUsecase;

  PostsBloc(this.getPostsUsecase) : super(PostsInitial()) {
    on<LoadPostsEvent>((event, emit) async {
      emit(PostLoadingState());
      final result = await getPostsUsecase();
      result.fold(
        (error) => emit(PostErrorState('Failed to Load Posts')),
      (posts) => emit(PostLoadedState(posts))
      );
    });
  }
}
