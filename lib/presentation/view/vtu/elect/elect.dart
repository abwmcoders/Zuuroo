// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zuuro/app/base/base_screen.dart';
import 'package:zuuro/presentation/view/vtu/model/biller_model.dart';
import 'package:zuuro/presentation/view/vtu/model/meter_number_model.dart';
import 'package:zuuro/presentation/view/vtu/provider/vtu_provider.dart';

import '../../../../app/app_constants.dart';
import '../../../../app/functions.dart';
import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../../auth/verify/component/otp_field.dart';
import '../../history/transaction_details.dart';
import '../airtime/airtime.dart';
import '../data/data.dart';
import '../model/power_model.dart';

class Bill extends StatelessWidget {
  Bill({super.key});

  final PageController _pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Page titles
  final List<String> _titles = ['Loan', 'Buy'];

  @override
  Widget build(BuildContext context) {
    return BaseView(
      vmBuilder: (context) => VtuProvider(context: context, callBiller: true),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, VtuProvider cableProvider) {
    return Scaffold(
      appBar: const SimpleAppBar(
        title: "Electricity",
      ),
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
                            padding:
                                const EdgeInsets.only(right: 30.0, left: 10.0),
                            child: Text(
                              _titles[index],
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "NT",
                                fontWeight: cableProvider.currentPage == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: cableProvider.currentPage == index
                                    ? ColorManager.blackColor
                                    : ColorManager.greyColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          // Active indicator
                          cableProvider.currentPage == index
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
                    cableProvider.setIndex(index);
                  },
                  itemBuilder: (context, index) {
                    return index == 0
                        ? _loanWidget(cableProvider, context)
                        : _buyWidget(cableProvider, context);
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AppPinField(
                    length: 4,
                    onCompleted: (_) => provider.verifyPin(
                      ctx: context,
                      onSuccess: () {
                        Navigator.pop(context);
                        print("success verify");
                        provider.purchaseBill(
                          ctx: context,
                          pin: provider.otpField.text.trim(),
                          meterNumber: provider.meterNumber.text.trim(),
                          topUp: topUp,
                          amount: topUp == 2
                              ? calculateLoanRepayment(
                                  provider.amountController.text
                                      .trim()
                                      ,
                                  provider.loanLimit!.percentage)
                              : provider.amountController.text.trim(),
                        );
                      },
                    ),
                    controller: provider.otpField,
                    obscure: true,
                    validator: (v) => FieldValidator().validateRequiredLength(
                      v,
                      4,
                    ),
                  ),
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
      required String meterNumber,
      required String mrterType,
      String? type = "Bill",
      required String number,
      required PowerModel biller,
      int topUp = 1,
      required VtuProvider provider}) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: ColorManager.whiteColor,
      builder: (builder) {
        return Container(
          height: deviceHeight(ctx) * .8,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: ListView(
              children: [
                Center(
                  child: Text(
                    "₦ $amount.00",
                    style: getBoldStyle(
                        color: ColorManager.blackColor, fontSize: 16),
                  ),
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
                CheckoutTile(
                  title: "Payment Number",
                  value: number,
                ),
                CheckoutTile(
                  title: "Biller Name",
                  value: biller.provider!,
                ),
                CheckoutTile(
                  title: "Meter Number",
                  value: meterNumber,
                ),
                CheckoutTile(
                  title: "Meter Type",
                  value: mrterType,
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
                            topUp == 2 ? "Loan Balance" : "Wallet Balance",
                            style: getBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            topUp == 1
                                ? "( ₦ ${AppConstants.homeModel!.data.wallet.balance})"
                                : "( ₦ ${AppConstants.homeModel!.data.wallet.loanBalance})",
                            style: getRegularStyle(
                              color: ColorManager.deepGreyColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      topUp == 2
                          ? Icon(
                              Icons.check,
                              color: ColorManager.activeColor,
                            )
                          : int.parse(AppConstants
                                      .homeModel!.data.wallet.balance) >=
                                  int.parse(amount)
                              ? Icon(
                                  Icons.check,
                                  color: ColorManager.activeColor,
                                )
                              : Icon(
                                  Icons.close,
                                  color: ColorManager.primaryColor,
                                ),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceMediumPlus,
                AppButton(
                  onPressed: () {
                    double? balance = double.tryParse(
                        AppConstants.homeModel?.data.wallet.balance ?? '');
                    double? inputAmount = double.tryParse(amount);
                    if (topUp == 2) {
                      Navigator.pop(ctx);
                      _otpInput(provider: provider, topUp: topUp, context: ctx);
                    } else {
                      if (balance != null &&
                          inputAmount != null &&
                          balance >= inputAmount) {
                        Navigator.pop(ctx);
                        _otpInput(
                            provider: provider, topUp: topUp, context: ctx);
                      } else {
                        Navigator.pop(ctx);
                        MekNotification().showMessage(
                          ctx,
                          message: "Insufficient fund !!!",
                        );
                      }
                    }
                  },
                  buttonText: "Continue",
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buyWidget(VtuProvider vtuProvider, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (vtuProvider.meterNumber.text != '' &&
            vtuProvider.selectedBiller != null &&
            vtuProvider.metr != null) {
          vtuProvider.verifyMeterNumber(
            ctx: context,
            ctr: vtuProvider.meterNumber.text.trim(),
            billerCode: vtuProvider.selectedBiller!.provider!,
            meterType: vtuProvider.metr!,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            //! Select Biller
            SelectBiller(
              vtuProvider: vtuProvider,
            ),
            UIHelper.verticalSpaceMedium,
            //! Select meter type
            selectMeterType(vtuProvider, context),
            UIHelper.verticalSpaceMedium,
            //! amount
            AmountReUseWidget(
              controller: vtuProvider.amountController,
              showCurrency: true,
            ),
            UIHelper.verticalSpaceMedium,
            //! number
            AmountReUseWidget(
              title: "Phone Number",
              controller: vtuProvider.numberController,
              digitsCount: 11,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                final regex = RegExp(r'^(?:\+234|0)(7|8|9)(0|1)\d{8}$');
                if (!regex.hasMatch(value)) {
                  return 'Please enter a valid Nigerian phone number';
                }
                return null;
              },
            ),
            UIHelper.verticalSpaceMedium,
            //! Meter number
            AmountReUseWidget(
              callFunc: true,
              title: "Meter Number",
              controller: vtuProvider.meterNumber,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an meter number';
                }
                final regex = RegExp(r'^\d{10,13}$');
                if (!regex.hasMatch(value)) {
                  return 'Please enter a valid 13 digit meter number';
                }
                return null;
              },
              digitsCount: 13,
              onComplete: () {
                vtuProvider.verifyMeterNumber(
                  ctx: context,
                  ctr: vtuProvider.meterNumber.text.trim(),
                  billerCode: vtuProvider.selectedBiller!.provider!,
                  meterType: vtuProvider.metr!,
                );
              },
            ),
            UIHelper.verticalSpaceMedium,
            vtuProvider.selectedMeterData != null
                ? Column(
                    children: [
                      Text(
                        'Customer Name: ${vtuProvider.selectedMeterData!.customerName}',
                        style: getBoldStyle(
                            color: ColorManager.activeColor, fontSize: 16),
                      ),
                      UIHelper.verticalSpaceSmall,
                      Text(
                        'Customer Address: ${vtuProvider.selectedMeterData!.address}',
                        style: getBoldStyle(
                            color: ColorManager.activeColor, fontSize: 16),
                      ),
                    ],
                  )
                : Container(),
            UIHelper.verticalSpaceLarge,
            UIHelper.verticalSpaceLarge,
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    buttonText: "Submit",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (vtuProvider.selectedMeterData != null) {
                          if (vtuProvider.billerCode != null ||
                              vtuProvider.billerName != null) {
                            if (AppConstants.homeModel != null) {
                              _confirmationBottomSheetMenu(
                                meterNumber:
                                    vtuProvider.meterNumber.text.trim(),
                                mrterType: vtuProvider.metr!,
                                biller: vtuProvider.selectedBiller!,
                                amount:
                                    vtuProvider.amountController.text.trim(),
                                number:
                                    vtuProvider.numberController.text.trim(),
                                provider: vtuProvider,
                                ctx: context,
                              );
                            } else {
                              MekNotification().showMessage(
                                context,
                                message:
                                    "Please refresh your home screen, your data is missing!!!",
                              );
                            }
                          } else {
                            MekNotification().showMessage(
                              context,
                              message:
                                  "Please select a biller name and code !!!",
                            );
                          }
                        } else {
                          MekNotification().showMessage(
                            context,
                            message: "Unverified Meter number !!!",
                          );
                        }
                      } else {
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
      ),
    );
  }

  Widget _loanWidget(VtuProvider vtuProvider, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (vtuProvider.meterNumber.text != '' &&
            vtuProvider.selectedBiller != null &&
            vtuProvider.metr != null) {
          vtuProvider.verifyMeterNumber(
            ctx: context,
            ctr: vtuProvider.meterNumber.text.trim(),
            billerCode: vtuProvider.selectedBiller!.provider!,
            meterType: vtuProvider.metr!,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            //! Select Biller
            SelectBiller(
              vtuProvider: vtuProvider,
            ),
            UIHelper.verticalSpaceMedium,
            //! Select meter type
            selectMeterType(vtuProvider, context),
            UIHelper.verticalSpaceMedium,
            //! amount
            AmountReUseWidget(
              controller: vtuProvider.amountController,
              showCurrency: true,
            ),
            UIHelper.verticalSpaceMedium,
            //! number
            AmountReUseWidget(
              title: "Phone Number",
              controller: vtuProvider.numberController,
              digitsCount: 11,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                final regex = RegExp(r'^(?:\+234|0)(7|8|9)(0|1)\d{8}$');
                if (!regex.hasMatch(value)) {
                  return 'Please enter a valid Nigerian phone number';
                }
                return null;
              },
            ),
            UIHelper.verticalSpaceMedium,
            //! Meter number
            AmountReUseWidget(
              callFunc: true,
              title: "Meter Number",
              controller: vtuProvider.meterNumber,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an meter number';
                }
                final regex = RegExp(r'^\d{10,13}$');
                if (!regex.hasMatch(value)) {
                  return 'Please enter a valid 13 digit meter number';
                }
                return null;
              },
              digitsCount: 13,
              onComplete: () {
                vtuProvider.verifyMeterNumber(
                  ctx: context,
                  ctr: vtuProvider.meterNumber.text.trim(),
                  billerCode: vtuProvider.selectedBiller!.provider!,
                  meterType: vtuProvider.metr!,
                );
              },
            ),
            UIHelper.verticalSpaceMedium,
            vtuProvider.selectedMeterData != null
                ? Column(
                    children: [
                      Text(
                        'Customer Name: ${vtuProvider.selectedMeterData!.customerName}',
                        style: getBoldStyle(
                            color: ColorManager.activeColor, fontSize: 16),
                      ),
                      UIHelper.verticalSpaceSmall,
                      Text(
                        'Customer Address: ${vtuProvider.selectedMeterData!.address}',
                        style: getBoldStyle(
                            color: ColorManager.activeColor, fontSize: 16),
                      ),
                    ],
                  )
                : Container(),
            UIHelper.verticalSpaceMedium,
            //! LOAN ---------
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
                AppConstants.loanModel!.length,
                (index) => Expanded(
                  child: SelectLoanPeriod(
                    accountType:
                        "${AppConstants.loanModel![index].labelName} Days",
                    active:
                        vtuProvider.selectedLoanIndex == index ? true : false,
                    onPressed: () {
                      vtuProvider.setLoanIndex(index);
                      vtuProvider.setLoanLimit(AppConstants.loanModel![index]);
                    },
                  ),
                ),
              ),
            ),
            UIHelper.verticalSpaceMedium,

            vtuProvider.loanLimit != null && vtuProvider.amountController.text.trim() != ""
                ? AmountReUseWidget(
                    isEdit: false,
                    title: "Loan Repayment",
                    label: calculateLoanRepayment(
                        vtuProvider.amountController.text.trim(), vtuProvider.loanLimit!.percentage),
                  )
                : Container(),
            UIHelper.verticalSpaceLarge,
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    buttonText: "Submit",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (vtuProvider.selectedMeterData != null) {
                          if (vtuProvider.billerCode != null ||
                              vtuProvider.billerName != null) {
                            if (AppConstants.homeModel != null) {
                              _confirmationBottomSheetMenu(
                                meterNumber:
                                    vtuProvider.meterNumber.text.trim(),
                                mrterType: vtuProvider.metr!,
                                biller: vtuProvider.selectedBiller!,
                                ctx: context,
                                topUp: 2,
                                amount: calculateLoanRepayment(
                                    vtuProvider.amountController.text,
                                    vtuProvider.loanLimit!.percentage),
                                number:
                                    vtuProvider.numberController.text.trim(),
                                provider: vtuProvider,
                              );
                            } else {
                              MekNotification().showMessage(
                                context,
                                message:
                                    "Please refresh your home screen, your data is missing!!!",
                              );
                            }
                          } else {
                            MekNotification().showMessage(
                              context,
                              message:
                                  "Please select a biller name and code !!!",
                            );
                          }
                        } else {
                          MekNotification().showMessage(
                            context,
                            message: "Unverified Meter number !!!",
                          );
                        }
                      } else {
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
      ),
    );
  }

  Widget selectMeterType(VtuProvider vtuProvider, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Meter type",
          style: getBoldStyle(
            color: ColorManager.deepGreyColor,
            fontSize: 14,
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: ColorManager.greyColor.withOpacity(.4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                vtuProvider.metr ?? "Select Meter type",
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
                                label: "Select Meter Type",
                              ),
                            ],
                          ),
                          const Divider(),
                          Container(
                            height: 300,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    ...List.generate(
                                        vtuProvider.meterType.length, (index) {
                                      return InkWell(
                                        onTap: () {
                                          vtuProvider.setMeter(vtuProvider
                                              .meterType[index]['name']);
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
                                                vtuProvider.meterType[index]
                                                        ['name']
                                                    .toString(),
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
            ],
          ),
        ),
      ],
    );
  }
}

class SelectBiller extends StatelessWidget {
  const SelectBiller({
    super.key,
    required this.vtuProvider,
  });

