import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guruh3/core/constants/app_colors.dart';
import 'package:guruh3/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:guruh3/pages/auth/presentation/view/login_page.dart';
import 'package:guruh3/pages/home/presentation/cubit/books/category_cubit.dart';
import 'package:guruh3/pages/home/presentation/cubit/vendors/vendors_categories_cubit.dart';
import 'package:guruh3/pages/home/presentation/cubit/vendors/vendors_cubit.dart';
import 'package:guruh3/pages/home/presentation/view/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await Future.delayed(Duration(seconds: 1));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => CategoryCubit()),
              BlocProvider(create: (context) => VendorsCategoriesCubit()),
              BlocProvider(create: (context) => VendorsCubit()),
            ],
            child: HomePage(),
          );
        },
      ), (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return BlocProvider(
            create: (context) => AuthCubit(),
            child: LoginPage(),
          );
        },
      ), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Center(
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.20,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 3.03,
                    horizontal: 12.62,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 12.62,
                    children: [
                      SvgPicture.asset('assets/icons/splash.svg'),
                      Text(
                        'Bazar.',
                        style: TextStyle(
                          fontSize: 31.55,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: -20,
            child: SvgPicture.asset('assets/icons/splash_big.svg'),
          )
        ],
      ),
    );
  }
}
