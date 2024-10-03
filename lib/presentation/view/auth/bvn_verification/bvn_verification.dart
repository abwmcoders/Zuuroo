import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/animation/navigator.dart';
import '../../../../app/cache/orage_cred.dart';
import '../../../../app/cache/storage.dart';
import '../../../../app/locator.dart';
import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../../onboarding/onboarding.dart';

class BvnScreen extends StatefulWidget {
  const BvnScreen({super.key, this.from});

  final String? from;

  @override
  State<BvnScreen> createState() => _BvnScreenState();
}

class _BvnScreenState extends State<BvnScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool tc = false;

  late PageController _pageController;
  final storageService = getIt<MekStorage>();
  int pageIndex = 0;

  updatePageIndex() {
    if (widget.from == "pin") {
      setState(() {
        pageIndex = 1;
      });
    }
  }


  List<Widget> registrationForms = const [
    BvnDetailsReg(),
    CreatePin(),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.from == "pin" ? 1 : 0);
    updatePageIndex();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                isActive: index == pageIndex,
                                isReg: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpaceSmall,
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
                        pageIndex == 0 ? "BVN Verification" : "Create Pin",
                        style: getBoldStyle(color: ColorManager.whiteColor)
                            .copyWith(fontSize: 22),
                      ),
                      UIHelper.verticalSpaceMedium,
                      pageIndex == 0
                          ? Text(
                              "Confirming your BVN  helps us verify your identity and keep your account from fraud ",
                              style: getRegularStyle(
                                  color: ColorManager.greyColor, fontSize: 14),
                            )
                          : Text(
                              "Set PIN for every transaction you do",
                              style: getRegularStyle(
                                  color: ColorManager.greyColor, fontSize: 14),
                            ),
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
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: registrationForms.length,
                    onPageChanged: (index) {
                      setState(
                        () {
                          pageIndex = index;
                        },
                      );
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
                        if (pageIndex != registrationForms.length - 1) {
                          if(pageIndex == 0) {
                             storageService.putString(
                            StorageKeys.onBoardingStorageKey,
                            "bvn",
                          );
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                          }
                          else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                          }
                          
                        } else {
                          storageService.putString(
                          StorageKeys.onBoardingStorageKey,
                          "pin",
                        );
                          _modalBottomSheetMenu();
                        }
                    },
                    buttonText: pageIndex == registrationForms.length - 1
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

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.whiteColor,
      builder: (builder) {
        return Container(
          height: deviceHeight(context) * .7,
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(ImageAssets.success),
                UIHelper.verticalSpaceMedium,
                Text(
                  "Successful",
                  style: getBoldStyle(
                      color: ColorManager.blackColor, fontSize: 16),
                ),
                UIHelper.verticalSpaceSmall,
                Text(
                  " Your account have been successfully\ncreated",
                  textAlign: TextAlign.center,
                  style: getRegularStyle(
                    color: ColorManager.blackColor,
                    fontSize: 13,
                  ),
                ),
                UIHelper.verticalSpaceMediumPlus,
                AppButton(
                  onPressed: () {
                    NavigateClass().pushNamed(
                      context: context,
                      routName: Routes.loginRoute,
                    );
                  },
                  buttonText: pageIndex == registrationForms.length - 1
                      ? "Submit"
                      : "Next",
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}


class CreatePin extends StatefulWidget {
  const CreatePin({
    super.key,
  });

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
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
    return Column(
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
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
      
      ],
    );
  }
}

class BvnDetailsReg extends StatelessWidget {
  const BvnDetailsReg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppFormField(
          hintText: "Enter bvn number",
          keyboardType: TextInputType.number,
          validator: (String? val) => FieldValidator().validate(val!),
        ),
        UIHelper.verticalSpaceSmall,
        AppFormField(
          hintText: "Full name",
          keyboardType: TextInputType.name,
          validator: (String? val) => FieldValidator().validate(val!),
        ),
        UIHelper.verticalSpaceSmall,
        AppFormField(
          hintText: "Date of birth",
          keyboardType: TextInputType.datetime,
          validator: (String? val) => FieldValidator().validate(val!),
        ),
        UIHelper.verticalSpaceSmall,
        AppFormField(
          hintText: "Gender",
          keyboardType: TextInputType.emailAddress,
          validator: (String? val) => FieldValidator().validate(val!),
        ),
      ],
    );
  }
}
