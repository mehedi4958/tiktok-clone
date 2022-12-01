import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  Comment({
    required this.id,
    required this.uid,
    required this.userName,
    required this.comment,
    required this.datePublished,
    required this.likes,
    required this.profileImageUrl,
  });

  final String id;
  final String uid;
  final String userName;
  final String comment;
  final Timestamp datePublished;
  final List likes;
  final String profileImageUrl;

  Map<String, dynamic> toJson() => ({
        'id': id,
        'uid': uid,
        'userName': userName,
        'comment': comment,
        'datePublished': datePublished,
        'likes': likes,
        'profileImageUrl': profileImageUrl,
      });

  static Comment fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Comment(
      id: snap['id'],
      uid: snap['uid'],
      userName: snap['userName'],
      comment: snap['comment'],
      datePublished: snap['datePublished'],
      likes: snap['likes'],
      profileImageUrl: snap['profileImageUrl'],
    );
  }
}
