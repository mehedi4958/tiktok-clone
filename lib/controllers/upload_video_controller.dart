import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController {
  /// video compressor
  ///
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

  /// upload video to storage
  ///
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference reference = firebaseStorage.ref('videos').child('id');
    UploadTask uploadTask = reference.putFile(await _compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String videoUrl = await snapshot.ref.getDownloadURL();
    return videoUrl;
  }

  ///upload video
  ///
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
