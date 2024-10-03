import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/animation/navigator.dart';
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

  TextEditingController meterNumber = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController amountTopay = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController amount = TextEditingController();

  String? _mySelection;
  String? meterTypeInput;
  int? _selectedIndex;
  String selectedLoan = '';

 
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

  final List<Map> _myJson = [
    {
      'id': 'abuja-electric',
      'image': 'images/operators/aedc.png',
      'name': 'Abuja Electric',
    },
    {
      'id': 'benin-electric',
      'image': 'images/operators/bedc.png',
      'name': 'Benin Electric',
    },
    {
      'id': 'eko-electric',
      'image': 'images/operators/ekedp.jpg',
      'name': 'Eko Electric',
    },
    {
      'id': 'enugu-electric',
      'image': 'images/operators/eedc.png',
      'name': 'Enugu Electric',
    },
    {
      'id': 'ibadan-electric',
      'image': 'images/operators/ibedc.png',
      'name': 'Ibadan Electric',
    },
    {
      'id': 'ikeja-electric',
      'image': 'images/operators/ikedp.png',
      'name': 'Ikeja Electric',
    },
    {
      'id': 'jos-electric',
      'image': 'images/operators/jedc.jpg',
      'name': 'Jos Electric',
    },
    {
      'id': 'kaduna-electric',
      'image': 'images/operators/kaedc.png',
      'name': 'Kaduna Electric',
    },
    {
      'id': 'kano-electric',
      'image': 'images/operators/kedc.png',
      'name': 'Kano Electric',
    },
    {
      'id': 'portharcourt-electric',
      'image': 'images/operators/phedc.png',
      'name': 'Port Harcourt Electric',
    },
    {
      'id': 'yola-electric',
      'image': 'images/operators/yedc.jfif',
      'name': 'Yola Electric',
    },
  ];

  Widget buidBill() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          "Electric provider",
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
              hint: Text('Select electric provider', style: getRegularStyle(color: ColorManager.deepGreyColor, fontSize: 13,),),
              underline: Container(
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

  Widget builMeterType() {
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
          //padding: EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            color: ColorManager.greyColor.withOpacity(.4),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(15),
              hint: Text('Select Meter Type',
                style: getRegularStyle(
                  color: ColorManager.deepGreyColor,
                  fontSize: 13,
                ),
              ),
              underline: Container(
              ),
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
            child: TextField(
              keyboardType: TextInputType.number,
              controller: meterNumber,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Enter meter number',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )
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
              decoration: InputDecoration(
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
                    buidBill(),
                    UIHelper.verticalSpaceMedium,
                    builMeterType(),
                    UIHelper.verticalSpaceMedium,
                    buildMeterNumber(),
                    UIHelper.verticalSpaceMedium,
                     buildAmount(),
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
                  buidBill(),
                  UIHelper.verticalSpaceMedium,
                  builMeterType(),
                  UIHelper.verticalSpaceMedium,
                  buildMeterNumber(),
                  UIHelper.verticalSpaceMedium,
                  buildAmount(),
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
      //     "Electricity",
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
      //           buidBill(),
      //           UIHelper.verticalSpaceSmall,
      //           builMeterType(),
      //           UIHelper.verticalSpaceSmall,
      //           buildMeterNumber(),
      //           UIHelper.verticalSpaceSmall,
      //           buildAmount(),
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
      //                       selectedLoan = "${loanPeriod[_selectedIndex!]["name"]}";
      //                     });
      //                   },
      //                 ),
      //               ),
      //             ),
      //           ),
      //           UIHelper.verticalSpaceMedium,
      //           Text("By submitting, you agreed that all information provided are right.", textAlign: TextAlign.start, style: getRegularStyle(color: ColorManager.blackColor),),
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: active ? ColorManager.primaryColor.withOpacity(.3) : ColorManager.whiteColor,
          borderRadius: const BorderRadius.all(Radius.circular(30),),
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
              color: active ? ColorManager.primaryColor : ColorManager.blackColor,
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
