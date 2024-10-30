import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zuuro/app/base/base_screen.dart';

import '../../../../app/animation/navigator.dart';
import '../../../../app/cache/orage_cred.dart';
import '../../../../app/cache/storage.dart';
import '../../../../app/locator.dart';
import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../../onboarding/onboarding.dart';
import 'provider/login_provider.dart';


class Login extends StatelessWidget {
  Login({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final storageService = getIt<MekStorage>();

  // form variables
  final TextEditingController mekMail = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView(
      vmBuilder: (context) => LoginProvider(
        context: context,
        callInit: true,
        mekMail: mekMail,
        mekStorage: storageService,
      ),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, LoginProvider loginProvider) {
    return WillPopScope(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: ListView(
                      children: [
                        GradientText(
                          gradient: LinearGradient(
                            colors: [
                              ColorManager.blackColor,
                              ColorManager.primaryColor,
                              ColorManager.primaryColor,
                              ColorManager.primaryColor,
                              ColorManager.primaryColor,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          "Sign In",
                          style: getBoldStyle(color: ColorManager.whiteColor)
                              .copyWith(fontSize: 22),
                        ),
                        UIHelper.verticalSpaceMedium,
                        AppFormField(
                          hintText: AppStrings.email,
                          prefix: const Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          fieldController: loginProvider.mekMail,
                          keyboardType: TextInputType.name,
                          validator: (String? val) =>
                              FieldValidator().validateEmail(val!),
                        ),
                        UIHelper.verticalSpaceSmall,
                        AppFormField(
                          hintText: AppStrings.password,
                          prefix: const Padding(
                            padding: EdgeInsets.all(12.0),
                          ),
                          fieldController: password,
                          obscure: loginProvider.obscureTextGetter,
                          suffixWidget: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                               onTap: () {
                                loginProvider.obscure();
                              },
                              child: Icon( loginProvider.obscureTextGetter == true
                                  ? Icons.visibility : Icons.visibility_off,),
                            ),
                            // SvgPicture.asset(
                            //   ImageAssets.eye,
                            //   colorFilter: ColorFilter.mode(
                            //       ColorManager.greyColor, BlendMode.srcIn),
                            // ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String? val) =>
                              FieldValidator().validate(val!),
                        ),
                        UIHelper.verticalSpaceSmall,
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              NavigateClass().pushNamed(
                                context: context,
                                routName: Routes.forgotPasswordRoute,
                              );
                            },
                            child: Text(
                              "Forgot Password",
                              style: getBoldStyle(
                                color: ColorManager.errorColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        UIHelper.verticalSpaceMediumPlus,
                        AppButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              loginProvider.loginUser(
                                  password: password, context: context);
                            }
                            // if (_formKey.currentState!.validate()) {
                            //   MekStorage().putString(
                            //     StorageKeys.onBoardingStorageKey,
                            //     "used",
                            //   );
                            //   NavigateClass().pushNamed(
                            //     context: context,
                            //     routName: Routes.mainRoute,
                            //   );
                            // }
                          },
                          buttonText: AppStrings.login,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account?  ",
                          style: TextStyle(
                              fontSize: 12, color: ColorManager.blackColor),
                          children: [
                            WidgetSpan(
                              child: InkWell(
                                onTap: () {
                                  NavigateClass().pushNamed(
                                    context: context,
                                    args: "register",
                                    routName: Routes.registerRoute,
                                  );
                                },
                                child: GradientText(
                                  gradient: LinearGradient(
                                    colors: [
                                      ColorManager.primaryColor,
                                      ColorManager.primaryColor,
                                      ColorManager.secondaryColor,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  "Sign Up",
                                  style: getBoldStyle(
                                          color: ColorManager.whiteColor)
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
