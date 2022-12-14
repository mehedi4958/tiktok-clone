import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/upload_video_controller.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  final File videoFile;
  final String videoPath;

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final UploadVideoController _uploadVideoController =
      Get.put(UploadVideoController());
  final TextEditingController _songNameController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    setState(() {
      _videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    _videoPlayerController.initialize();
    _videoPlayerController.play();
    _videoPlayerController.setVolume(1);
    _videoPlayerController.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(_videoPlayerController),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _songNameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.music_note,
                ),
                hintText: 'Song Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _captionController,
              decoration: const InputDecoration(
                prefixIcon: Icon(CupertinoIcons.captions_bubble),
                hintText: 'Caption',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
              ),
              onPressed: () {
                _uploadVideoController.uploadVideo(
                  _songNameController.text,
                  _captionController.text,
                  widget.videoPath,
                );
              },
              child: const Text('Share'),
            ),
          ],
        ),
      ),
    );
  }
}
