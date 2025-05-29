import 'package:flutter/material.dart';
import 'package:guruh3/models/post.dart';

class PostInfoPage extends StatelessWidget {
  final Post post;
  const PostInfoPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.id.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              post.title.toString(),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              post.body,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text('By: ${post.userId}'),
            ),
          ],
        ),
      ),
    );
  }
}
