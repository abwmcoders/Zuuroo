// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zuuro/app/base/base_screen.dart';
import 'package:zuuro/presentation/view/auth/register/provider/reg_provider.dart';
import 'package:zuuro/presentation/view/vtu/model/country_model.dart';

import '../../../../app/animation/navigator.dart';
import '../../../../app/cache/orage_cred.dart';
import '../../../../app/cache/storage.dart';
import '../../../../app/locator.dart';
import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../../onboarding/onboarding.dart';

class Register extends StatelessWidget {
  Register({super.key, required this.from});

  final String from;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _mekStorage = getIt<MekStorage>();

  @override
  Widget build(BuildContext context) {
    return BaseView(
      vmBuilder: (context) => RegisterProvider(
        context: context,
        mekStorage: _mekStorage,
        fromState: from,
      ),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, RegisterProvider regProvider) {
    final List<Widget> registrationForms = [
      PhoneNumberReg(
        countryController: regProvider.countryController,
        numberController: regProvider.telController,
        registerProvider: regProvider,
      ),
      UserInfoReg(
        nameController: regProvider.nameController,
        usernameController: regProvider.usernameController,
        emailController: regProvider.emailController,
      ),
      PasswordReg(
        passwordController: regProvider.passwordController,
      ),
      CreatePin(
        registerProvider: regProvider,
      ),
    ];

    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
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
                                  isActive: index == regProvider.pageIndex,
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
                          "Sign Up",
                          style: getBoldStyle(color: ColorManager.whiteColor)
                              .copyWith(fontSize: 22),
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
                      controller: regProvider.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: registrationForms.length,
                      onPageChanged: (index) {
                        regProvider.setIndex(
                            value: index, result: regProvider.pageIndex);
                      },
                      itemBuilder: (context, index) {
                        return registrationForms[index];
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (regProvider.pageIndex !=
                                registrationForms.length - 1) {
                              if (regProvider.pageIndex == 0) {
                                _mekStorage.putString(
                                  StorageKeys.onBoardingStorageKey,
                                  "number",
                                );
                                regProvider.pageController!.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              } else if (regProvider.pageIndex == 1) {
                                _mekStorage.putString(
                                  StorageKeys.onBoardingStorageKey,
                                  "info",
                                );
                                regProvider.pageController!.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              } else if (regProvider.pageIndex == 2) {
                                _mekStorage.putString(
                                  StorageKeys.onBoardingStorageKey,
                                  "password",
                                );
                                regProvider.pageController!.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              } else {
                                _mekStorage.putString(
                                  StorageKeys.onBoardingStorageKey,
                                  "reg",
                                );
                                regProvider.registerUser(ctx: context);
                              }
                              // else {
                              //   // _mekStorage.putString(
                              //   //   StorageKeys.onBoardingStorageKey,
                              //   //   "pin",
                              //   // );
                              //   regProvider.pageController!.nextPage(
                              //     duration: const Duration(milliseconds: 300),
                              //     curve: Curves.easeIn,
                              //   );
                              // }
                            } else {
                              _mekStorage.putString(
                                StorageKeys.onBoardingStorageKey,
                                "reg",
                              );
                              regProvider.registerUser(ctx: context);
                              // _modalBottomSheetMenu(
                              //     ctx: context,
                              //     onTap: () {
                              //       regProvider.registerUser(ctx: context);
                              //     });
                            }
                          }
                        },
                        buttonText: regProvider.pageIndex ==
                                registrationForms.length - 1
                            ? "Submit"
                            : "Next",
                      ),
                      UIHelper.verticalSpaceSmall,
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account?  ",
                            style: TextStyle(
                                fontSize: 12, color: ColorManager.blackColor),
                            children: [
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () {
                                    NavigateClass().pushNamed(
                                      context: context,
                                      routName: Routes.loginRoute,
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
                                    "Sign In",
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async => false,
    );
  }

  void _modalBottomSheetMenu({required BuildContext ctx, VoidCallback? onTap}) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: ColorManager.whiteColor,
      builder: (builder) {
        return Container(
          height: deviceHeight(ctx) * .7,
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
                  onPressed: onTap,
                  buttonText: "Next",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PhoneNumberReg extends StatelessWidget {
  PhoneNumberReg({
    super.key,
    required this.countryController,
    required this.numberController,
    required this.registerProvider,
  });

  TextEditingController countryController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  RegisterProvider registerProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // AppFormField(
        //   hintText: "Country",
        //   keyboardType: TextInputType.name,
        //   fieldController: countryController,
        //   validator: (String? val) => FieldValidator().validate(val!),
        // ),
        Text(
          "Country",
          style: getBoldStyle(
            color: ColorManager.deepGreyColor,
            fontSize: 14,
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: ColorManager.greyColor.withOpacity(.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                registerProvider.selectedCountry != null
                    ? registerProvider.selectedCountry!.countryName
                    : "Select Country",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontFamily: "NT",
                  color: ColorManager.blackColor,
                ),
              ),
              InkWell(
                onTap: () {
                  appBottomSheet(
                    context,
                    isNotTabScreen: true,
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
                                label: "Select Country",
                              ),
                            ],
                          ),
                          const Divider(),
                          Container(
                            height: deviceHeight(context) * .8,
                            child: Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: FutureBuilder<List<CountryModel>?>(
                                      future: registerProvider.getCountryList(
                                          ctx: context),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator()); // Show loading indicator while waiting
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else if (snapshot.hasData &&
                                            snapshot.data != null) {
                                          List<CountryModel> countries =
                                              snapshot.data!;
                                          return Column(
                                            children: [
                                              ...List.generate(
                                                 countries.length,
                                                  (index) {
                                                return InkWell(
                                                  onTap: () {
                                                    registerProvider.setCountry(
                                                        countries[index]);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 8,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          countries[index].countryName
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                screenAwareSize(
                                                                    19,
                                                                    context),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            letterSpacing: 1.5,
                                                          ),
                                                        ),
                                                        UIHelper
                                                            .verticalSpaceSmall,
                                                        const Divider(),
                                                        UIHelper
                                                            .verticalSpaceSmall,
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              })
                                            ],
                                          );
                                          // Text(
                                          //   'Country Name: ${snapshot.data!.customerName}',
                                          //   style: getBoldStyle(
                                          //       color: ColorManager.activeColor,
                                          //       fontSize: 16),
                                          // );
                                        } else {
                                          return Text(
                                            'Unable to fecth country...',
                                            style: getBoldStyle(
                                                color:
                                                    ColorManager.primaryColor,
                                                fontSize: 16),
                                          );
                                        }
                                      },
                                    )

                                    // Column(
                                    //   children: [
                                    //     ...List.generate(
                                    //         vtuProvider.meterType.length,
                                    //         (index) {
                                    //       return InkWell(
                                    //         onTap: () {
                                    //           vtuProvider.setMeter(vtuProvider
                                    //               .meterType[index]['name']);
                                    //           Navigator.pop(context);
                                    //         },
                                    //         child: Padding(
                                    //           padding: const EdgeInsets.symmetric(
                                    //             horizontal: 10.0,
                                    //             vertical: 8,
                                    //           ),
                                    //           child: Column(
                                    //             crossAxisAlignment:
                                    //                 CrossAxisAlignment.start,
                                    //             children: [
                                    //               Text(
                                    //                 vtuProvider.meterType[index]
                                    //                         ['name']
                                    //                     .toString(),
                                    //                 style: TextStyle(
                                    //                   color: Colors.black,
                                    //                   fontSize: screenAwareSize(
                                    //                       19, context),
                                    //                   fontWeight: FontWeight.w500,
                                    //                   letterSpacing: 1.5,
                                    //                 ),
                                    //               ),
                                    //               UIHelper.verticalSpaceSmall,
                                    //               const Divider(),
                                    //               UIHelper.verticalSpaceSmall,
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       );
                                    //     })
                                    //   ],
                                    // ),

                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Icon(
                  Icons.arrow_drop_down,
                  color: ColorManager.deepGreyColor,
                  size: 30,
                ),
              ),
            ],
          ),
        ),

        UIHelper.verticalSpaceMedium,
        Text(
          "Phone Number",
          style: getBoldStyle(
            color: ColorManager.deepGreyColor,
            fontSize: 14,
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Row(
          children: [
            
            Text(
              registerProvider.selectedCountry != null
                  ? 
                      registerProvider.selectedCountry!.countryCode.toUpperCase()
                  : "",
              style: getBoldStyle(
                color: ColorManager.blackColor,
                fontSize: 18,
              ),
            ),
            UIHelper.horizontalSpaceSmall,
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.greyColor.withOpacity(.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                     registerProvider.selectedCountry != null ? "${registerProvider.selectedCountry!.phoneCode }  |" : "",
                      style: getBoldStyle(
                        color: ColorManager.blackColor,
                        fontSize: 16,
                      ),
                    ),
                    UIHelper.horizontalSpaceSmall,

                    Expanded(
                      child: TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: numberController,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontFamily: "NT",
                            color: ColorManager.blackColor),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter 10 digits',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a value';
                          }
                          if (value.length != 10) {
                            return 'Please enter exactly 10 digits';
                          }
                          return null;
                        },
                      ),
                    )
                
                  ],
                ),
              ),
            )
          ],
        ),


        // AppFormField(
        //   hintText: "8056789800",
        //   fieldController: numberController,
        //   prefix: Padding(
        //     padding: const EdgeInsets.only(left: 8.0, right: 5),
        //     child: SvgPicture.asset(
        //       ImageAssets.ct,
        //     ),
        //   ),
        //   keyboardType: TextInputType.phone,
        //   validator: (String? val) => FieldValidator().validate(val!),
        // ),
        UIHelper.verticalSpaceSmall,
      ],
    );
  }
}

