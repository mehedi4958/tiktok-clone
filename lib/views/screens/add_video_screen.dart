import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    pickVideo(ImageSource src, BuildContext context) async {
      final video = await ImagePicker().pickVideo(source: src);
      if (video != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmScreen(
              videoFile: File(video.path),
              videoPath: video.path,
            ),
          ),
        );
      }
    }

    showDialogOption(BuildContext context) {
      return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () => pickVideo(ImageSource.gallery, context),
              child: Row(
                children: const [
                  Icon(Icons.image),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () => pickVideo(ImageSource.camera, context),
              child: Row(
                children: const [
                  Icon(Icons.camera_alt_outlined),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Camera',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {},
              child: Row(
                children: const [
                  Icon(Icons.cancel),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showDialogOption(context),
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,
            ),
            child: const Center(
              child: Text(
                'Add Video',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
