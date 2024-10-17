import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zuuro/app/base/base_screen.dart';

import '../../../../app/animation/navigator.dart';
import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../../onboarding/onboarding.dart';
import 'provider/forgot_pass_provider.dart';

// class ForgotPassword extends StatefulWidget {
//   const ForgotPassword({super.key});

//   @override
//   State<ForgotPassword> createState() => _ForgotPasswordState();
// }

// class _ForgotPasswordState extends State<ForgotPassword> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   late PageController _pageController;
//   int pageIndex = 0;

//   @override
//   void initState() {
//     _pageController = PageController(initialPage: 0);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ...List.generate(
//                             registrationForms.length,
//                             (index) => Padding(
//                               padding: const EdgeInsets.only(
//                                 right: 4.0,
//                               ),
//                               child: DotIndicatorWidget(
//                                 isActive: index == pageIndex,
//                                 isReg: true,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       UIHelper.verticalSpaceSmall,
//                       Row(
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             icon: Icon(
//                               Icons.arrow_back,
//                             ),
//                           ),
//                           UIHelper.horizontalSpaceMedium,
//                           GradientText(
//                             gradient: LinearGradient(
//                               colors: [
//                                 ColorManager.blackColor,
//                                 ColorManager.blackColor,
//                                 ColorManager.blackColor,
//                                 ColorManager.primaryColor,
//                                 ColorManager.primaryColor,
//                                 ColorManager.primaryColor,
//                                 ColorManager.primaryColor,
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                             pageIndex == 2
//                                 ? "Reset Password"
//                                 : "Forget Password",
//                             style: getBoldStyle(color: ColorManager.whiteColor)
//                                 .copyWith(fontSize: 22),
//                           ),
//                         ],
//                       ),
//                       UIHelper.verticalSpaceSmall,
//                       pageIndex == 0
//                           ? Text(
//                               "Enter your email you used to register and a 6 digit code will be sent.",
//                               style: getRegularStyle(
//                                   color: ColorManager.greyColor, fontSize: 14),
//                             )
//                           : pageIndex == 1
//                               ? Text(
//                                   "Enter  the 6 digit code",
//                                   style: getRegularStyle(
//                                       color: ColorManager.greyColor,
//                                       fontSize: 14),
//                                 )
//                               : Text(
//                                   "Enter  your new password",
//                                   style: getRegularStyle(
//                                       color: ColorManager.greyColor,
//                                       fontSize: 14),
//                                 )
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 7,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0, vertical: 10),
//                   child: PageView.builder(
//                     controller: _pageController,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: registrationForms.length,
//                     onPageChanged: (index) {
//                       setState(
//                         () {
//                           pageIndex = index;
//                         },
//                       );
//                     },
//                     itemBuilder: (context, index) {
//                       return registrationForms[index];
//                     },
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Center(
//                   child: AppButton(
//                     onPressed: () {
//                       if (!_formKey.currentState!.validate()) {
//                         if (pageIndex != registrationForms.length - 1) {
//                           _pageController.nextPage(
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeIn,
//                           );
//                         } else {
//                           NavigateClass().pushNamed(
//                             context: context,
//                             routName: Routes.loginRoute,
//                           );
//                         }
//                       }
//                     },
//                     buttonText: pageIndex == registrationForms.length - 1
//                         ? "Submit"
//                         : "Next",
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

//   }
// }

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView(
      vmBuilder: (context) => ForgetPasswordProvider(
        context: context,
      ),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, ForgetPasswordProvider provider) {
    List<Widget> registrationForms = const [
      ForgetAccEmail(),
      PinNumber(),
      PasswordReg(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            registrationForms.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(
                                right: 4.0,
                              ),
                              child: DotIndicatorWidget(
                                isActive: index == provider.pageIndex,
                                isReg: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpaceSmall,
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          UIHelper.horizontalSpaceMedium,
                          GradientText(
                            gradient: LinearGradient(
                              colors: [
                                ColorManager.blackColor,
                                ColorManager.blackColor,
                                ColorManager.blackColor,
                                ColorManager.primaryColor,
                                ColorManager.primaryColor,
                                ColorManager.primaryColor,
                                ColorManager.primaryColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            provider.pageIndex == 2
                                ? "Reset Password"
                                : "Forget Password",
                            style: getBoldStyle(color: ColorManager.whiteColor)
                                .copyWith(fontSize: 22),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpaceSmall,
                      provider.pageIndex == 0
                          ? Text(
                              "Enter your email you used to register and a 6 digit code will be sent.",
                              style: getRegularStyle(
                                  color: ColorManager.greyColor, fontSize: 14),
                            )
                          : provider.pageIndex == 1
                              ? Text(
                                  "Enter  the 6 digit code",
                                  style: getRegularStyle(
                                      color: ColorManager.greyColor,
                                      fontSize: 14),
                                )
                              : Text(
                                  "Enter  your new password",
                                  style: getRegularStyle(
                                      color: ColorManager.greyColor,
                                      fontSize: 14),
                                )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: PageView.builder(
                    controller: provider.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: registrationForms.length,
                    onPageChanged: (index) {
                      provider.setIndex(
                          value: index, result: provider.pageIndex);
                    },
                    itemBuilder: (context, index) {
                      return registrationForms[index];
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: AppButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        if (provider.pageIndex !=
                            registrationForms.length ) {
                           provider.updatePage();
                          if (provider.pageController!.hasClients) {
                            provider.pageController!.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          } else {
                            print("controller not initailized");
                          }
                        } else {
                          NavigateClass().pushNamed(
                            context: context,
                            routName: Routes.loginRoute,
                          );
                        }
                      }
                    },
                    buttonText:
                        provider.pageIndex == registrationForms.length - 1
                            ? "Submit"
                            : "Next",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PinNumber extends StatelessWidget {
  const PinNumber({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppFormField(
          hintText: "6 digit code",
          keyboardType: TextInputType.number,
          validator: (String? val) => FieldValidator().validate(val!),
        ),
      ],
    );
  }
}

class PasswordReg extends StatelessWidget {
  const PasswordReg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppFormField(
          hintText: AppStrings.password,
          obscure: true,
          prefix: const Padding(
            padding: EdgeInsets.all(12.0),
          ),
          suffixWidget: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                ImageAssets.eye,
                colorFilter:
                    ColorFilter.mode(ColorManager.greyColor, BlendMode.srcIn),
              ),
            ),
          ),
          keyboardType: TextInputType.visiblePassword,
          validator: (String? val) => FieldValidator().validate(val!),
        ),
        UIHelper.verticalSpaceSmall,
        AppFormField(
          hintText: "Confirm password",
          obscure: true,
          prefix: const Padding(
            padding: EdgeInsets.all(12.0),
          ),
          suffixWidget: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                ImageAssets.eye,
                colorFilter:
                    ColorFilter.mode(ColorManager.greyColor, BlendMode.srcIn),
              ),
            ),
          ),
          keyboardType: TextInputType.visiblePassword,
          validator: (String? val) => FieldValidator().validate(val!),
        ),
      ],
    );
  }
}

class ForgetAccEmail extends StatelessWidget {
  const ForgetAccEmail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppFormField(
          hintText: "Email",
          keyboardType: TextInputType.emailAddress,
          validator: (String? val) => FieldValidator().validateEmail(val!),
        ),
      ],
    );
  }
}
