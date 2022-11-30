import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  Video({
    required this.id,
    required this.uid,
    required this.userName,
    required this.profileImageUrl,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  String id;
  String uid;
  String userName;
  String profileImageUrl;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnailUrl;

  Map<String, dynamic> toJson() => ({
        'id': id,
        'uid': uid,
        'userName': userName,
        'profileImageUrl': profileImageUrl,
        'likes': likes,
        'commentCount': commentCount,
        'shareCount': shareCount,
        'songName': songName,
        'caption': caption,
        'videoUrl': videoUrl,
        'thumbnailUrl': thumbnailUrl,
      });

  static Video fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Video(
      id: snap['id'],
      uid: snap['uid'],
      userName: snap['userName'],
      profileImageUrl: snap['profileImageUrl'],
      likes: snap['likes'],
      commentCount: snap['commentCount'],
      shareCount: snap['shareCount'],
      songName: snap['songName'],
      caption: snap['caption'],
      videoUrl: snap['videoUrl'],
      thumbnailUrl: snap['thumbnailUrl'],
    );
  }
}
