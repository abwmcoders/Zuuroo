// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:zuuro/app/base/base_screen.dart';
import 'package:zuuro/presentation/view/vtu/model/bet_biller_model.dart';

import '../../../../app/app_constants.dart';
import '../../../../app/functions.dart';
import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../../auth/verify/component/otp_field.dart';
import '../../history/transaction_details.dart';
import '../airtime/airtime.dart';
import '../data/data.dart';
import '../provider/bet_provider.dart';

class Bet extends StatelessWidget {
  Bet({super.key});

  final PageController _pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Page titles
  final List<String> _titles = ['Loan', 'Buy'];

  @override
  Widget build(BuildContext context) {
    return BaseView(
      vmBuilder: (context) => BetProvider(context: context, callBiller: true),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, BetProvider betProvider) {
    return Scaffold(
      appBar: const SimpleAppBar(
        title: "Betting",
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
                                fontWeight: betProvider.currentPage == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: betProvider.currentPage == index
                                    ? ColorManager.blackColor
                                    : ColorManager.greyColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          // Active indicator
                          betProvider.currentPage == index
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
                    betProvider.setIndex(index);
                  },
                  itemBuilder: (context, index) {
                    return index == 0
                        ? _loanWidget(betProvider, context)
                        : _buyWidget(betProvider, context);
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
      {required BetProvider provider,
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
                        provider.purchaseBet(
                          ctx: context,
                          pin: provider.otpField.text.trim(),
                          betNumber: provider.betNumber.text.trim(),
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
      String? type = "Betting",
      required BetModel biller,
      int topUp = 1,
      required BetProvider provider}) {
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
                      Text(
                        type!,
                        style: getBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                CheckoutTile(
                  title: "Betting Number",
                  value: meterNumber,
                ),
                CheckoutTile(
                  title: "Biller Name",
                  value: biller.provider!,
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
                          : double.parse(AppConstants
                                          .homeModel!.data.wallet.balance)
                                      .toInt() >=
                                  int.parse(amount)
                              ? Icon(
                                  Icons.check,
                                  color: ColorManager.activeColor,
                                )
                              : Icon(
                                  Icons.close,
                                  color: ColorManager.primaryColor,
                                )
                      // topUp == 2
                      //     ? Icon(
                      //         Icons.check,
                      //         color: ColorManager.activeColor,
                      //       )
                      //     : int.parse(AppConstants
                      //                 .homeModel!.data.wallet.balance) >=
                      //             int.parse(amount)
                      //         ? Icon(
                      //             Icons.check,
                      //             color: ColorManager.activeColor,
                      //           )
                      //         : Icon(
                      //             Icons.close,
                      //             color: ColorManager.primaryColor,
                      //           ),
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

  Widget _buyWidget(BetProvider vtuProvider, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (vtuProvider.betNumber.text != '' &&
            vtuProvider.selectedBiller != null) {
          vtuProvider.verifyBetNumber(
            ctx: context,
            ctr: vtuProvider.betNumber.text.trim(),
            billerCode: vtuProvider.selectedBiller!.provider!,
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
            //! amount
            AmountReUseWidget(
              controller: vtuProvider.amountController,
              showCurrency: true,
            ),
            UIHelper.verticalSpaceMedium,
            //! Betting number
            AmountReUseWidget(
              callFunc: true,
              title: "Betting Number",
              controller: vtuProvider.betNumber,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a betting number';
                }
                final regex = RegExp(r'^\d{7,10}$');
                if (!regex.hasMatch(value)) {
                  return 'Please enter a valid 7 digit betting number';
                }
                return null;
              },
              digitsCount: 13,
              onComplete: () {
                vtuProvider.verifyBetNumber(
                  ctx: context,
                  ctr: vtuProvider.betNumber.text.trim(),
                  billerCode: vtuProvider.selectedBiller!.provider!,
                );
              },
            ),
            UIHelper.verticalSpaceMedium,
            vtuProvider.selectedMeterData != null
                ? Column(
                    children: [
                      Text(
                        'Customer Username: ${vtuProvider.selectedMeterData!.userName}',
                        style: getBoldStyle(
                            color: ColorManager.activeColor, fontSize: 16),
                      ),
                      UIHelper.verticalSpaceSmall,
                      Text(
                        'Customer name: ${vtuProvider.selectedMeterData!.firstName }  ${vtuProvider.selectedMeterData!.lastName}',
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
                                    vtuProvider.betNumber.text.trim(),
                                biller: vtuProvider.selectedBiller!,
                                amount:
                                    vtuProvider.amountController.text.trim(),
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
                            message: "Unverified Betting number !!!",
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

  Widget _loanWidget(BetProvider vtuProvider, BuildContext context) {
    return GestureDetector(
      onTap: () {
       if (vtuProvider.betNumber.text != '' &&
            vtuProvider.selectedBiller != null) {
          vtuProvider.verifyBetNumber(
            ctx: context,
            ctr: vtuProvider.betNumber.text.trim(),
            billerCode: vtuProvider.selectedBiller!.provider!,
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
            //! amount
            AmountReUseWidget(
              controller: vtuProvider.amountController,
              showCurrency: true,
            ),
            UIHelper.verticalSpaceMedium,
            //! Betting number
            AmountReUseWidget(
              callFunc: true,
              title: "Betting Number",
              controller: vtuProvider.betNumber,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a betting number';
                }
                final regex = RegExp(r'^\d{7,10}$');
                if (!regex.hasMatch(value)) {
                  return 'Please enter a valid 7 digit betting number';
                }
                return null;
              },
              digitsCount: 13,
              onComplete: () {
                vtuProvider.verifyBetNumber(
                  ctx: context,
                  ctr: vtuProvider.betNumber.text.trim(),
                  billerCode: vtuProvider.selectedBiller!.provider!,
                );
              },
            ),
            UIHelper.verticalSpaceMedium,
            vtuProvider.selectedMeterData != null
                ? Column(
                    children: [
                      Text(
                        'Customer Username: ${vtuProvider.selectedMeterData!.userName}',
                        style: getBoldStyle(
                            color: ColorManager.activeColor, fontSize: 16),
                      ),
                      UIHelper.verticalSpaceSmall,
                      Text(
                        'Customer name: ${vtuProvider.selectedMeterData!.firstName}  ${vtuProvider.selectedMeterData!.lastName}',
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
                                meterNumber: vtuProvider.betNumber.text.trim(),
                                biller: vtuProvider.selectedBiller!,
                                topUp: 2,
                                amount: calculateLoanRepayment(
                                    vtuProvider.amountController.text,
                                    vtuProvider.loanLimit!.percentage),
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
                            message: "Unverified Betting Number !!!",
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

}

class SelectBiller extends StatelessWidget {
  const SelectBiller({
    super.key,
    required this.vtuProvider,
  });

  final BetProvider vtuProvider;

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
            AppConstants.betBillerModel != null
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
            AppConstants.betBillerModel != null &&
                    AppConstants.betBillerModel!.isNotEmpty
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
                                                    AppConstants.betBillerModel!
                                                        .length, (index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      vtuProvider
                                                          .setSelectedBiller(
                                                        AppConstants
                                                                .betBillerModel![
                                                            index],
                                                      );
                                                      vtuProvider.setBillerCode(
                                                          AppConstants
                                                              .betBillerModel![
                                                                  index]
                                                              .provider!,
                                                          AppConstants
                                                              .betBillerModel![
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
                                                                .betBillerModel![
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
