import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zuuro/app/validator.dart';
import 'package:zuuro/presentation/resources/color_manager.dart';
import 'package:zuuro/presentation/resources/style_manager.dart';
import 'package:zuuro/presentation/view/vtu/model/country_model.dart';

import '../../../../app/animation/navigator.dart';
import '../../../../app/app_constants.dart';
import '../../../../app/base/base_screen.dart';
import '../../../../app/functions.dart';
import '../../../../app/services/api_rep/user_services.dart';
import '../../../resources/resources.dart';
import '../../auth/verify/component/otp_field.dart';
import '../../history/transaction_details.dart';
import '../airtime/airtime.dart';
import '../elect/elect.dart';
import '../model/data_cat_model.dart';
import '../model/data_plan_model.dart';
import '../provider/vtu_provider.dart';

class DataPage extends StatelessWidget {
  DataPage({super.key});

  final PageController _pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
      appBar: const SimpleAppBar(title: "Data"),
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
                          duration: const Duration(milliseconds: 300),
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
                                fontWeight: vtuProvider.currentPage == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: vtuProvider.currentPage == index
                                    ? ColorManager.blackColor
                                    : ColorManager.greyColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          // Active indicator
                          vtuProvider.currentPage == index
                              ? Container(
                                  height: 4,
                                  width: 50,
                                  margin: const EdgeInsets.only(right: 20),
                                  color: ColorManager.primaryColor,
                                )
                              : const SizedBox(height: 4),
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
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    vtuProvider.setIndex(index);
                  },
                  itemBuilder: (context, index) {
                    return index == 0
                        ? _loanWidget(vtuProvider, context)
                        : _buyWidget(vtuProvider, context);
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
                          provider.purchaseAirtime(
                            ctx: context,
                            topUp: topUp,
                            amount: topUp == 2
                                ? calculateLoanRepayment(
                                    provider.amountController.text.trim(),
                                    provider.loanLimit!.percentage)
                                : provider.amountController.text.trim(),
                          );
                        },
                        onError: () {
                          Navigator.pop(context);
                        }),
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
                    double? balance = double.tryParse(
                        AppConstants.homeModel?.data.wallet.balance ?? '');
                    double? inputAmount = double.tryParse(amount);
                    if (balance != null &&
                        inputAmount != null &&
                        balance >= inputAmount) {
                      Navigator.pop(ctx);
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
                          controller: vtuProvider.numberController,
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
          vtuProvider.operatorSet == true
              ? FutureBuilder(
                  future: UserApiServices().getDataCatList(
                      vtuProvider.operatorCode ??
                          AppConstants.operatorModel!.first.operatorCode),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      DataCategoryResponse dataCategoryResponse =
                          DataCategoryResponse.fromJson(snapshot.data);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Data Category",
                            style: getBoldStyle(
                              color: ColorManager.deepGreyColor,
                              fontSize: 14,
                            ),
                          ),
                          UIHelper.verticalSpaceSmall,
        
                          Container(
                            height: 50,
                            padding:
                                EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                              color: ColorManager.greyColor.withOpacity(.4),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dataCategoryResponse.data.isNotEmpty
                                      ? vtuProvider.selectedDataCat != null
                                          ? vtuProvider
                                              .selectedDataCat!.categoryName
                                          : dataCategoryResponse
                                              .data.first.categoryName
                                      : "Select Data Category",
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
                                                    Icons
                                                        .keyboard_backspace_rounded,
                                                  ),
                                                ),
                                                const Label(
                                                  label: "Select Data Categpory",
                                                ),
                                              ],
                                            ),
                                            const Divider(),
                                            Container(
                                              height: 300,
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(12.0),
                                                  child: Column(
                                                    children: [
                                                      ...List.generate(
                                                          dataCategoryResponse
                                                              .data
                                                              .length, (index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            vtuProvider.setDataCat(
                                                                dataCategoryResponse
                                                                    .data[index]);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
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
                                                                  dataCategoryResponse
                                                                      .data[index]
                                                                      .categoryName,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
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
                        ],
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                          color: ColorManager.greyColor.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Loading .....",
                          style:
                              getBoldStyle(color: ColorManager.deepGreyColor),
                        ),
                      );
                    }
                  },
                )
              : Container(),
          UIHelper.verticalSpaceMedium,
          vtuProvider.operatorSet == true || vtuProvider.selectedDataCat != null
              ? FutureBuilder(
                  future: UserApiServices().getDataPlanList({
                    "operator_code": vtuProvider.operatorCode ??
                        AppConstants.operatorModel!.first.operatorCode,
                    "category_code": vtuProvider.selectedDataCat != null ? vtuProvider.selectedDataCat!.categoryCode : "",
                  }),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      DataPlanResponse dataPlanResponse =
                          DataPlanResponse.fromJson(snapshot.data);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        vtuProvider.setDataPlan(dataPlanResponse.data.first);
                      });

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Data Plan",
                            style: getBoldStyle(
                              color: ColorManager.deepGreyColor,
                              fontSize: 14,
                            ),
                          ),
                          UIHelper.verticalSpaceSmall,
                          Container(
                            height: 50,
                            padding:
                                EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                              color: ColorManager.greyColor.withOpacity(.4),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dataPlanResponse.data.isNotEmpty
                                      ? vtuProvider.selectedDataPlan != null
                                          ? "${vtuProvider.selectedDataPlan!.operatorCode} ${vtuProvider.selectedDataPlan!.productName} | ${vtuProvider.selectedDataPlan!.validity}"
                                          : "${dataPlanResponse.data.first.operatorCode} ${dataPlanResponse.data.first.productName} | ${dataPlanResponse.data.first.validity}"

                                      : "Select Data Plan",
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
                                                    Icons
                                                        .keyboard_backspace_rounded,
                                                  ),
                                                ),
                                                const Label(
                                                  label: "Select Data Plan",
                                                ),
                                              ],
                                            ),
                                            const Divider(),
                                            Container(
                                              height: 300,
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(12.0),
                                                  child: Column(
                                                    children: [
                                                      ...List.generate(
                                                          dataPlanResponse
                                                              .data
                                                              .length, (index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            vtuProvider.setDataPlan(
                                                                dataPlanResponse
                                                                    .data[index]);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
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
                                                                  dataPlanResponse
                                                                      .data[index]
                                                                      .productName,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
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
                        ],
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                          color: ColorManager.greyColor.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Loading .....",
                          style:
                              getBoldStyle(color: ColorManager.deepGreyColor),
                        ),
                      );
                    }
                  },
                )
              : Container(),
          UIHelper.verticalSpaceMedium,
          vtuProvider.selectedDataPlan != null ? AppAmountField(
                  isEdit: false,
                  title: "Amount",
                  label: vtuProvider.selectedDataPlan!.costPrice.toString(),
                ) : Container(),
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
                          amount: vtuProvider.amountController.text,
                          number: vtuProvider.numberController.text,
                          provider: vtuProvider,
                          topUp: 2,
                          ctx: context);
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
    );
  }

  Padding _loanWidget(VtuProvider vtuProvider, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
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
                          controller: vtuProvider.numberController,
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
          vtuProvider.operatorSet == true
              ? FutureBuilder(
                  future: UserApiServices().getDataCatList(
                      vtuProvider.operatorCode ??
                          AppConstants.operatorModel!.first.operatorCode),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      DataCategoryResponse dataCategoryResponse =
                          DataCategoryResponse.fromJson(snapshot.data);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Data Category",
                            style: getBoldStyle(
                              color: ColorManager.deepGreyColor,
                              fontSize: 14,
                            ),
                          ),
                          UIHelper.verticalSpaceSmall,
        
                          Container(
                            height: 50,
                            padding:
                                EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                              color: ColorManager.greyColor.withOpacity(.4),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dataCategoryResponse.data.isNotEmpty
                                      ? vtuProvider.selectedDataCat != null
                                          ? vtuProvider
                                              .selectedDataCat!.categoryName
                                          : dataCategoryResponse
                                              .data.first.categoryName
                                      : "Select Data Category",
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
                                                    Icons
                                                        .keyboard_backspace_rounded,
                                                  ),
                                                ),
                                                const Label(
                                                  label: "Select Data Categpory",
                                                ),
                                              ],
                                            ),
                                            const Divider(),
                                            Container(
                                              height: 300,
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(12.0),
                                                  child: Column(
                                                    children: [
                                                      ...List.generate(
                                                          dataCategoryResponse
                                                              .data
                                                              .length, (index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            vtuProvider.setDataCat(
                                                                dataCategoryResponse
                                                                    .data[index]);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
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
                                                                  dataCategoryResponse
                                                                      .data[index]
                                                                      .categoryName,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
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
                        ],
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                          color: ColorManager.greyColor.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Loading .....",
                          style:
                              getBoldStyle(color: ColorManager.deepGreyColor),
                        ),
                      );
                    }
                  },
                )
              : Container(),
          UIHelper.verticalSpaceMedium,
          vtuProvider.operatorSet == true || vtuProvider.selectedDataCat != null
              ? FutureBuilder(
                  future: UserApiServices().getDataPlanList({
                    "operator_code": vtuProvider.operatorCode ??
                        AppConstants.operatorModel!.first.operatorCode,
                    "category_code": vtuProvider.selectedDataCat != null ? vtuProvider.selectedDataCat!.categoryCode : "",
                  }),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      DataPlanResponse dataPlanResponse =
                          DataPlanResponse.fromJson(snapshot.data);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        vtuProvider.setDataPlan(dataPlanResponse.data.first);
                      });

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Data Plan",
                            style: getBoldStyle(
                              color: ColorManager.deepGreyColor,
                              fontSize: 14,
                            ),
                          ),
                          UIHelper.verticalSpaceSmall,
                          Container(
                            height: 50,
                            padding:
                                EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                              color: ColorManager.greyColor.withOpacity(.4),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dataPlanResponse.data.isNotEmpty
                                      ? vtuProvider.selectedDataPlan != null
                                          ? "${vtuProvider.selectedDataPlan!.operatorCode} ${vtuProvider.selectedDataPlan!.productName} | ${vtuProvider.selectedDataPlan!.validity}"
                                          : "${dataPlanResponse.data.first.operatorCode} ${dataPlanResponse.data.first.productName} | ${dataPlanResponse.data.first.validity}"

                                      : "Select Data Plan",
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
                                                    Icons
                                                        .keyboard_backspace_rounded,
                                                  ),
                                                ),
                                                const Label(
                                                  label: "Select Data Plan",
                                                ),
                                              ],
                                            ),
                                            const Divider(),
                                            Container(
                                              height: 300,
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(12.0),
                                                  child: Column(
                                                    children: [
                                                      ...List.generate(
                                                          dataPlanResponse
                                                              .data
                                                              .length, (index) {
                                                        return InkWell(
                                                          onTap: () {
                                                            vtuProvider.setDataPlan(
                                                                dataPlanResponse
                                                                    .data[index]);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
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
                                                                  dataPlanResponse
                                                                      .data[index]
                                                                      .productName,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
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
                        ],
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                          color: ColorManager.greyColor.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Loading .....",
                          style:
                              getBoldStyle(color: ColorManager.deepGreyColor),
                        ),
                      );
                    }
                  },
                )
              : Container(),
          UIHelper.verticalSpaceMedium,
          vtuProvider.selectedDataPlan != null ? AppAmountField(
                  isEdit: false,
                  title: "Amount",
                  label: vtuProvider.selectedDataPlan!.costPrice.toString(),
                ) : Container(),
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
              AppConstants.loanModel!.length,
              (index) => Expanded(
                child: SelectLoanPeriod(
                  accountType:
                      "${AppConstants.loanModel![index].labelName} Days",
                  active: vtuProvider.selectedLoanIndex == index ? true : false,
                  onPressed: () {
                    vtuProvider.setLoanIndex(index);
                    vtuProvider.setLoanLimit(AppConstants.loanModel![index]);
                  },
                ),
              ),
            ),
          ),
          UIHelper.verticalSpaceMedium,
          vtuProvider.loanLimit != null &&
                  vtuProvider.selectedDataPlan != null
              ? AppAmountField(
                  isEdit: false,
                  title: "Loan Repayment",
                  label: calculateLoanRepayment(
                     "${vtuProvider.selectedDataPlan!.costPrice.toInt()}",
                      vtuProvider.loanLimit!.percentage),
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
                      _confirmationBottomSheetMenu(
                        topUp: 2,
                        amount: calculateLoanRepayment(
                            vtuProvider.amountController.text.trim(),
                            vtuProvider.loanLimit!.percentage),
                        number: vtuProvider.numberController.text,
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

class DataPageX extends StatefulWidget {
  const DataPageX({super.key});

  @override
  State<DataPageX> createState() => _DataPageXState();
}

class _DataPageXState extends State<DataPageX>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  TextEditingController loanAmount = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  String? _mySelection;
  String? _selectedPlan;
  int? _selectedIndex;
  String selectedLoan = '';

  final List<Map> _myJson = [
    {
      'id': '1',
      'image': 'images/operators/mtn.png',
      'name': 'MTN',
    },
    {
      'id': '2',
      'image': 'images/operators/airtel.png',
      'name': 'AIRTEL',
    },
    {
      'id': '3',
      'image': 'images/operators/9mobile.png',
      'name': '9MOBILE',
    },
    {
      'id': '4',
      'image': 'images/operators/glo.png',
      'name': 'GLO',
    },
  ];

  final List<Map> _dataPlan = [
    {
      'id': '1',
      'image': 'images/operators/mtn.png',
      'name': '100MB / 1 Day - \u20A6 100',
    },
    {
      'id': '2',
      'image': 'images/operators/airtel.png',
      'name': '250MB/7 Days-\u20A6 300',
    },
    {
      'id': '3',
      'image': 'images/operators/9mobile.png',
      'name': '200MB/2 Day- \u20A6 200',
    },
    {
      'id': '4',
      'image': 'images/operators/glo.png',
      'name': '350MB/7 Days-\u20A6 300',
    },
    {
      'id': '5',
      'image': 'images/operators/glo.png',
      'name': '750MB/ 14 Days-\u20A6 500',
    },
    {
      'id': '6',
      'image': 'images/operators/glo.png',
      'name': '2GB/30 Days-\u20A6 1,200',
    },
    {
      'id': '7',
      'image': 'images/operators/glo.png',
      'name': '1.5GB/30 Days-\u20A6 1,000',
    },
    {
      'id': '8',
      'image': 'images/operators/glo.png',
      'name': '1GB/ 1 Day-\u20A6 350',
    },
    {
      'id': '9',
      'image': 'images/operators/glo.png',
      'name': '750MB/7 Days-\u20A6 500',
    },
  ];

  Widget buidNetworkType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Data Type",
          style: getBoldStyle(
            color: ColorManager.deepGreyColor,
            fontSize: 14,
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: ColorManager.greyColor.withOpacity(.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(15),
              hint: Text(
                'Select network provider',
                style: getRegularStyle(
                  color: ColorManager.deepGreyColor,
                  fontSize: 13,
                ),
              ),
              value: _mySelection,
              underline: Container(),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _mySelection = value;
                });
              },
              items: _myJson.map((option) {
                return DropdownMenuItem<String>(
                  value: option['name'],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(option['name']),
                      ),
                      // Radio<String>(
                      //   value: option['name'],
                      //   groupValue: _mySelection ?? "Select",
                      //   //label: option['name'],
                      //   activeColor: ColorManager.primaryColor,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _mySelection = value;
                      //       Navigator.pop(context);
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

  Widget buidDataPlan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Data Plan",
          style: getBoldStyle(
            color: ColorManager.deepGreyColor,
            fontSize: 14,
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: ColorManager.greyColor.withOpacity(.4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(15),
              hint: const Text('Select Data Plan'),
              underline: Container(),
              value: _selectedPlan,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _selectedPlan = value;
                });
              },
              items: _dataPlan.map((option) {
                return DropdownMenuItem<String>(
                  value: option['name'],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(option['name']),
                      ),
                      // Radio<String>(
                      //   value: option['name'],
                      //   groupValue: _selectedPlan ?? "Select",
                      //   activeColor: ColorManager.primaryColor,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _selectedPlan = value;
                      //       Navigator.pop(context);
                      //     });
                      //   },
                      // )
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Data"),
      body: ContainerWidget(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTabView(
              tabController: _tabController,
            ),
            UIHelper.verticalSpaceSmall,
            AppTabField(
              tabController: _tabController,
              contentOne: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    const VtuCountrySelector(),
                    UIHelper.verticalSpaceMedium,
                    const AppNumberField(),
                    UIHelper.verticalSpaceMedium,
                    buidNetworkType(),
                    UIHelper.verticalSpaceMedium,
                    buidDataPlan(),
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
                              setState(() {
                                if (_selectedIndex == index) {
                                  _selectedIndex = null;
                                } else {
                                  _selectedIndex = index;
                                }
                                selectedLoan =
                                    "${loanPeriod[_selectedIndex!]["name"]}";
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    UIHelper.verticalSpaceMedium,
                    const AppAmountField(
                      title: "Loan Repayment",
                    ),
                    UIHelper.verticalSpaceLarge,
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            buttonText: "Submit",
                            onPressed: () {},
                            height: 30,
                          ),
                        ),
                        UIHelper.horizontalSpaceSmall,
                        Expanded(
                          child: AppButton(
                            buttonText: "clear",
                            onPressed: () {},
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
              contentTwo: ListView(
                children: [
                  const VtuCountrySelector(),
                  UIHelper.verticalSpaceMedium,
                  const AppNumberField(),
                  UIHelper.verticalSpaceMedium,
                  buidNetworkType(),
                  UIHelper.verticalSpaceMedium,
                  buidDataPlan(),
                  UIHelper.verticalSpaceMedium,
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          buttonText: "Submit",
                          onPressed: () {
                            _confirmationBottomSheetMenu();
                          },
                          height: 30,
                        ),
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Expanded(
                        child: AppButton(
                          buttonText: "clear",
                          onPressed: () {},
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
          ],
        ),
      ),
    );
  }

  void _confirmationBottomSheetMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.whiteColor,
      builder: (builder) {
        return Container(
          height: deviceHeight(context) * .5,
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
                  "₦ 2000.00",
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
                            "Data",
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
                        "0806789435",
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
                            "Loan Balance",
                            style: getBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "( ₦ 100,000)",
                            style: getRegularStyle(
                              color: ColorManager.deepGreyColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.check,
                        color: ColorManager.primaryColor,
                      )
                    ],
                  ),
                ),
                UIHelper.verticalSpaceMediumPlus,
                AppButton(
                  onPressed: () {
                    NavigateClass().pushNamed(
                      context: context,
                      routName: Routes.success,
                    );
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
}
