import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zuuro/app/animation/navigator.dart';
import 'package:zuuro/presentation/resources/resources.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  bool openCat = false;
  bool openStatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "All Categories",
                            style: getBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: 14,
                            ),
                          ),
                          UIHelper.horizontalSpaceSmall,
                          InkWell(
                              onTap: () {
                                if (openStatus) {
                                  setState(() {
                                    openStatus = false;
                                    openCat = !openCat;
                                  });
                                } else {
                                  setState(() {
                                    openCat = !openCat;
                                  });
                                }
                              },
                              child: const Icon(Icons.arrow_drop_down))
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Status",
                            style: getBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: 14,
                            ),
                          ),
                          UIHelper.horizontalSpaceSmall,
                          InkWell(
                              onTap: () {
                                if (openCat) {
                                  setState(() {
                                    openCat = false;
                                    openStatus = !openStatus;
                                  });
                                } else {
                                  setState(() {
                                    openStatus = !openStatus;
                                  });
                                }
                              },
                              child: const Icon(Icons.arrow_drop_down))
                        ],
                      ),
                    ],
                  ),
                  openCat
                      ? Container(
                          height: 50,
                        )
                      : openStatus
                          ? Container(
                              height: 90,
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "July",
                        style: getBoldStyle(
                          color: ColorManager.blackColor,
                          fontSize: 14,
                        ),
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                        color: ColorManager.greyColor,
                      )
                    ],
                  ),
                  UIHelper.verticalSpaceSmall,
                  ...List.generate(15, (index) {
                    return InkWell(
                      onTap: () {
                        NavigateClass().pushNamed(
                          context: context,
                          routName: Routes.transactionDetail,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: screenAwareSize(50, context),
                                  width: screenAwareSize(50, context),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorManager.primaryColor
                                        .withOpacity(.2),
                                  ),
                                  child: SvgPicture.asset(ImageAssets.airt),
                                ),
                                UIHelper.horizontalSpaceSmall,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  padding: EdgeInsets.symmetric(
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
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
