import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_user_app/features/posts/domain/usecase/get_posts_usecase.dart';
import 'package:flutter_user_app/features/posts/domain/entities/post_entity.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsUsecase getPostsUsecase;

  PostsBloc(this.getPostsUsecase) : super(PostsInitial()) {
    on<LoadPostsEvent>((event, emit) async {
      emit(PostLoadingState());
      final result = await getPostsUsecase();
      result.fold((error) => emit(PostErrorState('Failed to Load Posts')),
          (posts) => emit(PostLoadedState(posts)));
    });

    on<LikePostEvent>((event, emit) {
      // Ensure the current state is PostLoadedState before proceeding
      if (state is PostLoadedState) {
        final currentState = state as PostLoadedState;
        // Retrieve the identifier for the current user (this should be consistent)
        final String currentUserId =
            'currentUser'; // Replace with your actual user ID logic

        // Map over the existing posts to create an updated list
        final updatedPosts = currentState.posts.map((post) {
          // Find the post that was liked/unliked
          if (post.id == event.postId) {
            // Check if the current user already liked this post
            final bool alreadyLiked = post.likedBy.contains(currentUserId);

            // Create the updated list of users who liked the post
            final List<String> updatedLikedBy;
            if (alreadyLiked) {
              // Remove the current user if they unliked the post
              updatedLikedBy = post.likedBy
                  .where((userId) => userId != currentUserId)
                  .toList();
            } else {
              // Add the current user if they liked the post
              // ** Fixed typo: use currentUserId consistently **
              updatedLikedBy = [...post.likedBy, currentUserId];
            }

            // Calculate the updated like count
            final int updatedLikes =
                alreadyLiked ? post.likes - 1 : post.likes + 1;

            // Return a new PostEntity instance with updated like info
            // using the copyWith method for immutability
            return post.copyWith(
              likes: updatedLikes,
              likedBy: updatedLikedBy,
            );
          } else {
            // If it's not the post that was interacted with, return it unchanged
            return post;
          }
        }).toList(); // Convert the mapped iterable back to a List

        // Emit the new state with the updated list of posts
        emit(PostLoadedState(updatedPosts));
      }
      // Optional: Handle cases where the state is not PostLoadedState,
      // though typically this event should only occur when posts are loaded.
      // else { emit(state); } // Or log an error, etc.
    });
  }
}
