import 'package:flutter/material.dart';
import 'package:guruh3/models/user.dart';
import 'package:guruh3/repositories/user_repo.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isLoading = false;
  bool isUpdating = false;
  bool isDeleting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: FutureBuilder(
        future: UserRepo().getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return ListTile(
                  title: Text(user.name),
                  trailing: Row(
                    spacing: 10,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content:
                                    FloatingActionButton(onPressed: () async {
                                  setState(() {
                                    isUpdating = true;
                                  });
                                  try {
                                    final updatedUser = User(
                                      id: user.id,
                                      name: "new user",
                                      avatar: user.avatar,
                                      createdAt: user.createdAt,
                                    );
                                    await UserRepo().updateUser(updatedUser);
                                  } catch (e) {
                                    print('Xato bo`ldi $e');
                                  } finally {
                                    setState(() {
                                      isUpdating = false;
                                    });
                                  }
                                }),
                              );
                            },
                          );
                        },
                        icon: isUpdating
                            ? CircularProgressIndicator.adaptive()
                            : Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            isDeleting = true;
                          });
                          try {
                            await UserRepo().deleteUser(user.id);
                          } catch (e) {
                            print('Xato bo`ldi $e');
                          } finally {
                            setState(() {
                              isDeleting = false;
                            });
                          }
                        },
                        icon: isDeleting
                            ? CircularProgressIndicator.adaptive()
                            : Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          try {
            final user = User(
              id: '1',
              name: "Mike Tyson",
              avatar:
                  "https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/9.jpg",
              createdAt: 'createdAt',
            );
            await UserRepo().createUser(user);
          } catch (e) {
            print('Xato bo`ldi $e');
          } finally {
            setState(() {
              isLoading = false;
            });
          }
        },
        child:
            isLoading ? CircularProgressIndicator.adaptive() : Icon(Icons.add),
      ),
    );
  }
}
