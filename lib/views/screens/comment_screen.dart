import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as time_ago;

class CommentScreen extends StatelessWidget {
  CommentScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  final TextEditingController _commentController = TextEditingController();
  final CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(id);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text('Comments'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () {
                    return ListView.builder(
                      itemCount: commentController.commentList.length,
                      itemBuilder: (context, index) {
                        final comments = commentController.commentList[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage:
                                NetworkImage(comments.profileImageUrl),
                          ),
                          title: Row(
                            children: [
                              Text(
                                comments.userName,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                comments.comment,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 16),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                '${time_ago.format(comments.datePublished.toDate())},',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '${comments.likes.length} Likes',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () =>
                                commentController.likeComment(comments.id),
                            child: Icon(
                              Icons.favorite,
                              color: comments.likes
                                      .contains(authController.user!.uid)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1.5,
              ),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    commentController.postComment(_commentController.text);
                    _commentController.clear();
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
