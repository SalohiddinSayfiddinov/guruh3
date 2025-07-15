import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/pages/profile/presentation/cubit/profile_cubit.dart';
import 'package:guruh3/pages/profile/presentation/view/edit_address_page.dart';
import 'package:guruh3/pages/profile/presentation/view/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => ProfileCubit(),
                    child: const EditProfilePage(),
                  ),
                ),
              );
            },
            leading: Icon(Icons.person),
            title: Text('Profile'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => ProfileCubit(),
                    child: const EditAddressPage(),
                  ),
                ),
              );
            },
            leading: Icon(Icons.location_disabled),
            title: Text('Address'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }
}
