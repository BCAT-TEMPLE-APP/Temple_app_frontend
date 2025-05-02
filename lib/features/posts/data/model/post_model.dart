import 'package:flutter_user_app/features/posts/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({
    required super.id,
    required super.username,
    required super.userImage,
    required super.location,
    required super.caption,
    required super.imageUrls,
    required super.likes,
    required super.likedBy,
    required super.timestamp,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      username: json['username'],
      userImage: json['userImage'],
      location: json['location'],
      caption: json['caption'],
      imageUrls: List<String>.from(json['imageUrls']),

      likes: json['likes'],
      likedBy: List<String>.from(json['likedBy']),
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'userImage': userImage,
      'location': location,
      'caption': caption,
      'imageUrls': imageUrls,
      'likes': likes,
      'likedBy': likedBy,
      'timestamp': timestamp,
    };
  }
}
