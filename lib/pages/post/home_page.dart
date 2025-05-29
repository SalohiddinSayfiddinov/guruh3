import 'package:flutter/material.dart';
import 'package:guruh3/provider/favourites_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavouritesProvider>().getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavouritesProvider>(
        builder: (context, provider, _) {
          if (provider.isGetting) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (provider.error != null) {
            return Center(child: Text(provider.error.toString()));
          } else {
            return ListView.builder(
              itemCount: provider.posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(provider.posts[index].title),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: Consumer<FavouritesProvider>(
        builder: (context, provider, _) {
          return FloatingActionButton(
            onPressed: () async {
              provider.createPost();
            },
            child: provider.isLoading
                ? CircularProgressIndicator.adaptive()
                : Icon(Icons.add),
          );
        },
      ),
    );
  }
}
