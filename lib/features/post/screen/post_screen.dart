import 'package:flutter/material.dart';
import 'package:guruh3/features/post/model/post_model.dart';
import 'package:guruh3/features/post/provider/post_provider.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (provider.error != null) {
            return Center(child: Text("ERROR: ${provider.error.toString()}"));
          } else if (provider.posts != null) {
            return ListView.builder(
              itemCount: provider.posts!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(provider.posts![index].title),
                    trailing: Consumer<PostProvider>(
                      builder: (context, provider, child) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await context.read<PostProvider>().updatePost(
                                  Post(
                                    userId: 1,
                                    id: provider.posts![index].id,
                                    title: 'title',
                                    body: 'body',
                                  ),
                                );
                                if (provider.updateError != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(provider.updateError!),
                                    ),
                                  );
                                } else if (provider.isUpdated == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Yangilandi")),
                                  );
                                }
                              },
                              icon:
                                  provider.updatingId ==
                                      provider.posts![index].id
                                  ? CircularProgressIndicator.adaptive()
                                  : Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                await context.read<PostProvider>().deletePost(
                                  provider.posts![index].id,
                                );
                                if (provider.deleteError != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(provider.deleteError!),
                                    ),
                                  );
                                } else if (provider.isDeleted == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("O'chirildi")),
                                  );
                                }
                              },
                              icon:
                                  provider.deletingId ==
                                      provider.posts![index].id
                                  ? CircularProgressIndicator.adaptive()
                                  : Icon(Icons.delete),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: Text("Else"));
        },
      ),
      floatingActionButton: Consumer<PostProvider>(
        builder: (context, provider, child) {
          return FloatingActionButton(
            onPressed: () async {
              await context.read<PostProvider>().updatePost(
                Post(userId: 1, id: 1, title: 'title', body: 'body'),
              );
              if (provider.updateError != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(provider.updateError!)));
              } else if (provider.isUpdated == true) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Yangilandi")));
              }
            },
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}
