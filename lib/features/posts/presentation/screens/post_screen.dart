import 'package:flutter/material.dart';
import 'package:flutter_user_app/features/posts/data/repository/post_repository_impl.dart';
import 'package:flutter_user_app/features/posts/domain/usecase/get_posts_usecase.dart';
import 'package:flutter_user_app/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_user_app/features/posts/presentation/widgets/post_widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostsBloc(GetPostsUsecase(PostRepositoryImpl()))
        ..add(LoadPostsEvent()),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostLoadingState) {
            return Center(child: const CircularProgressIndicator());
          } else if (state is PostLoadedState) {
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return PostWidget(postModel: state.posts[index]);
                });
          } else if (state is PostErrorState) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
