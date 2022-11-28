import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user_model.dart' as model;
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  /// pick image from gallery

  late Rx<File?> _pickedImage;

  void pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      Get.snackbar('Profile Photo', 'Image picked from the gallery');
    }

    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  File? get getUserImage => _pickedImage.value;

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
      String userName, String email, String password, File? image) async {
    try {
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        String userImageUrl = await _uploadImageToStorage(image);
        model.User user = model.User(
            uid: userCredential.user!.uid,
            email: email,
            userName: userName,
            userImageUrl: userImageUrl);
        await fireStore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Error creating Account!', 'All fields must be filled');
      }
    } catch (e) {
      Get.snackbar(
        'Error creating Account!',
        e.toString(),
      );
    }
  }

  /// user login

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        Get.off(const HomeScreen());
      } else {
        Get.snackbar('Error logging in!', 'All fields must be filled');
      }
    } catch (e) {
      Get.snackbar('Error logging in!', e.toString());
    }
  }

  /// persisting user

  late Rx<User?> _user;

  @override
  void onReady() {
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialState);
    super.onReady();
  }

  _setInitialState(User? user) {
    if (user == null) {
      Get.offAll(const LoginScreen());
    } else {
      Get.offAll(const HomeScreen());
    }
  }
}
