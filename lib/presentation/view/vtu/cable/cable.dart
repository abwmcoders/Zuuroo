import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zuuro/app/base/base_screen.dart';
import 'package:zuuro/presentation/view/vtu/model/cable_model.dart';
import 'package:zuuro/presentation/view/vtu/provider/cable_provider.dart';

import '../../../../app/animation/navigator.dart';
import '../../../../app/app_constants.dart';
import '../../../../app/functions.dart';
import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../../history/transaction_details.dart';
import '../airtime/airtime.dart';
import '../elect/elect.dart';
import '../model/verify_iuc.dart';

class Cable extends StatefulWidget {
  const Cable({super.key});

  @override
  State<Cable> createState() => _CableState();
}

class _CableState extends State<Cable> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool checkNumber = false;
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

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    super.initState();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  void dispose() {
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
    _tabController!.dispose();
    super.dispose();
  }

  TextEditingController iucNumber = TextEditingController();

  String? _mySelection;
  String? _selectedPlan;
  int? _selectedIndex;
  String selectedLoan = '';

  final List<Map> _myJson = [
    {
      'id': 'dstv',
      'image': 'images/operators/dstv.png',
      'name': 'DSTV',
    },
    {
      'id': 'gotv',
      'image': 'images/operators/gotv.png',
      'name': 'GOTV',
    },
    {
      'id': 'startime',
      'image': 'images/operators/startime.png',
      'name': 'STARTIME',
    },
  ];

  final List<Map> _cablePlan = [
    {
      'id': '1',
      'image': 'images/operators/mtn.png',
      'name': 'African magic',
    },
    {
      'id': '2',
      'image': 'images/operators/airtel.png',
      'name': 'BBC Nigeria',
    },
    {
      'id': '3',
      'image': 'images/operators/9mobile.png',
      'name': 'Zee worlds',
    },
  ];

  Widget buildCableType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          //padding: EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(15),
              hint: const Text('Select Cable Provider'),
              underline: Container(
                height: 1,
                color: ColorManager.primaryColor,
              ),
              value: _mySelection,
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
                      Radio<String>(
                        value: option['name'],
                        groupValue: _mySelection ?? "Select",
                        //label: option['name'],
                        activeColor: ColorManager.primaryColor,
                        onChanged: (value) {
                          setState(() {
                            _mySelection = value;
                            Navigator.pop(context);
                          });
                        },
                      )
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

  Widget buildCablePlan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(15),
              hint: const Text('Select Buoquet'),
              underline: Container(
                height: 1,
                color: ColorManager.primaryColor,
              ),
              value: _selectedPlan,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  _selectedPlan = value;
                });
              },
              items: _cablePlan.map((option) {
                return DropdownMenuItem<String>(
                  value: option['name'],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(option['name']),
                      ),
                      Radio<String>(
                        value: option['name'],
                        groupValue: _selectedPlan ?? "Select",
                        activeColor: ColorManager.primaryColor,
                        onChanged: (value) {
                          setState(() {
                            _selectedPlan = value;
                            Navigator.pop(context);
                          });
                        },
                      )
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

  Widget buildCardNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorManager.primaryColor)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.primaryColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.primaryColor),
                  ),
                  //contentPadding: EdgeInsets.only(top: 0.0, left: 20),
                  hintText: 'Enter smart card number',
                  hintStyle: const TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorManager.primaryColor)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.primaryColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.primaryColor),
                  ),
                  //contentPadding: EdgeInsets.only(top: 0.0, left: 20),
                  hintText: 'Enter email address',
                  hintStyle: const TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

  Widget buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorManager.primaryColor)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.primaryColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.primaryColor),
                  ),
                  //contentPadding: EdgeInsets.only(top: 0.0, left: 20),
                  hintText: 'Enter phone number',
                  hintStyle: const TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Cable"),
      body: BaseView(
        vmBuilder: (context) => CableProvider(context: context),
        builder: _buildScreen,
      ),
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       icon: Icon(
      //         Icons.arrow_back,
      //         color: ColorManager.blackColor,
      //       )),
      //   title: Text(
      //     "TV",
      //     style: getBoldStyle(color: ColorManager.blackColor).copyWith(fontSize: 16),
      //   ),
      //   backgroundColor: ColorManager.greyColor,
      //   elevation: 0,
      // ),
      // body: SafeArea(
      //   child: SingleChildScrollView(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           buildCableType(),
      //           UIHelper.verticalSpaceSmall,
      //           buildCablePlan(),
      //           UIHelper.verticalSpaceSmall,
      //           buildEmail(),
      //           UIHelper.verticalSpaceSmall,
      //           buildCardNumber(),
      //           UIHelper.verticalSpaceSmall,
      //           buildPhoneNumber(),
      //           UIHelper.verticalSpaceMedium,
      //           Text(
      //             "Loan terms(days)",
      //             style: getBoldStyle(color: ColorManager.blackColor)
      //                 .copyWith(fontSize: 18),
      //           ),
      //           UIHelper.verticalSpaceSmall,
      //           UIHelper.verticalSpaceSmall,
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: List.generate(
      //               loanPeriod.length,
      //               (index) => Expanded(
      //                 child: SelectLoanPeriod(
      //                   accountType: loanPeriod[index]['name'],
      //                   active: _selectedIndex == index ? true : false,
      //                   onPressed: () {
      //                     setState(() {
      //                       if (_selectedIndex == index) {
      //                         _selectedIndex = null;
      //                       } else {
      //                         _selectedIndex = index;
      //                       }
      //                       selectedLoan =
      //                           "${loanPeriod[_selectedIndex!]["name"]}";
      //                     });
      //                   },
      //                 ),
      //               ),
      //             ),
      //           ),
      //           UIHelper.verticalSpaceMedium,
      //           Text(
      //             "By submitting, you agreed that all information provided are right.",
      //             textAlign: TextAlign.start,
      //             style: getRegularStyle(color: ColorManager.blackColor),
      //           ),
      //           UIHelper.verticalSpaceLarge,
      //           AppButton(
      //             onPressed: () {},
      //             buttonText: "Submit",
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Widget _buildScreen(BuildContext context, CableProvider cableProvider) {
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
                  //!const VtuCountrySelector(),
                  SelectCable(
                    cableProvider: cableProvider,
                  ),
                  UIHelper.verticalSpaceMedium,
                  selectCableCategories(cableProvider, context),
                  UIHelper.verticalSpaceMedium,
                  //! ------------ amount---------
                  cableProvider.cableCode != null
                      ? Text(
                          "Amount",
                          style: getBoldStyle(
                            color: ColorManager.deepGreyColor,
                            fontSize: 14,
                          ),
                        )
                      : Container(),
                  UIHelper.verticalSpaceSmall,
                  cableProvider.cableCode != null
                      ? BuildAmount(
                          cableProvider: cableProvider,
                        )
                      : Container(),
                  UIHelper.verticalSpaceMedium,
                  //! IUC number

                  buildIucNumber(),
                  UIHelper.verticalSpaceMedium,
                  checkNumber
                      ? FutureBuilder<VerifyIucData?>(
                          future: cableProvider.verifyIucNumber(
                            ctx: context,
                            iuc: iucNumber.text.trim(),
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator(); // Show loading indicator while waiting
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData &&
                                snapshot.data != null) {
                              cableProvider.setCustomerName(
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
                                'Invalid iuc number',
                                style: getBoldStyle(
                                    color: ColorManager.primaryColor,
                                    fontSize: 16),
                              );
                            }
                          },
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
                          onPressed: () {
                            if (cableProvider.customerName != null) {
                              if (cableProvider.cableName != null ||
                                  cableProvider.cableCode != null) {
                                _confirmationBottomSheetMenu(
                                  amount: cableProvider.cablePlan!.price,
                                  number: cableProvider.customerNumber!,
                                  provider: cableProvider,
                                );
                              } else {
                                MekNotification().showMessage(
                                  context,
                                  message: "Please a cable tv and plan !!!",
                                );
                              }
                            } else {
                              MekNotification().showMessage(
                                context,
                                message: "Unverified iuc number !!!",
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
            contentTwo: Column(
              children: [
                //!const VtuCountrySelector(),
                SelectCable(
                  cableProvider: cableProvider,
                ),
                UIHelper.verticalSpaceMedium,
                selectCableCategories(cableProvider, context),
                UIHelper.verticalSpaceMedium,
                //! ------------ amount---------
                cableProvider.cableCode != null
                    ? Text(
                        "Amount",
                        style: getBoldStyle(
                          color: ColorManager.deepGreyColor,
                          fontSize: 14,
                        ),
                      )
                    : Container(),
                UIHelper.verticalSpaceSmall,
                cableProvider.cableCode != null
                    ? BuildAmount(
                        cableProvider: cableProvider,
                      )
                    : Container(),
                UIHelper.verticalSpaceMedium,
                //! IUC number

                buildIucNumber(),
                UIHelper.verticalSpaceMedium,
                checkNumber
                    ? FutureBuilder<VerifyIucData?>(
                        future: cableProvider.verifyIucNumber(
                          ctx: context,
                          iuc: iucNumber.text.trim(),
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Show loading indicator while waiting
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData &&
                              snapshot.data != null) {
                            cableProvider.setCustomerName(
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
                              'Invalid iuc number',
                              style: getBoldStyle(
                                  color: ColorManager.primaryColor,
                                  fontSize: 16),
                            );
                          }
                        },
                      )
                    : Container(),
                UIHelper.verticalSpaceMedium,
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        buttonText: "Submit",
                        onPressed: () {
                          //_confirmationBottomSheetMenu(amount: "", );
                          if (cableProvider.customerName != null) {
                            if (cableProvider.cableName != null ||
                                cableProvider.cableCode != null) {
                              _confirmationBottomSheetMenu(
                                amount: cableProvider.cablePlan!.price,
                                number: cableProvider.customerNumber!,
                                provider: cableProvider,
                              );
                            } else {
                              MekNotification().showMessage(
                                context,
                                message: "Please a cable tv and plan !!!",
                              );
                            }
                          } else {
                            MekNotification().showMessage(
                              context,
                              message: "Unverified iuc number !!!",
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

  Widget buildIucNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "IUC number",
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
              controller: iucNumber,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Enter Iuc number',
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
                    ? cableProvider.cablePlan!.plan
                    : "Select Cable Plan",
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
                            height: 280,
                            child: Expanded(
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
                                                  AppConstants
                                                          .cablePlanModel![
                                                              index]
                                                          .plan
                                                          .toString() +
                                                      "------>${AppConstants.currencySymbol} ${AppConstants.cablePlanModel![index].price}",
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

  _otpInput(CableProvider provider, {required int topUp}) {
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
                            provider.purchaseCable(
                              ctx: context,
                              iuc: iucNumber.text.trim(),
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
      String? type = "Cable",
      required String number,
      int topUp = 1,
      required CableProvider provider}) {
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
                  "${AppConstants.currencySymbol} ${amount}.00",
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
                ? cableProvider.cablePlan!.price
                : "Loading...",
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
                            label: "List of channels",
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
                                      cableProvider.cablePlan!.channels.length,
                                      (index) {
                                    return InkWell(
                                      onTap: () {
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
                                              cableProvider
                                                  .cablePlan!.channels[index],
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
                      ? cableProvider.cableCode!.toUpperCase().substring(0, 2)
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
