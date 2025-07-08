import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guruh3/core/constants/app_colors.dart';
import 'package:guruh3/core/widgets/app_buttons.dart';
import 'package:guruh3/pages/onboarding/cubit/onboarding_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController controller = PageController();
  List<_Details> details = [
    _Details(
      image: Colors.amber,
      title: 'Now reading books will be easier',
      description:
          'Discover new worlds, join a vibrant reading community. Start your reading adventure effortlessly with us.',
    ),
    _Details(
      image: Colors.blue,
      title: 'Your Bookish Soulmate Awaits',
      description:
          'Let us be your guide to the perfect read. Discover books tailored to your tastes for a truly rewarding experience.',
    ),
    _Details(
      image: Colors.green,
      title: 'Start Your Adventure',
      description:
          'Ready to embark on a quest for inspiration and knowledge? Your adventure begins now. Let\'s go!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final int lastPage = details.length - 1;
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<OnboardingCubit, int>(builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 13.0),
                child: TextButton(
                  onPressed: () {
                    if (state != lastPage) {
                      controller.animateToPage(
                        lastPage,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                  ),
                  child: Text('Skip'),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: details.length,
                  onPageChanged: (value) {
                    context.read<OnboardingCubit>().changePage(value);
                  },
                  itemBuilder: (context, index) {
                    final detail = details[index];
                    return Column(
                      children: [
                        Container(
                          width: 320,
                          height: 320,
                          color: detail.image,
                        ),
                        SizedBox(height: 14.0),
                        SizedBox(
                          width: 243,
                          child: Text(
                            detail.title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        SizedBox(
                          width: 292,
                          child: Text(
                            detail.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.grey500,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: details.length,
                    effect: JumpingDotEffect(
                      dotHeight: 8.0,
                      dotWidth: 8.0,
                      jumpScale: .7,
                      verticalOffset: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              PrimaryButton(
                text: state < lastPage ? 'Continue' : 'Get Started',
                onPressed: () {
                  if (state < lastPage) {
                    controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  } else {
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => BlocProvider(
                    //       create: (context) => CounterCubit(),
                    //       child: HomePage(),
                    //     ),
                    //   ),
                    //   (route) => false,
                    // );
                  }
                },
              ),
              SizedBox(height: 8.0),
              PrimaryButton(
                text: 'Sign In',
                onPressed: () {},
                isPrimary: false,
              ),
              SizedBox(height: 16.0),
            ],
          );
        }),
      ),
    );
  }
}

class _Details {
  final Color image;
  final String title;
  final String description;

  const _Details({
    required this.image,
    required this.title,
    required this.description,
  });
}
