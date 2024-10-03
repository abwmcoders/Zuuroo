import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zuuro/presentation/view/history/transaction_details.dart';

import '../../../../app/animation/navigator.dart';
import '../../../resources/resources.dart';
import '../elect/elect.dart';

class Airtime extends StatefulWidget {
  const Airtime({super.key});

  @override
  State<Airtime> createState() => _AirtimeState();
}

class _AirtimeState extends State<Airtime> with SingleTickerProviderStateMixin {
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

  int? _selectedIndex;
  String selectedLoan = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Airtime"),
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
                    AppAmountField(),
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
                    AppAmountField(
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
                  AppAmountField(),
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
                  padding: const EdgeInsets.only(bottom: 10.0, top: 10.0,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment Type", style: getRegularStyle(color: ColorManager.deepGreyColor, fontSize: 12,),),
                      Row(
                        children: [
                          SvgPicture.asset(ImageAssets.mtn,),
                          Text("Airtime", style: getBoldStyle(color: ColorManager.blackColor, fontSize: 12,),),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 10.0,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment Number", style: getRegularStyle(color: ColorManager.deepGreyColor, fontSize: 12,),),
                      Text("0806789435", style: getBoldStyle(color: ColorManager.blackColor, fontSize: 12,),),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceSmall,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    color: ColorManager.greyColor.withOpacity(.5),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Loan Balance", style: getBoldStyle(color: ColorManager.blackColor, fontSize: 12,),),
                          Text("( ₦ 100,000)", style: getRegularStyle(color: ColorManager.deepGreyColor, fontSize: 12,),),
                        ],
                      ),
                      Icon(Icons.check, color: ColorManager.primaryColor,)
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

class AppAmountField extends StatelessWidget {
  const AppAmountField({
    super.key,
    this.title,
  });

  final String? title;

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
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontFamily: "NT",
              color: ColorManager.blackColor,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
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
  });

  final Widget content;

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
          color: ColorManager.whiteColor,
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