class PasswordReg extends StatelessWidget {
  PasswordReg({
    super.key,
    required this.passwordController,
  });

  TextEditingController passwordController = TextEditingController();

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
          fieldController: passwordController,
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
          validator: (String? val) =>
              FieldValidator().confirmPassword(val!, passwordController.text),
        ),
      ],
    );
  }
}

class UserInfoReg extends StatelessWidget {
  UserInfoReg({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.usernameController,
  });

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppFormField(
          hintText: "Full name",
          keyboardType: TextInputType.name,
          fieldController: nameController,
          validator: (String? val) => FieldValidator().validate(val!),
        ),
        UIHelper.verticalSpaceSmall,
        AppFormField(
          hintText: "Username",
          fieldController: usernameController,
          keyboardType: TextInputType.name,
          validator: (String? val) => FieldValidator().validate(val!),
        ),
        UIHelper.verticalSpaceSmall,
        AppFormField(
          hintText: "Email",
          fieldController: emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (String? val) => FieldValidator().validateEmail(val!),
        ),
      ],
    );
  }
}

class CreatePin extends StatefulWidget {
  const CreatePin({
    super.key,
    required this.registerProvider,
  });

  final RegisterProvider registerProvider;

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
        Text(
          "Set PIN for every transaction you do",
          style: getRegularStyle(
            color: ColorManager.blackColor,
            fontSize: 15,
          ),
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
                      newOtp =
                          "${pin1.text.trim() + pin2.text.trim() + pin3.text.trim() + pin4.text.trim()}";
                      widget.registerProvider.setPin(newOtp!);
                      widget.registerProvider.registerUser(ctx: context);
                    }
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
