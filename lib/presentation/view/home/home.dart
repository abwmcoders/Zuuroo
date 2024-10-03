import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/animation/navigator.dart';
import '../../resources/resources.dart';
import 'components/dashboard_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _showBalance = false;
  bool _showLoanBalance = false;
  int current = 0;

  void _toggleBalance() {
    setState(() {
      _showBalance = !_showBalance; // Toggle the value
    });
  }

  void _toggleLoanBalance() {
    setState(() {
      _showLoanBalance = !_showLoanBalance; // Toggle the value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: screenAwareSize(50, context),
                          width: screenAwareSize(50, context),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.greyColor,
                          ),
                        ),
                        UIHelper.horizontalSpaceSmall,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello TheMade!",
                              style:
                                  getBoldStyle(color: ColorManager.blackColor)
                                      .copyWith(fontSize: 16),
                            ),
                            Text(
                              "Welcome!",
                              style:
                                  getBoldStyle(color: ColorManager.blackColor)
                                      .copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SvgPicture.asset(ImageAssets.not)
                  ],
                ),
                UIHelper.verticalSpaceSmall,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Available Balance",
                                style: getSemiBoldStyle(
                                  color: ColorManager.blackColor,
                                  fontSize: 14,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_downward,
                                ),
                              ),
                              IconButton(
                                onPressed: _toggleBalance,
                                icon: Icon(
                                  _showBalance
                                      ? Icons.visibility_off
                                      : Icons.remove_red_eye,
                                  color: _showBalance
                                      ? ColorManager.greyColor
                                      : ColorManager.blackColor,
                                  size: 20, // Adjust the icon size
                                ),
                                padding: const EdgeInsets.all(
                                    8), // Adjust padding around the icon
                                color: Colors.white, // Adjust the icon color
                              )
                            ],
                          ),
                          Text(
                            _showBalance ? "₦ 12,000" : "********",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: _showBalance
                                  ? ColorManager.blackColor
                                  : ColorManager.greyColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          UIHelper.verticalSpaceLarge,
                          InkWell(
                            onTap: () {
                              NavigateClass().pushNamed(
                                context: context,
                                routName: Routes.addMoney,
                              );
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                    gradient: ColorManager.buttonGradient,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: ColorManager.whiteColor,
                                      size: 20,
                                    ),
                                    UIHelper.horizontalSpaceSmall,
                                    Text(
                                      "Add Money",
                                      style: getBoldStyle(
                                        color: ColorManager.whiteColor,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: deviceHeight(context),
                  decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...List.generate(
                        services.length,
                        (index) {
                          return InkWell(
                            onTap: () {
                              NavigateClass().pushNamed(
                                context: context,
                                routName: "/${services[index].name}",
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: ColorManager.primaryColor
                                        .withOpacity(.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: SvgPicture.asset(
                                      services[index].imageUrl),
                                ),
                                UIHelper.verticalSpaceSmall,
                                Text(
                                  services[index].name,
                                  style: getRegularStyle(
                                    color: ColorManager.blackColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Transaction History",
                            style: getBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "View all",
                            style: getRegularStyle(
                                color: ColorManager.blackColor, fontSize: 14),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpaceSmall,
                      ...List.generate(5, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: screenAwareSize(50, context),
                                    width: screenAwareSize(50, context),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorManager.primaryColor
                                          .withOpacity(.2),
                                    ),
                                    child: SvgPicture.asset(ImageAssets.airt),
                                  ),
                                  UIHelper.horizontalSpaceSmall,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Airtime",
                                        style: getRegularStyle(
                                          color: ColorManager.blackColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "July 12th, 11:45:04",
                                        style: getRegularStyle(
                                          color: ColorManager.blackColor,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "₦ 2000.00",
                                    style: getRegularStyle(
                                      color: ColorManager.blackColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: ColorManager.activeColor
                                          .withOpacity(.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "Successful",
                                      style: getRegularStyle(
                                        color: ColorManager.activeColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceModel {
  final String name, imageUrl;

  ServiceModel({
    required this.imageUrl,
    required this.name,
  });
}

List<ServiceModel> services = [
  ServiceModel(
    imageUrl: ImageAssets.airt,
    name: "Airtime",
  ),
  ServiceModel(
    imageUrl: ImageAssets.data,
    name: "Data",
  ),
  ServiceModel(
    imageUrl: ImageAssets.bet,
    name: "Betting",
  ),
  ServiceModel(
    imageUrl: ImageAssets.elect,
    name: "Electricity",
  ),
];
