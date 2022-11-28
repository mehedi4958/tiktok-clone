import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({
    required this.uid,
    required this.email,
    required this.userName,
    required this.userImageUrl,
  });

  final String uid;
  final String email;
  final String userName;
  final String userImageUrl;

  Map<String, dynamic> toJson() => ({
        'uid': uid,
        'email': email,
        'userName': userName,
        'userImageUrl': userImageUrl,
      });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data as Map<String, dynamic>;
    return User(
      uid: snapshot['uid'],
      email: snapshot['email'],
      userName: snapshot['userName'],
      userImageUrl: snapshot['userImageUrl'],
    );
  }
}
