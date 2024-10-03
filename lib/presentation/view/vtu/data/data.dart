import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zuuro/presentation/resources/color_manager.dart';
import 'package:zuuro/presentation/resources/style_manager.dart';

import '../../../../app/animation/navigator.dart';
import '../../../resources/resources.dart';
import '../../history/transaction_details.dart';
import '../airtime/airtime.dart';
import '../elect/elect.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> with SingleTickerProviderStateMixin {

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
              hint: Text('Select network provider', style: getRegularStyle(color: ColorManager.deepGreyColor, fontSize: 13,),),
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
              underline: Container(
              ),
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
                    buidDataPlan() ,
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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
