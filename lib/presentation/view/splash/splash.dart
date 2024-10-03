import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/animation/navigator.dart';
import '../../../app/animation/slidein_animation.dart';
import '../../../app/cache/orage_cred.dart';
import '../../../app/locator.dart';
import '../../resources/resources.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _storageServices = getIt<StorageCredentials>();
  String? splashStatusBool;

  Future<dynamic> waiting(Function() action) {
    Future<dynamic> navigateAfterFuture =
        Future.delayed(const Duration(milliseconds: 4000), action);
    return navigateAfterFuture;
  }

  Future<void> checkStatus() async {
    splashStatusBool = await _storageServices.onBoardingCredentailStatus;
  }

  @override
  void initState() {
    super.initState();
    runInit();
  }

  void runInit() async {
    await checkStatus();
    if (splashStatusBool == "used") {
      waiting(
        () {
          NavigateClass().pushNamed(
            context: context,
            routName: Routes.mainRoute,
          );
        },
      );
    } else if (splashStatusBool == "NO SESSION") {
      waiting(
        () {
          NavigateClass().pushNamed(
            context: context,
            args: "number",
            routName: Routes.onBoardingRoute,
          );
        },
      );
    } else if (splashStatusBool == "number") {
      NavigateClass().pushNamed(
        context: context,
        args: "info",
        routName: Routes.registerRoute,
      );
    } else if (splashStatusBool == "info") {
      NavigateClass().pushNamed(
        context: context,
        args: "password",
        routName: Routes.registerRoute,
      );
    } 
    else if (splashStatusBool == "password") {
      NavigateClass().pushNamed(
        context: context,
        args: "pin",
        routName: Routes.registerRoute,
      );
    } 
    else if (splashStatusBool == "pin") {
      NavigateClass().pushNamed(
        context: context,
        routName: Routes.loginRoute,
      );
    } else {
      NavigateClass().pushNamed(
        context: context,
        routName: Routes.loginRoute,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: deviceHeight(context),
        width: deviceWidth(context),
        decoration: BoxDecoration(
          gradient: ColorManager.splashGradient,
        ),
        child: Container(
          height: 500,
          width: deviceWidth(context),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageAssets.splashBg), fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScaleOut(
                animationChild: [
                  Hero(
                    tag: "logo",
                    child: Center(
                      child: Image.asset(
                        ImageAssets.splashLogo,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
