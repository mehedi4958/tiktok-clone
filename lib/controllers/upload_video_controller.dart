import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/video_model.dart';
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
    Reference reference = firebaseStorage.ref('videos').child(id);
    UploadTask uploadTask = reference.putFile(await _compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String videoUrl = await snapshot.ref.getDownloadURL();
    return videoUrl;
  }

  ///
  ///
  _getThumbnail(String videoPath) async {
    final thumbnail = VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadThumbnailToStorage(String id, String videoPath) async {
    Reference reference = firebaseStorage.ref('thumbnails').child(id);
    UploadTask uploadTask = reference.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String thumbnailUrl = await snapshot.ref.getDownloadURL();
    return thumbnailUrl;
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
      String videoUrl =
          await _uploadVideoToStorage('videos $length', videoPath);
      String thumbnailUrl =
          await _uploadThumbnailToStorage('videos $length', videoPath);
      Video video = Video(
          id: 'video $length',
          uid: uid,
          userName: (userSnapshot.data() as Map<String, dynamic>)['userName'],
          profileImageUrl:
              (userSnapshot.data() as Map<String, dynamic>)['userImageUrl'],
          likes: [],
          commentCount: 0,
          shareCount: 0,
          songName: songName,
          caption: caption,
          videoUrl: videoUrl,
          thumbnailUrl: thumbnailUrl);
      await fireStore
          .collection('videos')
          .doc('videos $length')
          .set(video.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar('Error uploading video', e.toString());
    }
  }
}
