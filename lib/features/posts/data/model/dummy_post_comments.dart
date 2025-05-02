import 'package:flutter_user_app/features/posts/data/model/post_comment_model.dart';
import 'package:flutter_user_app/features/posts/domain/entities/post_comment_entity.dart';

final Map<String, List<PostCommentEntity>> dummyPostComments = {
  'post1': [
    PostCommentModel(
      id: 'comment1',
      postId: 'post1',
      userId: 'user1',
      username: 'jane_smith',
      userImage: 'https://example.com/images/jane.jpg',
      text: 'This place looks amazing! When did you visit?',
      timestamp: '2025-05-01 14:32:10',
      likes: 5,
      likedBy: ['user2', 'user3'],
      replies: [
        PostCommentModel(
          id: 'reply1',
          postId: 'post1',
          userId: 'user2',
          username: 'john_doe',
          userImage: 'https://example.com/images/user1.jpg',
          text: 'Last weekend! It was beautiful.',
          timestamp: '2025-05-01 14:45:10',
          likes: 2,
          likedBy: ['user1'],
        ),
      ],
    ),
  ],
  'post2': [
    PostCommentModel(
      id: 'comment2',
      postId: 'post2',
      userId: 'user3',
      username: 'mountain_lover',
      userImage: 'https://example.com/images/user3.jpg',
      text: 'I love Manali! ❄️',
      timestamp: '2025-05-01 11:10:00',
      likes: 3,
      likedBy: ['user1', 'user4'],
    ),
  ],
  'post3': [
    PostCommentModel(
      id: 'comment3',
      postId: 'post3',
      userId: 'user5',
      username: 'foodie_queen',
      userImage: 'https://example.com/images/user5.jpg',
      text: 'Best chole bhature ever! 🤤',
      timestamp: '2025-05-01 10:30:00',
      likes: 4,
      likedBy: ['user1', 'user2', 'user3'],
    ),
  ],
};