  final VtuProvider vtuProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Biller",
          style: getBoldStyle(
            color: ColorManager.deepGreyColor,
            fontSize: 14,
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Row(
          children: [
            AppConstants.billerModel != null
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Center(
                      child: Text(
                        vtuProvider.selectedBiller != null
                            ? vtuProvider.selectedBiller!.provider!
                                .substring(0, 2)
                                .toUpperCase()
                            : "..",
                        style: getBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                : Text(".."),
            UIHelper.horizontalSpaceSmall,
            AppConstants.billerModel != null &&
                    AppConstants.billerModel!.isNotEmpty
                ? Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: ColorManager.greyColor.withOpacity(.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              vtuProvider.selectedBiller != null
                                  ? vtuProvider.selectedBiller!.provider!
                                  : "Select Biller",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontFamily: "NT",
                                color: ColorManager.blackColor,
                              ),
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
                                            label: "Select Biller",
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      Container(
                                        height: deviceHeight(context) * .5,
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              children: [
                                                ...List.generate(
                                                    AppConstants.billerModel!
                                                        .length, (index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      vtuProvider
                                                          .setSelectedBiller(
                                                        AppConstants
                                                                .billerModel![
                                                            index],
                                                      );
                                                      vtuProvider.setBillerCode(
                                                          AppConstants
                                                              .billerModel![
                                                                  index]
                                                              .provider!,
                                                          AppConstants
                                                              .billerModel![
                                                                  index]
                                                              .provider!);

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
                                                            AppConstants
                                                                .billerModel![
                                                                    index]
                                                                .provider!,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  screenAwareSize(
                                                                      19,
                                                                      context),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              letterSpacing:
                                                                  1.5,
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
                  )
                : Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    decoration: BoxDecoration(
                      color: ColorManager.greyColor.withOpacity(.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Loading .....",
                      style: getBoldStyle(color: ColorManager.deepGreyColor),
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}

class RadioItem<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String label;
  final ValueChanged<T?> onChanged;

  RadioItem({
    required this.value,
    required this.groupValue,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth(context),
      child: RadioListTile<T>(
        value: value,
        groupValue: groupValue,
        title: Text(label),
        onChanged: onChanged,
      ),
    );
  }
}

class SelectLoanPeriod extends StatelessWidget {
  const SelectLoanPeriod({
    super.key,
    required this.accountType,
    required this.onPressed,
    this.active = false,
  });

  final String accountType;
  final VoidCallback onPressed;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: active
              ? ColorManager.primaryColor.withOpacity(.3)
              : ColorManager.whiteColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          border: Border.all(
            color: active ? ColorManager.primaryColor : ColorManager.blackColor,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.greyColor.withOpacity(.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(2, 5), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            accountType,
            style: getSemiBoldStyle(
              color:
                  active ? ColorManager.primaryColor : ColorManager.blackColor,
            ),
          ),
        ),
      ),
    );
  }
}
