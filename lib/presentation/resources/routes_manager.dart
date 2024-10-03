import 'package:flutter/material.dart';
import 'package:zuuro/presentation/view/auth/Forgot/forgot.dart';
import 'package:zuuro/presentation/view/auth/login/login.dart';
import 'package:zuuro/presentation/view/auth/register/register.dart';
import 'package:zuuro/presentation/view/settings/change_password/change_password.dart';
import 'package:zuuro/presentation/view/settings/change_pin/change_pin.dart';
import 'package:zuuro/presentation/view/splash/splash.dart';
import 'package:zuuro/presentation/view/vtu/airtime/airtime.dart';
import 'package:zuuro/presentation/view/vtu/bet/bet.dart';
import 'package:zuuro/presentation/view/vtu/data/data.dart';
import 'package:zuuro/presentation/view/vtu/elect/elect.dart';

import '../view/auth/bvn_verification/bvn_verification.dart';
import '../view/dashboard/dashboard.dart';
import '../view/history/transaction_details.dart';
import '../view/money/card/card_funding.dart';
import '../view/money/money.dart';
import '../view/money/transfer/transfer.dart';
import '../view/onboarding/onboarding.dart';
import '../view/settings/personal_info/personal_info.dart';
import '../view/settings/t_and_c/t_and_c.dart';
import '../view/vtu/success/success.dart';
import 'resources.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String bvnRoute = "/bvn";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String airtimeRoute = "/Airtime";
  static const String dataRoute = "/Data";
  static const String betRoute = "/Betting";
  static const String electRoute = "/Electricity";
  static const String success = "/Success";
  static const String addMoney = "/add-money";
  static const String bank = "/bank-transfer";
  static const String transactionDetail = "/transaction-details";
  static const String changePassword = "/change-password";
  static const String changePin = "/change-pin";
  static const String personalInfo = "/personal-information";
  static const String bankTransfer = "/bank-transfer";
  static const String cardFunding = "/card-funding";
  static const String terms = "/terms-and-condition";
  static const String profile = "/${AppStrings.profile}";

}


class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => Login());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.registerRoute:
      final String args = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) => Register( from: args,));
      case Routes.bvnRoute:
      final String args = routeSettings.arguments as String;
        return MaterialPageRoute(builder: (_) => BvnScreen(from: args,));
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const Dashboard());
      case Routes.transactionDetail:
        return MaterialPageRoute(builder: (_) => const TransactionDetails());
      case Routes.airtimeRoute:
        return MaterialPageRoute(builder: (_) => const Airtime());
      case Routes.dataRoute:
        return MaterialPageRoute(builder: (_) => const Data());
      case Routes.betRoute:
        return MaterialPageRoute(builder: (_) => const Bet());
      case Routes.electRoute:
        return MaterialPageRoute(builder: (_) => const Bill());
      case Routes.success:
        return MaterialPageRoute(builder: (_) => const SuccessScreen());
      case Routes.addMoney:
        return MaterialPageRoute(builder: (_) => const AddMoney());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => Container());
      case Routes.changePassword:
        return MaterialPageRoute(builder: (_) => ChangePassword());
      case Routes.changePin:
        return MaterialPageRoute(builder: (_) => const ChangePin());
      case Routes.personalInfo:
        return MaterialPageRoute(builder: (_) => const PersonalInfo());
      case Routes.bankTransfer:
        return MaterialPageRoute(builder: (_) => const BankTransfer());
      case Routes.cardFunding:
        return MaterialPageRoute(builder: (_) => const CardFunding());
      case Routes.terms:
        return MaterialPageRoute(builder: (_) => const TAndC());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }
}
