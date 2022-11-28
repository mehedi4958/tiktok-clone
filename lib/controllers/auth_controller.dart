import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';

class AuthController extends GetxController {
  /// user image upload

  Future<String> _uploadImageToStorage(File image) async {
    Reference reference = firebaseStorage
        .ref()
        .child('profileImages')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  /// user registration

  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        String imageUrl = await _uploadImageToStorage(image);
      }
    } catch (e) {
      Get.snackbar(
        'Error creating Account!',
        e.toString(),
      );
    }
  }
}
