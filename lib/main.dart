import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guruh3/models/post.dart';
import 'package:guruh3/pages/post/home_page.dart';
import 'package:guruh3/provider/bottom_nav_bar_provider.dart';
import 'package:guruh3/provider/counter_provider.dart';
import 'package:guruh3/provider/favourites_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  await Hive.openBox('postBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavBarProvider()),
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => FavouritesProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: GoogleFonts.acme().fontFamily,
        ),
        home: HomePage(),
      ),
    );
  }
}
