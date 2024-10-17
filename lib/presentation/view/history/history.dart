import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zuuro/app/animation/navigator.dart';
import 'package:zuuro/presentation/resources/resources.dart';

import '../../../app/services/api_rep/user_services.dart';
import 'model/history_model.dart';

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
              height: screenAwareSize(900, context),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FutureBuilder(
                  future: UserApiServices().getHistories(),
                  builder: (context, snapshot) {
                    print(
                        'histories beneficiaries ----> ${snapshot.data}');
                    if (snapshot.hasData) {
                      HistoryResponse _history =
                          HistoryResponse.fromJson(snapshot.data);
                      if (_history.data.length == 0) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: screenAwareSize(300, context),
                                    height: screenAwareSize(300, context),
                                    child: Icon(
                                      Icons.light_mode_sharp,
                                      color: ColorManager.primaryColor,
                                      size: 50,
                                    ),
                                    // child: Image.asset(
                                    //     "assets/images/noRTransaction.png"),
                                  ),
                                  Text(
                                    "You have no transaction history",
                                    style: getBoldStyle(
                                      color: ColorManager.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      } else {
                        return ListView.builder(
                          itemCount: 5, //_cBeneficiary.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: screenAwareSize(
                                                50, context),
                                            width: screenAwareSize(
                                                50, context),
                                            padding:
                                                const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorManager
                                                  .primaryColor
                                                  .withOpacity(.2),
                                            ),
                                            child: Center(
                                                child: Text(
                                              _history.data[index]
                                                  .operatorCode
                                                  .substring(0, 2)
                                                  .toUpperCase(),
                                              style: getBoldStyle(
                                                color: ColorManager
                                                    .blackColor,
                                                fontSize: 18,
                                              ),
                                            )),
                                            // child: SvgPicture.asset(ImageAssets.airt),
                                          ),
                                          UIHelper.horizontalSpaceSmall,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _history
                                                    .data[index].purchase,
                                                style: getRegularStyle(
                                                  color: ColorManager
                                                      .blackColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                //"July 12th, 11:45:04",
                                                _history.data[index]
                                                    .completedUtc,
                                                style: getRegularStyle(
                                                  color: ColorManager
                                                      .blackColor,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            //"₦ 2000.00",
                                            "₦ ${_history.data[index].sellingPrice}",
                                            style: getRegularStyle(
                                              color:
                                                  ColorManager.blackColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 5,
                                                vertical: 5),
                                            decoration: BoxDecoration(
                                              color: _history.data[index]
                                                          .processingState ==
                                                      "failed"
                                                  ? ColorManager
                                                      .errorColor
                                                  : _history.data[index]
                                                              .processingState ==
                                                          "pending"
                                                      ? ColorManager
                                                          .pendColor
                                                      : ColorManager
                                                          .activeColor
                                                          .withOpacity(
                                                              .2),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10),
                                            ),
                                            child: Text(
                                              //"Successful",
                                              _history.data[index]
                                                  .processingState
                                                  .toString(),
                                              style: getRegularStyle(
                                                color: ColorManager
                                                    .activeColor,
                                                fontSize: 10,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                UIHelper.verticalSpaceSmall,
                                Divider(),
                              ],
                            );
                          },
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: screenAwareSize(300, context),
                                  height: screenAwareSize(300, context),
                                  child: Icon(
                                    Icons.light_mode_sharp,
                                    color: ColorManager.primaryColor,
                                    size: 50,
                                  ),
                                  // child: Image.asset(
                                  //     "assets/images/noRTransaction.png"),
                                ),
                                Text(
                                  "An error occurred trying to get history\nPlease try again later",
                                  textAlign: TextAlign.center,
                                  style: getBoldStyle(
                                    color: ColorManager.blackColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return WidgetListLoaderShimmer();
                    } else {
                      return WidgetListLoaderShimmer();
                    }
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
