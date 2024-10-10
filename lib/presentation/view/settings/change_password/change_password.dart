import 'package:flutter/material.dart';
import 'package:zuuro/app/base/base_screen.dart';
import 'package:zuuro/presentation/view/settings/provider/settings_provider.dart';

import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../../onboarding/onboarding.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BaseView(
        vmBuilder: (context) => SettingsProvider(context: context),
        builder: _buildScreen,
      ),
    );
  }

  Widget _buildScreen(BuildContext context, SettingsProvider provider) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  GradientText(
                    gradient: LinearGradient(
                      colors: [
                        ColorManager.blackColor,
                        ColorManager.blackColor,
                        ColorManager.primaryColor,
                        ColorManager.primaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    "Change Password",
                    style: getBoldStyle(color: ColorManager.whiteColor)
                        .copyWith(fontSize: 22),
                  ),
                ],
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                "You can create a new password here.",
                style: getRegularStyle(
                    color: ColorManager.greyColor, fontSize: 14),
              ),
              UIHelper.verticalSpaceMedium,
              AppFormField(
                hintText: "New password",
                keyboardType: TextInputType.text,
                fieldController: passwordController,
                validator: (String? val) => FieldValidator().validate(val!),
              ),
              UIHelper.verticalSpaceSmall,
              AppFormField(
                hintText: "Confirm password",
                keyboardType: TextInputType.text,
                validator: (String? val) => FieldValidator()
                    .confirmPassword(passwordController.text, val!),
              ),
              UIHelper.verticalSpaceLarge,
              AppButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    provider.changePassword(
                      ctx: context,
                      newPassword: passwordController.text.trim(),
                    );
                  }
                },
                buttonText: "Save Changes",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
