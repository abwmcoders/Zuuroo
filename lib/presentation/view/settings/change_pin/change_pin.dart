import 'package:flutter/material.dart';
import 'package:zuuro/app/base/base_screen.dart';
import 'package:zuuro/presentation/view/settings/provider/settings_provider.dart';

import '../../../../app/animation/navigator.dart';
import '../../../../app/functions.dart';
import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../../auth/verify/component/otp_field.dart';
import '../../history/transaction_details.dart';
import '../../onboarding/onboarding.dart';
import '../../vtu/airtime/airtime.dart';

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

  FocusNode? newPin2FocusNode;
  FocusNode? newPin3FocusNode;
  FocusNode? newPin4FocusNode;

  TextEditingController pin1 = TextEditingController(text: "");
  TextEditingController pin2 = TextEditingController(text: "");
  TextEditingController pin3 = TextEditingController(text: "");
  TextEditingController pin4 = TextEditingController(text: "");
  TextEditingController newPin1 = TextEditingController(text: "");
  TextEditingController newPin2 = TextEditingController(text: "");
  TextEditingController newPin3 = TextEditingController(text: "");
  TextEditingController newPin4 = TextEditingController(text: "");

  String? newOtp;
  String? oldPin;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    newPin2FocusNode = FocusNode();
    newPin3FocusNode = FocusNode();
    newPin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    newPin2FocusNode!.dispose();
    newPin3FocusNode!.dispose();
    newPin4FocusNode!.dispose();
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
                    "Change Pin",
                    style: getBoldStyle(color: ColorManager.whiteColor).copyWith(fontSize: 22),
                  ),
                ],
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                "You can create a new pin here.",
                style: getRegularStyle(color: ColorManager.greyColor, fontSize: 14),
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
                          offset: const Offset(8, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      autofocus: true,
                      obscureText: false,
                      controller: newPin1,
                      cursorColor: ColorManager.primaryColor,
                      validator: (String? val) => FieldValidator().validate(val!),
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      // decoration: //otpInputDecoration,
                      onChanged: (value) {
                        nextField(value, newPin2FocusNode);
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
                          offset: const Offset(8, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                        focusNode: newPin2FocusNode,
                        autofocus: true,
                        obscureText: false,
                        controller: newPin2,
                        cursorColor: ColorManager.primaryColor,
                        validator: (String? val) => FieldValidator().validate(val!),
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          nextField(value, newPin3FocusNode);
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
                          offset: const Offset(8, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                        focusNode: newPin3FocusNode,
                        autofocus: true,
                        obscureText: false,
                        controller: newPin3,
                        cursorColor: ColorManager.primaryColor,
                        validator: (String? val) => FieldValidator().validate(val!),
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          nextField(value, newPin4FocusNode);
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
                          offset: const Offset(8, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                        focusNode: newPin4FocusNode,
                        autofocus: true,
                        obscureText: false,
                        controller: newPin4,
                        cursorColor: ColorManager.primaryColor,
                        validator: (String? val) => FieldValidator().validate(val!),
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            newOtp =
                                "${newPin1.text.trim() + newPin2.text.trim() + newPin3.text.trim() + newPin4.text.trim()}";
                            provider.setBoolStatus(true);
                            provider.setNewPin(newOtp!);
                            pin4FocusNode!.unfocus();
                          }
                        }),
                  ),
                ],
              ),
              UIHelper.verticalSpaceLarge,
              AppButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _otpInput(provider);
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

  _otpInput(SettingsProvider provider) {
    appBottomSheet(
      context,
      Container(
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.keyboard_backspace_rounded,
                  ),
                ),
                const Label(
                  label: "Enter Your 4 Digits PIN",
                ),
              ],
            ),
            const Divider(),
            Column(
              children: [
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
                            offset: const Offset(8, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                        autofocus: true,
                        obscureText: false,
                        controller: pin1,
                        cursorColor: ColorManager.primaryColor,
                        validator: (String? val) => FieldValidator().validate(val!),
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                            offset: const Offset(8, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                          focusNode: pin2FocusNode,
                          autofocus: true,
                          obscureText: false,
                          controller: pin2,
                          cursorColor: ColorManager.primaryColor,
                          validator: (String? val) => FieldValidator().validate(val!),
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                            offset: const Offset(8, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                          focusNode: pin3FocusNode,
                          autofocus: true,
                          obscureText: false,
                          controller: pin3,
                          cursorColor: ColorManager.primaryColor,
                          validator: (String? val) => FieldValidator().validate(val!),
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                            offset: const Offset(8, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextFormField(
                          focusNode: pin4FocusNode,
                          autofocus: true,
                          obscureText: false,
                          controller: pin4,
                          cursorColor: ColorManager.primaryColor,
                          validator: (String? val) => FieldValidator().validate(val!),
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.length == 1) {
                              oldPin = "${pin1.text.trim() + pin2.text.trim() + pin3.text.trim() + pin4.text.trim()}";
                              provider.setBoolStatus(true);
                              provider.setPin(oldPin!);
                              pin4FocusNode!.unfocus();
                            }
                          }),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceMedium,
                AppButton(
                  onPressed: () {
                    if (provider.isPinCompleted) {
                      Navigator.pop(context);
                      print("popped the screen first");
                      provider.verifyPin(
                        ctx: context,
                      );
                      pin1.clear();
                      pin2.clear();
                      pin3.clear();
                      pin4.clear();
                    } else {
                      Navigator.pop(context);
                      MekNotification().showMessage(
                        context,
                        message: "Please enter your previous pin",
                      );
                    }
                  },
                  buttonText: "Continue",
                ),
                UIHelper.verticalSpaceMedium,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePinEmail extends StatelessWidget {
  ChangePinEmail({
    super.key,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const SimpleAppBar(title: "Change Pin"),
      body: BaseView(
        vmBuilder: (context) => SettingsProvider(context: context),
        builder: _buildScreen,
      ),
    );
  }

  Widget _buildScreen(BuildContext context, SettingsProvider provider) {
    return Form(
      key: _formKey,
      child: ContainerWidget(
        // color: ColorManager.whiteColor.withOpacity(.5),
        content: Column(
          children: [
            UIHelper.verticalSpaceMedium,
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UIHelper.verticalSpaceSmall,
                    Text(
                      "Confirm your email and a 6 digit code will be sent.",
                      style: getRegularStyle(color: ColorManager.deepGreyColor, fontSize: 14),
                    ),
                    UIHelper.verticalSpaceMedium,
                    AppFormField(
                      shouldBeWhite: false,
                      hintText: "Email",
                      fieldController: provider.requestPinChange,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? val) => FieldValidator().validateEmail(val!),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: AppButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      provider.requestOtp();
                    }
                  },
                  buttonText: "Next",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerifyChangePinOtp extends StatelessWidget {
  VerifyChangePinOtp({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView(
      vmBuilder: (context) => SettingsProvider(
        context: context,
      ),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, SettingsProvider provider) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const SimpleAppBar(title: "Change Pin"),
      body: SafeArea(
        child: ContainerWidget(
          content: Form(
            key: _formKey,
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
                          text:
                              provider.requestPinChange.text.isNotEmpty ? provider.requestPinChange.text : "Your email",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  UIHelper.verticalSpaceLarge,
                  UIHelper.verticalSpaceLarge,
                  AppPinField(
                    length: 6,
                    onCompleted: (_) => provider.verifyChangeOtp(),
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
                      provider.verifyChangeOtp();
                    },
                    buttonText: "Verify",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
