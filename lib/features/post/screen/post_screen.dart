import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/features/post/cubit/post_cubit.dart';
import 'package:guruh3/features/post/cubit/post_state.dart';
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
    context.read<PostCubit>().getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state.error != null) {
            return Center(child: Text("ERROR: ${state.error.toString()}"));
          } else if (state.posts.isEmpty) {
            return Center(child: Text("No data"));
          } else {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(title: Text(state.posts[index].title)),
                );
              },
            );
          }
        },
      ),
    );
  }
}
