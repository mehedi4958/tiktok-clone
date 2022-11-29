import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    showDialogOption(BuildContext context) {
      return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () {},
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
              onPressed: () {},
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
