import 'package:flutter/material.dart';
import 'package:guruh3/features/post/provider/post_provider.dart';
import 'package:guruh3/features/post/screen/post_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: ChangeNotifierProvider(
        create: (context) => PostProvider(),
        child: PostScreen(),
      ),
    );
  }
}
