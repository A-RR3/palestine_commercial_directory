import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:palestine_commercial_directory/core/presentation/palette.dart';
import 'package:palestine_commercial_directory/core/utils/extensions.dart';
import 'package:palestine_commercial_directory/core/values/asset_keys.dart';
import 'package:palestine_commercial_directory/core/values/constants.dart';
import 'package:palestine_commercial_directory/modules/home/home_screen.dart';

import '../../core/presentation/fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 4), () async {
      await Navigator.pushReplacement(
        context,
        PageTransition(
            child: HomeScreen(),
            type: PageTransitionType.fade,
            duration: const Duration(seconds: 1)),
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: Palette.gradientColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: context.deviceSize.height * .17,
              width: context.deviceSize.width * .5,
              child: Image.asset(
                AssetsKeys.getImagePath(AssetsKeys.SPLASH_SCREEN_IMG),
                fit: BoxFit.fill,
              ),
            ).animate().slideY(
                begin: -.5, end: 0, duration: const Duration(seconds: 2)),
            const Text(splashScreenHeading,
                    style: TextStyle(
                        fontSize: 45,
                        fontFamily: Fonts.lobster,
                        fontWeight: FontWeight.w600,
                        color: Palette.darkThemeText))
                .animate()
                .fade(begin: .1, end: .8, duration: const Duration(seconds: 2)),
          ],
        ),
      ),
    );
  }
}
