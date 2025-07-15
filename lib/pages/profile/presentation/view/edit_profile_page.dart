import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/pages/profile/presentation/cubit/profile_cubit.dart';
import 'package:guruh3/pages/profile/presentation/cubit/profile_state.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  XFile? userImage;
  void selectUserImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        userImage = pickedFile;
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit')),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: userImage != null
                  ? FileImage(File(userImage!.path))
                  : AssetImage('assets/images/rasm.jpeg'),
            ),
            TextButton(
              onPressed: () {
                selectUserImage();
              },
              child: Text('Change photo'),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.data)),
            );
            // Navigator.pop(context);
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: state is ProfileLoading
                ? null
                : () {
                    if (userImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select an image')),
                      );
                      return;
                    }

                    final profileCubit = context.read<ProfileCubit>();
                    profileCubit.updateProfile(image: userImage!.path);
                  },
            child: state is ProfileLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Icon(Icons.save),
          );
        },
      ),
    );
  }
}
