import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/comment_model.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comment = Rx<List<Comment>>([]);
  String _postId = '';

  updatePostId(String id) {
    _postId = id;
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userSnapshot = await fireStore
            .collection('users')
            .doc(authController.user.value!.uid)
            .get();

        var allComments = await fireStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();

        int length = allComments.docs.length;

        Comment comment = Comment(
          id: 'comment $length',
          uid: (userSnapshot.data()! as dynamic)['uid'],
          userName: (userSnapshot.data()! as dynamic)['userName'],
          comment: commentText,
          datePublished: Timestamp.now(),
          likes: [],
          profileImageUrl: (userSnapshot.data()! as dynamic)['userImageUrl'],
        );

        await fireStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('comment $length')
            .set(comment.toJson());
      }
    } catch (e) {
      Get.snackbar('Error Commenting', e.toString());
    }
  }
}
