import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tiktok_clone/constants.dart';

class UploadVideoController {
  /// upload video to storage
  _uploadVideoToStorage(String id, String videoPath) {
    Reference reference = firebaseStorage.ref('videos').child('id');
    reference.putFile(videoPath);
  }

  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userSnapshot =
          await fireStore.collection('users').doc(uid).get();
      var videoDocs = await fireStore.collection('videos').get();
      int length = videoDocs.docs.length;
      _uploadVideoToStorage('videos $length', videoPath);
    } catch (e) {}
  }
}
