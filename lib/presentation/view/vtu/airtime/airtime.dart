import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zuuro/app/app_constants.dart';
import 'package:zuuro/app/base/base_screen.dart';
import 'package:zuuro/presentation/resources/color_manager.dart';
import 'package:zuuro/presentation/view/history/transaction_details.dart';
import 'package:zuuro/presentation/view/vtu/provider/vtu_provider.dart';

import '../../../../app/animation/navigator.dart';
import '../../../../app/functions.dart';
import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../elect/elect.dart';
import '../model/country_model.dart';

class Airtime extends StatelessWidget {
  Airtime({super.key});

  final PageController _pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  TextEditingController pin1 = TextEditingController(text: "");
  TextEditingController pin2 = TextEditingController(text: "");
  TextEditingController pin3 = TextEditingController(text: "");
  TextEditingController pin4 = TextEditingController(text: "");
  TextEditingController amountController = TextEditingController(text: "");
  TextEditingController numberController = TextEditingController(text: "");

  String? newOtp;

  int? _selectedIndex;
  String selectedLoan = '';

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  // Page titles
  final List<String> _titles = ['Loan', 'Buy'];

  @override
  Widget build(BuildContext context) {
    return BaseView(
      vmBuilder: (context) =>
          VtuProvider(context: context, shouldCallInit: true),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, VtuProvider vtuProvider) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Airtime"),
      body: ContainerWidget(
        content: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(_titles.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0, left: 10.0),
                            child: Text(
                              _titles[index],
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "NT",
                                fontWeight:vtuProvider.currentPage == index ? FontWeight.bold : FontWeight.normal,
                                color: vtuProvider.currentPage == index
                                    ? ColorManager.blackColor
                                    : ColorManager.greyColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          // Active indicator
                          vtuProvider.currentPage == index
                              ? Container(
                                  height: 4,
                                  width: 50,
                                  margin: EdgeInsets.only(right: 20),
                                  color: ColorManager.primaryColor,
                                )
                              : SizedBox(height: 4),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _titles.length,
                   physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    vtuProvider.setIndex(index);
                  },
                  itemBuilder: (context, index) {
                    return index == 0 ? _loanWidget(vtuProvider, context) : _buyWidget(vtuProvider, context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _otpInput(
      {required VtuProvider provider,
      required int topUp,
      required BuildContext context}) {
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
                  label: "Enter Your 4 Digits OTP",
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
                              newOtp =
                                  "${pin1.text.trim() + pin2.text.trim() + pin3.text.trim() + pin4.text.trim()}";
                              provider.setBool(true);
                              provider.setOtp(newOtp!);
                              pin4FocusNode!.unfocus();
                            }
                          }),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceMedium,
                AppButton(
                  onPressed: () {
                    if (provider.isOtpComplete) {
                      Navigator.pop(context);
                      print("popped the screen first");
                      provider.verifyPin(
                          ctx: context,
                          onSuccess: () {
                            provider.purchaseAirtime(
                              ctx: context,
                              topUp: topUp,
                              amount: amountController.text.trim(),
                              number: numberController.text.trim(),
                            );
                          });
                    } else {
                      Navigator.pop(context);
                      MekNotification().showMessage(
                        context,
                        message: "Please enter your pin",
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

  void _confirmationBottomSheetMenu(
      {required BuildContext ctx,
      required String amount,
      String? type = "Airtime",
      required String number,
      int topUp = 1,
      required VtuProvider provider}) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: ColorManager.whiteColor,
      builder: (builder) {
        return Container(
          height: deviceHeight(ctx) * .5,
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
                Text(
                  "₦ $amount.00",
                  style: getBoldStyle(
                      color: ColorManager.blackColor, fontSize: 16),
                ),
                UIHelper.verticalSpaceMedium,
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                    top: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Type",
                        style: getRegularStyle(
                          color: ColorManager.deepGreyColor,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.mtn,
                          ),
                          Text(
                            type!,
                            style: getBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                    top: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment Number",
                        style: getRegularStyle(
                          color: ColorManager.deepGreyColor,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        number,
                        style: getBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceSmall,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                      color: ColorManager.greyColor.withOpacity(.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Wallet Balance",
                            style: getBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "( ₦ ${AppConstants.homeModel!.data.wallet.balance})",
                            style: getRegularStyle(
                              color: ColorManager.deepGreyColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      int.parse(AppConstants.homeModel!.data.wallet.balance) >=
                              int.parse(amount)
                          ? Icon(
                              Icons.check,
                              color: ColorManager.activeColor,
                            )
                          : Icon(
                              Icons.close,
                              color: ColorManager.primaryColor,
                            )
                    ],
                  ),
                ),
                UIHelper.verticalSpaceMediumPlus,
                AppButton(
                  onPressed: () {
                    if (int.parse(
                            AppConstants.homeModel!.data.wallet.balance) >=
                        int.parse(amount)) {
                      Navigator.pop(ctx);
                      //!
                      _otpInput(provider: provider, topUp: topUp, context: ctx);
                    } else {
                      Navigator.pop(ctx);
                      MekNotification().showMessage(
                        ctx,
                        message: "Insufficient fund !!!",
                      );
                    }
                  },
                  buttonText: "Pay",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  
  Padding _buyWidget(VtuProvider vtuProvider, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          //!const VtuCountrySelector(),
          Text(
            "Country",
            style: getBoldStyle(
              color: ColorManager.deepGreyColor,
              fontSize: 14,
            ),
          ),
          UIHelper.verticalSpaceSmall,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            decoration: BoxDecoration(
              color: ColorManager.greyColor.withOpacity(.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: AppConstants.countryModel != null &&
                    AppConstants.countryModel!.isNotEmpty
                ? Row(
                    children: [
                      Text(
                        vtuProvider.countryCode != null
                            ? vtuProvider.countryCode!.toUpperCase()
                            : "",
                        style: getBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: 18,
                        ),
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Expanded(
                        child: DropdownButtonFormField<CountryModel>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                          value: vtuProvider.selectedCountry,
                          onChanged: (CountryModel? newValue) async {
                            vtuProvider.setSelectedCountry(newValue!);
                            vtuProvider.setCountryCode(
                              newValue.countryCode,
                              newValue.phoneCode,
                            );

                            await vtuProvider.getOperator(
                              newValue.countryCode,
                            );

                            vtuProvider.isOpSet();
                          },
                          items: vtuProvider
                              .countryList(AppConstants.countryModel!),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
          UIHelper.verticalSpaceMedium,
          //! operator and number field
          Row(
            children: [
              // Image.asset(
              //   ImageAssets.mtn,
              //   height: 25,
              //   width: 25,
              // ),
              Text(
                vtuProvider.operatorSet == true
                    ? vtuProvider.operatorCode ??
                        AppConstants.operatorModel!.first.operatorCode
                            .toUpperCase()
                    : "",
                style: getBoldStyle(
                  color: ColorManager.blackColor,
                  fontSize: 18,
                ),
              ),
              InkWell(
                onTap: () {
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
                                label: "Select a Provider",
                              ),
                            ],
                          ),
                          const Divider(),
                          Container(
                            height: deviceHeight(context) * .4,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    ...List.generate(
                                        AppConstants.operatorModel!.length,
                                        (index) {
                                      return InkWell(
                                        onTap: () {
                                          vtuProvider.setOperatorCode(
                                              AppConstants.operatorModel![index]
                                                  .operatorCode);
                                          Navigator.pop(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                            vertical: 8,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppConstants
                                                    .operatorModel![index]
                                                    .operatorCode,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: screenAwareSize(
                                                      19, context),
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1.5,
                                                ),
                                              ),
                                              UIHelper.verticalSpaceSmall,
                                              const Divider(),
                                              UIHelper.verticalSpaceSmall,
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                  ],
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
                        "${vtuProvider.phoneCode ?? ""}  |",
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
          UIHelper.verticalSpaceMedium,
          Text(
            "Amount",
            style: getBoldStyle(
              color: ColorManager.deepGreyColor,
              fontSize: 14,
            ),
          ),
          UIHelper.verticalSpaceSmall,
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: ColorManager.greyColor.withOpacity(.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              keyboardType: const TextInputType.numberWithOptions(),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: amountController,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontFamily: "NT",
                color: ColorManager.blackColor,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefix: Text(
                  AppConstants.currencySymbol,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    fontFamily: "NT",
                    color: ColorManager.blackColor,
                  ),
                ),
              ),
            ),
          ),

          UIHelper.verticalSpaceMedium,
          UIHelper.verticalSpaceLarge,
          Row(
            children: [
              Expanded(
                child: AppButton(
                  buttonText: "Submit",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _confirmationBottomSheetMenu(
                        amount: amountController.text,
                        number: numberController.text,
                        provider: vtuProvider,
                        topUp: 2,
                        ctx: context
                      );
                    } else {
                      //Navigator.pop(context);
                      MekNotification().showMessage(
                        context,
                        message: "Please fill out all fields!!!",
                      );
                    }
                  },
                  height: 30,
                ),
              ),
              UIHelper.horizontalSpaceSmall,
              Expanded(
                child: AppButton(
                  buttonText: "Back",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  height: 30,
                  borderColor: ColorManager.primaryColor,
                  buttonColor: ColorManager.whiteColor,
                  buttonTextColor: ColorManager.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  
  Padding _loanWidget(VtuProvider vtuProvider, BuildContext context) {
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView(
      children: [
        //!const VtuCountrySelector(),
        Text(
          "Country",
          style: getBoldStyle(
            color: ColorManager.deepGreyColor,
            fontSize: 14,
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: BoxDecoration(
            color: ColorManager.greyColor.withOpacity(.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: AppConstants.countryModel != null &&
                  AppConstants.countryModel!.isNotEmpty
              ? Row(
                  children: [
                    Text(
                      vtuProvider.countryCode != null
                          ? vtuProvider.countryCode!.toUpperCase()
                          : "",
                      style: getBoldStyle(
                        color: ColorManager.blackColor,
                        fontSize: 18,
                      ),
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Expanded(
                      child: DropdownButtonFormField<CountryModel>(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        value: vtuProvider.selectedCountry,
                        onChanged: (CountryModel? newValue) async {
                          vtuProvider.setSelectedCountry(newValue!);
                          vtuProvider.setCountryCode(
                            newValue.countryCode,
                            newValue.phoneCode,
                          );

                          await vtuProvider.getOperator(
                            newValue.countryCode,
                          );

                          vtuProvider.isOpSet();
                        },
                        items: vtuProvider
                            .countryList(AppConstants.countryModel!),
                      ),
                    ),
                  ],
                )
              : Container(),
        ),

        UIHelper.verticalSpaceMedium,
        //! operator and number field
        // vtuProvider.operatorSet == true
        //     ?
        Row(
          children: [
            // Image.asset(
            //   ImageAssets.mtn,
            //   height: 25,
            //   width: 25,
            // ),
            Text(
              vtuProvider.operatorSet == true
                  ? vtuProvider.operatorCode ??
                      AppConstants.operatorModel!.first.operatorCode
                          .toUpperCase()
                  : "",
              style: getBoldStyle(
                color: ColorManager.blackColor,
                fontSize: 18,
              ),
            ),
            InkWell(
              onTap: () {
                appBottomSheet(
                  context,
                  Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
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
                              label: "Select a Provider",
                            ),
                          ],
                        ),
                        const Divider(),
                        SizedBox(
                          height: deviceHeight(context) * .4,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  ...List.generate(
                                      AppConstants.operatorModel!.length,
                                      (index) {
                                    return InkWell(
                                      onTap: () {
                                        vtuProvider.setOperatorCode(
                                            AppConstants.operatorModel![index]
                                                .operatorCode);
                                        Navigator.pop(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 8,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppConstants
                                                  .operatorModel![index]
                                                  .operatorCode,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: screenAwareSize(
                                                    19, context),
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                            UIHelper.verticalSpaceSmall,
                                            const Divider(),
                                            UIHelper.verticalSpaceSmall,
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                                ],
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
                      "${vtuProvider.phoneCode ?? ""}  |",
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

        UIHelper.verticalSpaceMedium,

        Text(
          "Amount",
          style: getBoldStyle(
            color: ColorManager.deepGreyColor,
            fontSize: 14,
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: ColorManager.greyColor.withOpacity(.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            keyboardType: const TextInputType.numberWithOptions(),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: amountController,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontFamily: "NT",
              color: ColorManager.blackColor,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefix: Text(
                AppConstants.currencySymbol,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontFamily: "NT",
                  color: ColorManager.blackColor,
                ),
              ),
            ),
          ),
        ),

        UIHelper.verticalSpaceMedium,
        Text(
          "Loan",
          style: getBoldStyle(
            color: ColorManager.deepGreyColor,
            fontSize: 14,
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            loanPeriod.length,
            (index) => Expanded(
              child: SelectLoanPeriod(
                accountType: loanPeriod[index]['name'],
                active: _selectedIndex == index ? true : false,
                onPressed: () {
                  // setState(() {
                  //   if (_selectedIndex == index) {
                  //     _selectedIndex = null;
                  //   } else {
                  //     _selectedIndex = index;
                  //   }
                  //   selectedLoan = "${loanPeriod[_selectedIndex!]["name"]}";
                  // });
                },
              ),
            ),
          ),
        ),
        UIHelper.verticalSpaceMedium,
        AppAmountField(
          title: "Loan Repayment",
          controller: amountController,
        ),
        UIHelper.verticalSpaceLarge,
        Row(
          children: [
            Expanded(
              child: AppButton(
                buttonText: "Submit",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _confirmationBottomSheetMenu(
                      amount: amountController.text,
                      number: numberController.text,
                      provider: vtuProvider,
                      ctx: context,
                    );
                  } else {
                    //Navigator.pop(context);
                    MekNotification().showMessage(
                      context,
                      message: "Please fill out all fields!!!",
                    );
                  }
                },
                height: 30,
              ),
            ),
            UIHelper.horizontalSpaceSmall,
            Expanded(
              child: AppButton(
                buttonText: "Back",
                onPressed: () {
                  Navigator.pop(context);
                },
                height: 30,
                borderColor: ColorManager.primaryColor,
                buttonColor: ColorManager.whiteColor,
                buttonTextColor: ColorManager.primaryColor,
              ),
            ),
          ],
        ),
      ],
    ),
  );
  }

}


class AppAmountField extends StatelessWidget {
  const AppAmountField({
    super.key,
    this.title,
    this.controller,
  });

  final String? title;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "Amount",
          style: getBoldStyle(
            color: ColorManager.deepGreyColor,
            fontSize: 14,
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: ColorManager.greyColor.withOpacity(.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            keyboardType: const TextInputType.numberWithOptions(),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: controller,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontFamily: "NT",
              color: ColorManager.blackColor,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefix: Text(
                AppConstants.currencySymbol,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontFamily: "NT",
                  color: ColorManager.blackColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppNumberField extends StatelessWidget {
  const AppNumberField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          ImageAssets.mtn,
          height: 25,
          width: 25,
        ),
        Icon(
          Icons.arrow_drop_down,
          color: ColorManager.deepGreyColor,
        ),
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
                  "+234  |",
                  style: getBoldStyle(
                    color: ColorManager.blackColor,
                    fontSize: 10,
                  ),
                ),
                UIHelper.horizontalSpaceSmall,
                Expanded(
                  child: TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontFamily: "NT",
                        color: ColorManager.blackColor),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class VtuCountrySelector extends StatelessWidget {
  const VtuCountrySelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              Row(
                children: [
                  SvgPicture.asset(ImageAssets.flag),
                  UIHelper.horizontalSpaceSmall,
                  Text(
                    "Nigeria",
                    style: getBoldStyle(
                      color: ColorManager.blackColor,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              Icon(
                Icons.arrow_drop_down,
                color: ColorManager.deepGreyColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    super.key,
    required this.content,
    this.color,
  });

  final Widget content;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: color ?? ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: content,
      ),
    );
  }
}

class AppTabView extends StatelessWidget {
  const AppTabView({
    super.key,
    required TabController? tabController,
    this.headerOne,
    this.headerTwo,
  }) : _tabController = tabController;

  final TabController? _tabController;
  final String? headerOne, headerTwo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth(context),
      child: TabBar(
        isScrollable: true,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 4,
            color: ColorManager.primaryColor,
          ),
        ),
        tabAlignment: TabAlignment.start,
        indicatorColor: ColorManager.primaryColor,
        indicatorWeight: 2,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.black,
        dividerColor: Colors.transparent,
        unselectedLabelColor: Colors.grey,
        labelStyle: const TextStyle(
          fontSize: 15,
          fontFamily: "NT",
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontFamily: "NT",
          fontWeight: FontWeight.normal,
        ),
        controller: _tabController,
        tabs: [
          Tab(
            child: Text(
              headerOne ?? "Loan",
            ),
          ),
          Tab(
            child: Text(
              headerTwo ?? "Buy",
            ),
          ),
        ],
      ),
    );
  }
}

class AppTabField extends StatelessWidget {
  const AppTabField({
    super.key,
    required TabController? tabController,
    required this.contentOne,
    required this.contentTwo,
  }) : _tabController = tabController;

  final TabController? _tabController;
  final Widget contentOne, contentTwo;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          contentOne,
          contentTwo,
        ],
      ),
    );
  }
}
