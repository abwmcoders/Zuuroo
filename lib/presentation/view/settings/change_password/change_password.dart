import 'package:flutter/material.dart';

import '../../../../app/animation/navigator.dart';
import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../../onboarding/onboarding.dart';


class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10,),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back,),),
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
                  validator: (String? val) => FieldValidator().validate(val!),
                ),
                UIHelper.verticalSpaceSmall,
                AppFormField(
                  hintText: "Confirm password",
                  keyboardType: TextInputType.text,
                  validator: (String? val) => FieldValidator().validate(val!),
                ),
                UIHelper.verticalSpaceLarge,
                AppButton(
                  onPressed: () {
                   NavigateClass().pushNamed(
                      context: context,
                      routName: Routes.mainRoute,
                    );
                  },
                  buttonText: "Save Changes",
                ),
            ],
          ),),
      ),),
    );
  }
}