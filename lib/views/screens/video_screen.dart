import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/screens/widgets/circle_animation.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key? key}) : super(key: key);

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
      body: PageView.builder(
        itemCount: 3,
        scrollDirection: Axis.vertical,
        controller: PageController(
          initialPage: 0,
          viewportFraction: 1,
        ),
        itemBuilder: (context, int index) {
          return Stack(
            children: [
              // player video later
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
                                const Text(
                                  'Username',
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const Text(
                                  'Caption',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.music_note,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Song Name',
                                      style: TextStyle(
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
                                children: const [
                                  InkWell(
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  ),
                                  Text(
                                    '1,200 likes',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: const [
                                  InkWell(
                                    child: Icon(
                                      Icons.comment,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                  Text(
                                    '2,200 comments',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: const [
                                  InkWell(
                                    child: Icon(
                                      Icons.reply,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                  Text(
                                    '500 shares',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              CircleAnimation(
                                child: buildMusicAlbum('profileImageUrl'),
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
      ),
    );
  }
}
