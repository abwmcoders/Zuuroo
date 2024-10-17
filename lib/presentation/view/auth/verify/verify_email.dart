import 'package:flutter/material.dart';
import 'package:zuuro/app/base/base_screen.dart';
import 'package:zuuro/presentation/resources/resources.dart';
import 'package:zuuro/presentation/resources/style_manager.dart';
import 'package:zuuro/presentation/view/auth/verify/provider/verify_provider.dart';

import '../../../../app/cache/storage.dart';
import '../../../../app/locator.dart';
import '../../../../app/validator.dart';
import '../../../resources/ui_helper.dart';
import 'component/otp_field.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      vmBuilder: (context) =>
          VerifyProvider(context: context, email: email),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, VerifyProvider provider) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: provider.otpFieldKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                const Text(
                  "Enter otp",
                  style: TextStyle(
                    fontFamily: "AT",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                UIHelper.verticalSpaceSmall,
                Text.rich(
                  TextSpan(
                      text: 'Enter the OTP code sent to ',
                      style: getBoldStyle(color: ColorManager.blackColor),
                      children: [
                        TextSpan(
                          text: email,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        )
                      ]),
                  textAlign: TextAlign.center,
                ),
                UIHelper.verticalSpaceLarge,
                UIHelper.verticalSpaceLarge,
                AppPinField(
                  length: 6,
                  onCompleted: (_) => provider.verifyMail(context: context),
                  controller: provider.otpField,
                  obscure: false,
                  validator: (v) => FieldValidator().validateRequiredLength(
                    v,
                    6,
                  ),
                ),
                UIHelper.verticalSpaceMediumPlus,
                AppButton(
                  onPressed: () {
                    provider.verifyMail(context: context);
                  },
                  buttonText: "Verify",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
