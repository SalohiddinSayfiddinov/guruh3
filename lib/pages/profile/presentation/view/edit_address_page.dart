import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/pages/profile/presentation/cubit/profile_cubit.dart';
import 'package:guruh3/pages/profile/presentation/cubit/profile_state.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({super.key});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final _latController = TextEditingController();
  final _longController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _latController.dispose();
    _longController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Address')),
      body: Column(
        children: [
          TextFormField(
            controller: _latController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
            ),
          ),
          TextFormField(
            controller: _longController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.data)),
            );
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
                    double? lat = double.tryParse(_latController.text);
                    double? long = double.tryParse(_longController.text);
                    if (lat == null || long == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid coordinates')),
                      );
                      return;
                    }
                    final profileCubit = context.read<ProfileCubit>();
                    profileCubit.updateProfile(lat: lat, long: long);
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
