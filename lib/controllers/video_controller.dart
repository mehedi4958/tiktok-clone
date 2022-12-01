import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/video_model.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    _videoList.bindStream(
      fireStore.collection('videos').snapshots().map(
        (QuerySnapshot querySnapshot) {
          List<Video> retVal = [];
          for (var element in querySnapshot.docs) {
            retVal.add(
              Video.fromSnap(element),
            );
          }
          return retVal;
        },
      ),
    );
    super.onInit();
  }
}
