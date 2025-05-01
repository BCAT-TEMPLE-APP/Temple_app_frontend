import 'package:dartz/dartz.dart';
import 'package:flutter_user_app/features/posts/data/model/dummy_post.dart';
import 'package:flutter_user_app/features/posts/domain/post_entity.dart';
import 'package:flutter_user_app/features/posts/domain/post_repository.dart';

// This is a concrete implementation of PostRepository
// This will fetch all the posts from the api and return either error or the success posts

// Flow
// UI → GetPostsUsecase → PostRepository (interface) → PostRepositoryImpl (concrete implementation)
class PostRepositoryImpl implements PostRepository {
  @override
  Future<Either<Exception, List<PostEntity>>> getPost() {
    try {
      // Return dummy model for now
      // Right is basically a success response i.e List<PostEntity>
      return Future.value(Right(dummyPosts));
    } catch (e) {
      // Left is basically a failure response i.e Exception
      return Future.value(Left(Exception('Failed to Load Posts')));
    }
  }
}
