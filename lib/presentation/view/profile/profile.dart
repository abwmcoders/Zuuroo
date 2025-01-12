import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zuuro/app/cache/storage.dart';
import 'package:zuuro/app/services/api_rep/user_services.dart';
import 'package:zuuro/presentation/resources/resources.dart';
import 'package:zuuro/presentation/resources/ui_helper.dart';

import '../../../app/animation/navigator.dart';
import '../../../app/app_constants.dart';
import '../../../app/functions.dart';
import '../../../app/locator.dart';
import 'model/logout_model.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  String generatePaystackReferenceWithTimestamp() {
    DateTime now = DateTime.now();
    return 'TX_${now.millisecondsSinceEpoch}';
  }

  Future<void> initialize(BuildContext ctx) async {
    try {
      var response = await UserApiServices().initializePayment({});
      if (response["status"] == "success") {
        String paymentUrl = response['payment_url'];
        String reference = response['reference'];

        // Proceed to open Paystack WebView
        PayWithPayStack().now(
            callbackUrl: paymentUrl,
            context: ctx,
            secretKey: "sk_live_7570700bb6e02b66cb43cc0040b5dcb9fc72985d",//"sk_test_52fdad00c5f938381b29d16a6e4c516bea328ff5",
            customerEmail: AppConstants.homeModel!.data.user.email,
            reference: "${reference + generatePaystackReferenceWithTimestamp()}",
            currency: "NGN",
            amount: 50,
            transactionCompleted: (_) {
              MekNotification().showMessage(
                ctx,
                color: ColorManager.activeColor,
                message: "Bank card added successful",
              );
            },
            transactionNotCompleted: (_) {
              MekNotification().showMessage(
                ctx,
                message: "Unable to add bank card !!!",
              );
            });
      } else {
        MekNotification().showMessage(
          ctx,
          message: "An error occurred, Please check your internet connection",
        );
        print('Error: ${response.body}');
      }
    } catch (e) {
      MekNotification().showMessage(
        ctx,
        message: "An error occurred, Please try again later",
      );
      print('Exception: $e');
    }
  }
  
  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $Uri.parse(url)';
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: deviceHeight(context),
          width: deviceWidth(context),
          decoration: BoxDecoration(
            gradient: ColorManager.buttonFadeGradient,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 5,
                left: 15,
                child: Row(
                  children: [
                    Container(
                      height: screenAwareSize(100, context),
                      width: screenAwareSize(100, context),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: ColorManager.buttonGradient
                          //color: ColorManager.primaryColor,
                          ),
                      child: Center(
                        child: Text(
                          AppConstants.homeModel != null
                              ? AppConstants.homeModel!.data.user.username
                                  .substring(0, 2)
                                  .toUpperCase()
                              : "",
                          style: getBoldStyle(
                            color: ColorManager.whiteColor,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConstants.homeModel != null
                              ? "Hello ${AppConstants.homeModel!.data.user.username}!"
                              : "Hello !",
                          style: getBoldStyle(color: ColorManager.blackColor)
                              .copyWith(fontSize: 18),
                        ),
                        Text(
                          "Active Account",
                          style: getBoldStyle(color: ColorManager.activeColor)
                              .copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: deviceHeight(context) * .72,
                  decoration: BoxDecoration(
                    color: ColorManager.scaffoldBg,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: ListView(
                      children: [
                        ProfileCategoryWidget(
                          title: "Account",
                          content: Column(
                            children: [
                              ProfileTile(
                                title: "Personal Information",
                                subTitle: "See your account login details",
                                icon: Icons.person,
                                onPressed: () {
                                  NavigateClass().pushNamed(
                                    context: context,
                                    routName: Routes.personalInfo,
                                  );
                                },
                              ),
                              ProfileTile(
                                title: "Bank Card/Account",
                                subTitle: "1 linked card/account",
                                icon: Icons.group,
                                onPressed: () {
                                  initialize(context);
                                },
                                isLast: true,
                              ),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpaceMedium,
                        ProfileCategoryWidget(
                          title: "Security",
                          content: Column(
                            children: [
                              ProfileTile(
                                title: "Change Password",
                                subTitle:
                                    "Make changes to your password, If you feel insecure",
                                icon: Icons.lock,
                                onPressed: () {
                                  NavigateClass().pushNamed(
                                    context: context,
                                    routName: Routes.changePassword,
                                  );
                                },
                              ),
                              ProfileTile(
                                title: "KYC",
                                subTitle: "Please verify your identity.",
                                icon: Icons.security,
                                onPressed: () {
                                  NavigateClass().pushNamed(
                                    context: context,
                                    routName: Routes.kyc,
                                  );
                                },
                              ),
                              ProfileTile(
                                title: "Pin Management",
                                subTitle: "Make changes to your pin.",
                                icon: Icons.lock_outline,
                                isLast: true,
                                onPressed: () {
                                  NavigateClass().pushNamed(
                                    context: context,
                                    routName: Routes.requestPinChange,
                                  );
                                },
                              ),
                              // ProfileTile(
                              //   title: "Enable Face ID",
                              //   subTitle:
                              //       "Use FaceId instead of password to unlock the app.",
                              //   icon: Icons.face,
                              //   fingerPrint: CupertinoSwitch(
                              //     value: switchValue,
                              //     activeColor: ColorManager.primaryDeep,
                              //     onChanged: (value) {
                              //       setState(() {
                              //         switchValue = value;
                              //       });
                              //     },
                              //   ),
                              //   onPressed: () {
                              //     //!TODO: ADD FINGERPRINT
                              //   },
                              //   isLast: true,
                              // ),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpaceMedium,
                        ProfileCategoryWidget(
                          title: "Services",
                          content: Column(
                            children: [
                              ProfileTile(
                                title: "About Us",
                                subTitle: "Learn more about us.",
                                icon: Icons.source,
                                onPressed: () {
                                  NavigateClass().pushNamed(
                                    context: context,
                                    routName: Routes.about,
                                  );
                                },
                              ),
                              ProfileTile(
                                title: "Help and Support",
                                subTitle:
                                    "Feel free to reach out for any concerns.",
                                icon: Icons.help,
                                onPressed: () {
                                  NavigateClass().pushNamed(
                                    context: context,
                                    routName: Routes.support,
                                  );
                                },
                              ),
                              ProfileTile(
                                title: "Visit Website",
                                subTitle: "See our website.",
                                icon: Icons.web,
                                onPressed: () {
                                    _launchUrl("https://www.zuuroo.com/");
                                  // NavigateClass().pushNamed(
                                  //   context: context,
                                  //   routName: Routes.website,
                                  // );
                                },
                              ),
                              ProfileTile(
                                title: "Terms and conditions",
                                subTitle: "see terms and conditions.",
                                icon: Icons.person_2_rounded,
                                onPressed: () {
                                  NavigateClass().pushNamed(
                                    context: context,
                                    routName: Routes.terms,
                                  );
                                },
                              ),
                              ProfileTile(
                                title: "Sign Out",
                                subTitle: "See our website.",
                                icon: Icons.logout_sharp,
                                onPressed: () {
                                  UserApiServices().logout().then(
                                    (logout) {
                                      LogoutResponse logoutResponse =
                                          LogoutResponse.fromJson(logout);
                                      if (logoutResponse.message ==
                                          "Logged out successfully") {
                                        final storageService =
                                            getIt<MekStorage>();
                                        storageService.clear();
                                        NavigateClass().pushReplacementNamed(
                                          context: context,
                                          routName: Routes.loginRoute,
                                        );
                                      } else {
                                        MekNotification().showMessage(
                                          context,
                                          message: logoutResponse.message,
                                        );
                                      }
                                    },
                                  );
                                },
                                isLast: true,
                                isSignout: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCategoryWidget extends StatelessWidget {
  const ProfileCategoryWidget({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: getRegularStyle(color: ColorManager.deepGreyColor),
        ),
        UIHelper.verticalSpaceSmall,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: ColorManager.greyColor,
              )),
          child: content,
        )
      ],
    );
  }
}

class ProfileTile extends StatelessWidget {
  ProfileTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.fingerPrint,
    this.isLast = false,
    this.isSignout = false,
    required this.onPressed,
  });

  final String title, subTitle;
  final IconData icon;
  Widget? fingerPrint;
  final bool isLast, isSignout;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isSignout
            ? InkWell(
              onTap: onPressed,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                  child: Row(
                    children: [
                      Container(
                        height: screenAwareSize(50, context),
                        width: screenAwareSize(50, context),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.primaryColor.withOpacity(.4),
                        ),
                        child: Icon(
                          icon,
                          size: 18,
                          color: ColorManager.primaryColor,
                        ),
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Text(
                        title,
                        style: getBoldStyle(color: ColorManager.primaryColor)
                            .copyWith(fontSize: 14),
                      ),
                     
                    ],
                  ),
                ),
            )
            : ListTile(
                leading: Container(
                  height: screenAwareSize(50, context),
                  width: screenAwareSize(50, context),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.primaryColor.withOpacity(.2),
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: ColorManager.primaryColor,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: getBoldStyle(color: ColorManager.blackColor)
                          .copyWith(fontSize: 14),
                    ),
                    Text(
                      subTitle,
                      //overflow: TextOverflow.ellipsis,
                      style: getRegularStyle(color: ColorManager.deepGreyColor)
                          .copyWith(fontSize: 12),
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: onPressed,
                  icon: fingerPrint ??
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                      ),
                ),
              ),

        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Row(
        //         children: [
        //           Container(
        //             height: screenAwareSize(50, context),
        //             width: screenAwareSize(50, context),
        //             decoration: BoxDecoration(
        //               shape: BoxShape.circle,
        //               color: ColorManager.primaryLight.withOpacity(.4),
        //             ),
        //             child: Icon(
        //               icon,
        //               color: ColorManager.primary,
        //             ),
        //           ),
        //           UIHelper.horizontalSpaceMedium,
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               Text(
        //                 title,
        //                 style: getBoldStyle(color: ColorManager.black)
        //                     .copyWith(fontSize: 16),
        //               ),
        //               Text(
        //                 subTitle,
        //                 overflow: TextOverflow.ellipsis,
        //                 style: getRegularStyle(color: ColorManager.grey)
        //                     .copyWith(fontSize: 12),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //       IconButton(
        //           onPressed: onPressed,
        //           icon: Icon(
        //             Icons.arrow_forward_ios,
        //             size: 15,
        //           ),
        //           ),
        //     ],
        //   ),
        // ),

        isLast
            ? Container()
            : Divider(
                color: ColorManager.greyColor,
                thickness: 1,
              ),
      ],
    );
  }
}
