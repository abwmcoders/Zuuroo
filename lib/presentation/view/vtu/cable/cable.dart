// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:zuuro/app/base/base_screen.dart';
import 'package:zuuro/presentation/view/vtu/model/cable_model.dart';
import 'package:zuuro/presentation/view/vtu/model/cable_plan_model.dart';
import 'package:zuuro/presentation/view/vtu/provider/cable_provider.dart';

import '../../../../app/app_constants.dart';
import '../../../../app/functions.dart';
import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../../auth/verify/component/otp_field.dart';
import '../../history/transaction_details.dart';
import '../airtime/airtime.dart';
import '../data/data.dart';
import '../elect/elect.dart';


class Cable extends StatelessWidget {
  Cable({super.key});

  final PageController _pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController iucNumber = TextEditingController();

  // Page titles
  final List<String> _titles = ['Loan', 'Buy'];

  @override
  Widget build(BuildContext context) {
    return BaseView(
      vmBuilder: (context) => CableProvider(context: context),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, CableProvider cableProvider) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Cable"),
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
      {required CableProvider provider,
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
                  label: "Enter Your 4 Digits PIN",
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
                        provider.purchaseCable(
                          ctx: context,
                          iuc: provider.iucNumber.text.trim(),
                          topUp: topUp,
                          amount: topUp == 2
                              ? calculateLoanRepayment(
                                  provider.cablePlan!.price.toString(),
                                  provider.loanLimit!.percentage)
                              : provider.cablePlan!.price.toString(),
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
      required CablePlan plan,
      String? type = "Cable",
      required String number,
      int topUp = 1,
      required CableProvider provider}) {
        int result =
        double.parse(AppConstants.homeModel!.data.wallet.loanBalance).abs() >
                0.00
            ? double.parse(AppConstants.homeModel!.data.wallet.loanBalance)
                .abs()
                .toInt()
            : 0;
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
                CheckoutTile(title: "Product Type", value: type!,),
                CheckoutTile(title: "Phone Number", value: number,),
                CheckoutTile(title: "Cable Plan", value: plan.plan!,),
                CheckoutTile(title: "Iuc Number", value: provider.iucNumber.text.trim(),),
                CheckoutTile(title: "Customer Name", value: provider.selectedIucNumber!.name),
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
                           topUp == 2 ? "Loan Wallet" :  "Wallet Balance",
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
                          ? result > 1 ? Icon(
                                  Icons.close,
                                  color: ColorManager.primaryColor,
                                ) : Icon(
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
                    if(topUp == 2) {
                      if (result > 1) {
                        Navigator.pop(ctx);
                        MekNotification().showMessage(
                          ctx,
                          message:
                              "You have unpaid loan amount, please pay up to continue !!!",
                        );
                      }else{
                        Navigator.pop(ctx);
                        _otpInput(
                            provider: provider, topUp: topUp, context: ctx);
                      }
                      
                    }else {
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

  Widget _buyWidget(CableProvider cableProvider, BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(cableProvider.selectedCable != null && cableProvider.iucNumber.text != "") {
          cableProvider.verifyIucNumber(
            ctx: context,
            iuc: cableProvider.iucNumber.text.trim(),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
             //!const VtuCountrySelector(),
            SelectCable(
              cableProvider: cableProvider,
            ),
            UIHelper.verticalSpaceMedium,
            selectCableCategories(cableProvider, context),
           UIHelper.verticalSpaceMedium,
            //! number
            AmountReUseWidget(
              title: "Phone Number",
              controller: cableProvider.number,
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
            //! IUC number
            AmountReUseWidget(
              callFunc: true,
              title: "IUC Number",
              digitsCount: 11,
              controller: cableProvider.iucNumber,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an IUC number';
                }
                final regex = RegExp(r'^\d{10,11}$');
                if (!regex.hasMatch(value)) {
                  return 'Please enter a valid 10 or 11 digit IUC number';
                }
                return null;
              },
              onComplete: () {
                cableProvider.verifyIucNumber(
                  ctx: context,
                  iuc: cableProvider.iucNumber.text.trim(),
                );
              },
            ),
            UIHelper.verticalSpaceMedium,
            if (cableProvider.selectedCable != null && cableProvider.iucNumber.text != "")
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    cableProvider.verifyIucNumber(
                      ctx: context,
                      iuc: cableProvider.iucNumber.text.trim(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: ColorManager.buttonGradient,
                      //color: ColorManager.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Verify",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            UIHelper.verticalSpaceMedium,
            cableProvider.selectedIucNumber != null
                ? Text(
                    'Customer Name: ${cableProvider.selectedIucNumber!.name}',
                    style: getBoldStyle(
                        color: ColorManager.activeColor, fontSize: 16),
                  )
                : Container(),
            UIHelper.verticalSpaceMedium,
            UIHelper.verticalSpaceMedium,
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    buttonText: "Submit",
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                      if (cableProvider.selectedIucNumber != null) {
                        if (cableProvider.cableName != null ||
                            cableProvider.cableCode != null) {
                              if (AppConstants.homeModel != null) {
                              _confirmationBottomSheetMenu(
                                ctx: context,
                                plan: cableProvider.cablePlan!,
                                amount:
                                    cableProvider.cablePlan!.price.toString(),
                                number: cableProvider.number.text.trim(),
                                provider: cableProvider,
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
                            message: "Please select a cable tv and plan !!!",
                          );
                        }
                      } else {
                        MekNotification().showMessage(
                          context,
                          message: "Unverified iuc number, please fill all fields and tap anywhere in the app to verify !!!",
                        );
                      }
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
      ),
    );
  }

  Widget _loanWidget(CableProvider cableProvider, BuildContext context) {
    return GestureDetector(
       onTap: () {
        if (cableProvider.cableName != null &&
            cableProvider.iucNumber.text != "") {
          cableProvider.verifyIucNumber(
            ctx: context,
            iuc: cableProvider.iucNumber.text.trim(),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            //!const VtuCountrySelector(),
            SelectCable(
              cableProvider: cableProvider,
            ),
            UIHelper.verticalSpaceMedium,
            selectCableCategories(cableProvider, context),
            UIHelper.verticalSpaceMedium,
            //! number
            AmountReUseWidget(
              title: "Phone Number",
              controller: cableProvider.number,
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
            //! IUC number
            AmountReUseWidget(
              callFunc: true,
              title: "IUC Number",
              digitsCount: 11,
              controller: cableProvider.iucNumber,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an IUC number';
                }
                final regex = RegExp(r'^\d{10,11}$');
                if (!regex.hasMatch(value)) {
                  return 'Please enter a valid 10 or 11 digit IUC number';
                }
                return null;
              },
              onComplete: () {
                cableProvider.verifyIucNumber(
                  ctx: context,
                  iuc: cableProvider.iucNumber.text.trim(),
                );
              },
            ),
            UIHelper.verticalSpaceMedium,
             if (cableProvider.selectedCable != null && cableProvider.iucNumber.text != "")
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    cableProvider.verifyIucNumber(
                      ctx: context,
                      iuc: cableProvider.iucNumber.text.trim(),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: ColorManager.buttonGradient,
                      //color: ColorManager.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Verify",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            UIHelper.verticalSpaceMedium,
            cableProvider.selectedIucNumber != null
                ? Text(
                  'Customer Name: ${cableProvider.selectedIucNumber!.name}',
                  style: getBoldStyle(
                      color: ColorManager.activeColor, fontSize: 16),
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
                        cableProvider.selectedLoanIndex == index ? true : false,
                    onPressed: () {
                      cableProvider.setLoanIndex(index);
                      cableProvider.setLoanLimit(AppConstants.loanModel![index]);
                    },
                  ),
                ),
              ),
            ),
            UIHelper.verticalSpaceMedium,
            cableProvider.loanLimit != null && cableProvider.cablePlan != null
                ? AmountReUseWidget(
                    isEdit: false,
                    title: "Loan Repayment",
                    label: calculateLoanRepayment(cableProvider.cablePlan!.price.toString(),
                        cableProvider.loanLimit!.percentage),
                    //controller: vtuProvider.amountController,
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
                        if (cableProvider.selectedIucNumber != null) {
                          if (cableProvider.cableName != null ||
                              cableProvider.cableCode != null) {
                                if (AppConstants.homeModel != null) {
                              _confirmationBottomSheetMenu(
                                ctx: context,
                                plan: cableProvider.cablePlan!,
                                topUp: 2,
                                amount: calculateLoanRepayment(
                                    cableProvider.cablePlan!.price.toString(),
                                    cableProvider.loanLimit!.percentage),
                                number: cableProvider.number.text.trim(),
                                provider: cableProvider,
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
                              message: "Please select a cable tv and plan !!!",
                            );
                          }
                        } else {
                          MekNotification().showMessage(
                            context,
                            message: "Unverified iuc number, please fill all fields and tap anywhere in the app to verify !!!",
                          );
                        }                      
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
      ),
    );
  }

  Widget selectCableCategories(
      CableProvider cableProvider, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cable Plan",
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
                cableProvider.cablePlan != null
                    ? "${cableProvider.cablePlan!.plan} | ${AppConstants.currencySymbol} ${cableProvider.cablePlan!.price}"
                    : "Select Cable Plan",
                    overflow: TextOverflow.ellipsis,
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
                                label: "Select Cable Plan",
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
                                        AppConstants.cablePlanModel!.length,
                                        (index) {
                                      return InkWell(
                                        onTap: () {
                                          cableProvider.setSelectedPlan(
                                              AppConstants
                                                  .cablePlanModel![index]);
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
                                               "${AppConstants
                                                        .cablePlanModel![
                                                            index]
                                                        .plan} | ${AppConstants.currencySymbol} ${AppConstants.cablePlanModel![index].price.toString()}",
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

class BuildAmount extends StatelessWidget {
  const BuildAmount({
    super.key,
    required this.cableProvider,
  });

  final CableProvider cableProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: ColorManager.greyColor.withOpacity(.4),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, //"${AppConstants.currencySymbol}"
        children: [
          Text(
            cableProvider.cablePlan != null
                ? cableProvider.cablePlan!.price.toString()
                : "Loading...",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontFamily: "NT",
              color: ColorManager.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}

class SelectCable extends StatelessWidget {
  const SelectCable({
    super.key,
    required this.cableProvider,
  });

  final CableProvider cableProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Cable Tv",
          style: getBoldStyle(
            color: ColorManager.deepGreyColor,
            fontSize: 14,
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Center(
                child: Text(
                  cableProvider.cableCode != null
                      ? cableProvider.cableName!.toUpperCase().substring(0, 2)
                      : "..",
                  style: getBoldStyle(
                    color: ColorManager.blackColor,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            UIHelper.horizontalSpaceSmall,
            AppConstants.cableModel != null &&
                    AppConstants.cableModel!.isNotEmpty
                ? Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                          color: ColorManager.greyColor.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonFormField<CableData>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                          value: cableProvider.selectedCable,
                          onChanged: (CableData? newValue) async {
                            cableProvider.setSelectedCable(newValue!);
                            cableProvider.setString(
                              newValue.providerCode!,
                              newValue.providerName!,
                            );

                            await cableProvider.getCableplan(
                              newValue.providerCode!,
                            );

                            cableProvider.setPlan();
                          },
                          items:
                              cableProvider.cableList(AppConstants.cableModel!),
                        )),
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
