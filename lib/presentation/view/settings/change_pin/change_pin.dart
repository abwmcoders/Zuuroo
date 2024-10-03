import 'package:flutter/material.dart';

import '../../../../app/animation/navigator.dart';
import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../../onboarding/onboarding.dart';

class ChangePin extends StatefulWidget {
  const ChangePin({super.key});

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  TextEditingController pin1 = TextEditingController(text: "");
  TextEditingController pin2 = TextEditingController(text: "");
  TextEditingController pin3 = TextEditingController(text: "");
  TextEditingController pin4 = TextEditingController(text: "");

  String? newOtp;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

   void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
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
                      "Change Pin",
                      style: getBoldStyle(color: ColorManager.whiteColor)
                          .copyWith(fontSize: 22),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceSmall,
                Text(
                  "You can create a new pin here.",
                  style: getRegularStyle(
                      color: ColorManager.greyColor, fontSize: 14),
                ),
                UIHelper.verticalSpaceMedium,
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: deviceWidth(context) * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorManager.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.greyColor.withOpacity(.14),
                            spreadRadius: 8,
                            blurRadius: 9,
                            offset: const Offset(
                                8, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        autofocus: true,
                        obscureText: false,
                        controller: pin1,
                        cursorColor: ColorManager.primaryColor,
                        validator: (String? val) =>
                            FieldValidator().validate(val!),
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        // decoration: //otpInputDecoration,
                        onChanged: (value) {
                          nextField(value, pin2FocusNode);
                        },
                      ),
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Container(
                      width: deviceWidth(context) * 0.15,
                      decoration: BoxDecoration(
                        color: ColorManager.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.greyColor.withOpacity(.14),
                            spreadRadius: 8,
                            blurRadius: 9,
                            offset: const Offset(
                                8, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                          focusNode: pin2FocusNode,
                          autofocus: true,
                          obscureText: false,
                          controller: pin2,
                          cursorColor: ColorManager.primaryColor,
                          validator: (String? val) =>
                              FieldValidator().validate(val!),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            nextField(value, pin3FocusNode);
                          }),
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Container(
                      width: deviceWidth(context) * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorManager.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.greyColor.withOpacity(.14),
                            spreadRadius: 8,
                            blurRadius: 9,
                            offset: const Offset(
                                8, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                          focusNode: pin3FocusNode,
                          autofocus: true,
                          obscureText: false,
                          controller: pin3,
                          cursorColor: ColorManager.primaryColor,
                          validator: (String? val) =>
                              FieldValidator().validate(val!),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            nextField(value, pin4FocusNode);
                          }),
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Container(
                      width: deviceWidth(context) * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorManager.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.greyColor.withOpacity(.14),
                            spreadRadius: 8,
                            blurRadius: 9,
                            offset: const Offset(
                                8, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                          focusNode: pin4FocusNode,
                          autofocus: true,
                          obscureText: false,
                          controller: pin4,
                          cursorColor: ColorManager.primaryColor,
                          validator: (String? val) =>
                              FieldValidator().validate(val!),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.length == 1) {
                              pin4FocusNode!.unfocus();
                            }
                          }),
                    ),
                  ],
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
            ),
          ),
        ),
      ),
    );
  }
}
