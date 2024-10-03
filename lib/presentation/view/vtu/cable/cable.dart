import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/animation/navigator.dart';
import '../../../resources/resources.dart';
import '../../history/transaction_details.dart';
import '../airtime/airtime.dart';
import '../elect/elect.dart';

class Cable extends StatefulWidget {
  const Cable({super.key});

  @override
  State<Cable> createState() => _CableState();
}

class _CableState extends State<Cable> with SingleTickerProviderStateMixin{

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


  TextEditingController email = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

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
              hint: Text('Select Cable Provider'),
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
              hint: Text('Select Buoquet'),
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
              controller: cardNumber,
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
                  hintStyle: TextStyle(color: Colors.black38)),
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
              controller: phoneNumber,
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
                  hintStyle: TextStyle(color: Colors.black38)),
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
              controller: phoneNumber,
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
              contentTwo: Column(
                children: [
                  const VtuCountrySelector(),
                  UIHelper.verticalSpaceMedium,
                  const AppNumberField(),
                  UIHelper.verticalSpaceMedium,
                  
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
                            "Electricity",
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
