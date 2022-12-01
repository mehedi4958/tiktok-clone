import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/video_controller.dart';
import 'package:tiktok_clone/views/screens/widgets/circle_animation.dart';
import 'package:tiktok_clone/views/screens/widgets/video_player_item.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({Key? key}) : super(key: key);

  final VideoController _videoController = Get.put(VideoController());

  buildMusicAlbum(String profileImageUrl) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.grey,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                profileImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
          itemCount: _videoController.videoList.length,
          scrollDirection: Axis.vertical,
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
          ),
          itemBuilder: (context, int index) {
            final data = _videoController.videoList[index];
            return Stack(
              children: [
                VideoPlayerItem(
                  videoUrl: data.videoUrl,
                ),
                Column(
                  children: [
                    const SizedBox(height: 100),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    data.userName,
                                    style: const TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    data.caption,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.music_note,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        data.songName,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey,
                                ),
                                Column(
                                  children: [
                                    const InkWell(
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),
                                    Text(
                                      data.likes.length.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    const InkWell(
                                      child: Icon(
                                        Icons.comment,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                    Text(
                                      data.commentCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    const InkWell(
                                      child: Icon(
                                        Icons.reply,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                    Text(
                                      data.shareCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                CircleAnimation(
                                  child: buildMusicAlbum(data.profileImageUrl),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
