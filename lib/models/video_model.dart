class Video {
  Video({
    required this.id,
    required this.uid,
    required this.userName,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.profileImageUrl,
  });

  final String id;
  final String uid;
  final String userName;
  final String likes;
  final int commentCount;
  final int shareCount;
  final String songName;
  final String caption;
  final String videoUrl;
  final String thumbnailUrl;
  final String profileImageUrl;
}
