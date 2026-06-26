import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/features/users/presentation/cubit/user_cubit.dart';
import 'package:guruh3/features/users/presentation/cubit/user_state.dart';
import 'package:guruh3/features/users/presentation/screens/create_user_screen.dart';
import 'package:guruh3/features/users/presentation/widgets/delete_user_dialog.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state.isLoading && state.users.isEmpty) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state.error != null && state.users.isEmpty) {
            return Center(child: Text("ERROR: ${state.error.toString()}"));
          } else if (state.users.isEmpty) {
            return Center(child: Text("No data"));
          }
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(state.users[index].name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      IconButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return BlocProvider.value(
                                value: context.read<UserCubit>(),
                                child: DeleteUserDialog(
                                  user: state.users[index],
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return BlocProvider.value(
                  value: context.read<UserCubit>(),
                  child: CreateUserScreen(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
