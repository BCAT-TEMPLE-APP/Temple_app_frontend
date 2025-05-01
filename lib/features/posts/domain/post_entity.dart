class PostEntity {
  final String id;
  final String username;
  final String userImage;
  final String location;
  final String caption;

  final List<String> imageUrls; // Renamed from imageUrl for clarity
  final List<String>? comments; // List to support multiple comments
  final int likes; // Changed from String to int for better handling
  final List<String> likedBy; // Users who liked
  final String timestamp; // Ideally DateTime, but can stay String for now

  PostEntity({
    required this.id,
    required this.username,
    required this.userImage,
    required this.location,
    required this.caption,
    required this.imageUrls,
    this.comments,
    required this.likes,
    required this.likedBy,
    required this.timestamp,
  });
}
