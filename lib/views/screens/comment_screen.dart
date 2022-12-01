import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/comment_controller.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  final TextEditingController _commentController = TextEditingController();
  final CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: NetworkImage('profileImageUrl'),
                        ),
                        title: Row(
                          children: [
                            Text(
                              'username',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'comment',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              'Date',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '10 Likes',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      );
                    });
                  },
                ),
              ),
              Divider(
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
                  onPressed: () =>
                      commentController.postComment(_commentController.text),
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
