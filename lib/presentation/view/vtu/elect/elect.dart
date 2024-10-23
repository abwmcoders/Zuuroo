import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zuuro/app/base/base_screen.dart';
import 'package:zuuro/presentation/view/vtu/model/biller_model.dart';
import 'package:zuuro/presentation/view/vtu/model/meter_number_model.dart';
import 'package:zuuro/presentation/view/vtu/provider/vtu_provider.dart';

import '../../../../app/animation/navigator.dart';
import '../../../../app/app_constants.dart';
import '../../../../app/functions.dart';
import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../../history/transaction_details.dart';
import '../airtime/airtime.dart';

class Bill extends StatefulWidget {
  const Bill({super.key});

  @override
  State<Bill> createState() => _BillState();
}

class _BillState extends State<Bill> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  TextEditingController pin1 = TextEditingController(text: "");
  TextEditingController pin2 = TextEditingController(text: "");
  TextEditingController pin3 = TextEditingController(text: "");
  TextEditingController pin4 = TextEditingController(text: "");
  TextEditingController amountController = TextEditingController(text: "");
  TextEditingController numberController = TextEditingController(text: "");
  bool isOtpComplete = false;

  String? newOtp;

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    super.dispose();
  }

  TextEditingController meterNumber = TextEditingController();
  TextEditingController amount = TextEditingController();

  String? meterTypeInput;
  String? billerCode;
  int? _selectedIndex;
  String selectedLoan = '';
  bool checkNumber = false;

  final List<Map> meterType = [
    {
      'id': 1,
      'name': 'Prepaid',
    },
    {
      'id': 2,
      'name': 'Postpaid',
    }
  ];

  Widget builMeterType({required VtuProvider vtuProvider}) {
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
          decoration: BoxDecoration(
            color: ColorManager.greyColor.withOpacity(.4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(15),
              hint: Text(
                'Select Meter Type',
                style: getRegularStyle(
                  color: ColorManager.deepGreyColor,
                  fontSize: 13,
                ),
              ),
              underline: Container(),
              value: meterTypeInput,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  meterTypeInput = value;
                });
              },
              items: meterType.map((option) {
                return DropdownMenuItem<String>(
                  value: option['name'],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(option['name']),
                      ),
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

  Widget buildMeterNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Meter number",
          style: getBoldStyle(
            color: ColorManager.deepGreyColor,
            fontSize: 14,
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: ColorManager.greyColor.withOpacity(.4),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 40,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: meterNumber,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Enter meter number',
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
              onEditingComplete: () {
                setState(() {
                  checkNumber = true;
                });
              },
            ),
          ),
        ),
        UIHelper.verticalSpaceLarge,
        // checkNumber
        //     ? FutureBuilder<VerifyMeterNumberData?>(
        //         future: VtuProvider().verifyMeterNumber(
        //             ctx: context, ctr: meterNumber.text.trim(), vtuP),
        //         builder: (context, snapshot) {
        //           if (snapshot.connectionState == ConnectionState.waiting) {
        //             return CircularProgressIndicator(); // Show loading indicator while waiting
        //           } else if (snapshot.hasError) {
        //             return Text('Error: ${snapshot.error}');
        //           } else if (snapshot.hasData && snapshot.data != null) {
        //             // Render customerName when data is available
        //             return Text(
        //                 'Customer Name: ${snapshot.data!.customerName}');
        //           } else {
        //             return Text('No data found');
        //           }
        //         },
        //       )
        //     : Container(),
      ],
    );
  }

  Widget buildAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Amount",
          style: getBoldStyle(
            color: ColorManager.deepGreyColor,
            fontSize: 14,
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: ColorManager.greyColor.withOpacity(.4),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 40,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: amount,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Enter amount',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Electricity"),
      body: BaseView(
        vmBuilder: (context) => VtuProvider(context: context, callBiller: true),
        builder: _buildScreen,
      ),
    );
  }

  Widget _buildScreen(BuildContext context, VtuProvider vtuProvider) {
    return ContainerWidget(
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
                  //! Select Biller
                  SelectBiller( vtuProvider: vtuProvider,),
                  UIHelper.verticalSpaceMedium,
                  //! Select meter type
                  selectMeterType(vtuProvider, context),
                  UIHelper.verticalSpaceMedium,
                  //! amount
                  buildAmount(),
                  UIHelper.verticalSpaceMedium,
                  //! Meter number
                  buildmeterNumber(),
                  UIHelper.verticalSpaceMedium,
                  checkNumber
                      ? FutureBuilder<VerifyMeterNumberData?>(
                          future: vtuProvider.verifyMeterNumber(
                            ctx: context,
                            ctr: meterNumber.text.trim(),
                            billerCode: "12334555666",
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Show loading indicator while waiting
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData &&
                                snapshot.data != null) {
                              vtuProvider.setCustomerName(
                                  snapshot.data!.customerName,
                                  snapshot.data!.customerNumber);
                              return Text(
                                'Customer Name: ${snapshot.data!.customerName}',
                                style: getBoldStyle(
                                    color: ColorManager.activeColor,
                                    fontSize: 16),
                              );
                            } else {
                              return Text(
                                'Invalid meter number',
                                style: getBoldStyle(
                                    color: ColorManager.primaryColor,
                                    fontSize: 16),
                              );
                            }
                          },
                        )
                      : Container(),
                  UIHelper.verticalSpaceMedium,

                  //! Loan
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
                  AppAmountField(
                    title: "Loan Repayment",
                    controller: amount,
                  ),
                  UIHelper.verticalSpaceLarge,
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          buttonText: "Submit",
                          onPressed: () {
                            if (vtuProvider.customerName != null) {
                              if (vtuProvider.billerCode != null ||
                                  vtuProvider.billerName != null) {
                                _confirmationBottomSheetMenu(
                                  amount: amount.text.trim(),
                                  number: vtuProvider.customerNumber!,
                                  provider: vtuProvider,
                                );
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
            contentTwo: ListView(
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
                buildAmount(),
                UIHelper.verticalSpaceMedium,
                //! Meter number
                buildmeterNumber(),
                UIHelper.verticalSpaceMedium,
                
                checkNumber
                    ? FutureBuilder<VerifyMeterNumberData?>(
                        future: vtuProvider.verifyMeterNumber(
                          ctx: context,
                          ctr: meterNumber.text.trim(),
                          billerCode: "12334555666",
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Show loading indicator while waiting
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData &&
                              snapshot.data != null) {
                            vtuProvider.setCustomerName(
                                snapshot.data!.customerName,
                                snapshot.data!.customerNumber);
                            return Text(
                              'Customer Name: ${snapshot.data!.customerName}',
                              style: getBoldStyle(
                                  color: ColorManager.activeColor,
                                  fontSize: 16),
                            );
                          } else {
                            return Text(
                              'Invalid meter number',
                              style: getBoldStyle(
                                  color: ColorManager.primaryColor,
                                  fontSize: 16),
                            );
                          }
                        },
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
                          if (vtuProvider.customerName != null) {
                            if (vtuProvider.billerCode != null ||
                                vtuProvider.billerName != null) {
                              _confirmationBottomSheetMenu(
                                amount: amount.text.trim(),
                                number: vtuProvider.customerNumber!,
                                provider: vtuProvider,
                              );
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
        ],
      ),
    );
  }

  Widget buildmeterNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Meter number",
          style: getBoldStyle(
            color: ColorManager.deepGreyColor,
            fontSize: 14,
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: ColorManager.greyColor.withOpacity(.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: meterNumber,
                          style: const TextStyle(color: Colors.black87),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'Enter meter number',
                            hintStyle: TextStyle(
                              color: Colors.black38,
                            ),
                          ),
                          onEditingComplete: () {
                            setState(() {
                              checkNumber = true;
                            });
                          },
                        ),
                      ),
                    ),
      ],
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
                                        height: 280,
                                        child: Expanded(
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Column(
                                                children: [
                                                  ...List.generate(
                                                      vtuProvider.meterType
                                                          .length, (index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        vtuProvider.setMeter(
                                                            vtuProvider.meterType[
                                                                index]['name']);
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
                                                              vtuProvider
                                                                  .meterType[
                                                                      index]
                                                                      ['name']
                                                                  .toString(),
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

  _otpInput(VtuProvider provider, {required int topUp}) {
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
                              setState(() {
                                isOtpComplete = true;
                              });
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
                    if (isOtpComplete) {
                      Navigator.pop(context);
                      print("popped the screen first");
                      provider.verifyPin(
                          ctx: context,
                          onSuccess: () {
                            provider.purchaseAirtime(
                              ctx: context,
                              topUp: topUp,
                             amount: "",
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

    // return OtpInputField(
    //   onTap: () {
    //     provider.purchaseAirtime(ctx: context);
    //   },
    //   vtuProvider: provider,
    // );
  }

  void _confirmationBottomSheetMenu(
      {required String amount,
      String? type = "Airtime",
      required String number,
      int topUp = 1,
      required VtuProvider provider}) {
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
                      Navigator.pop(context);
                      //!
                      _otpInput(provider, topUp: topUp);
                    } else {
                      MekNotification().showMessage(
                        context,
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
}

class SelectBiller extends StatelessWidget {
  const SelectBiller({
    super.key, required this.vtuProvider,
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
                            ? vtuProvider.selectedBiller!.billerName
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
                                  ? vtuProvider.selectedBiller!.billerName
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
                                                              .billerCode,
                                                          AppConstants
                                                              .billerModel![
                                                                  index]
                                                              .billerName);

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
                                                                .billerName,
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

final List<Map> loanPeriod = [
  {
    'id': 1,
    'name': '3 days',
  },
  {
    'id': 2,
    'name': '5 days',
  },
  {
    'id': 3,
    'name': '7 days',
  },
];
