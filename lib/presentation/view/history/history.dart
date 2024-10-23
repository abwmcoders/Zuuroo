import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zuuro/app/animation/navigator.dart';
import 'package:zuuro/presentation/resources/resources.dart';

import '../../../app/services/api_rep/user_services.dart';
import '../vtu/elect/elect.dart';
import 'model/history_model.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  bool openCat = false;
  bool openStatus = false;
  int? _selectedIndexCat;
  int? _selectedIndexStatus;
  String selectedCat = '';
  String selectedStatus = '';
  Future? fetchHistoryData;

  final List<Map> categories = [
    {
      'id': 1,
      'name': 'airtime',
    },
    {
      'id': 2,
      'name': 'data',
    },
    {
      'id': 3,
      'name': 'cable',
    },
    {
      'id': 4,
      'name': 'electricity',
    },
    {
      'id': 4,
      'name': 'betting',
    },
  ];

  final List<Map> status = [
    {
      'id': 1,
      'name': 'failed',
    },
    {
      'id': 2,
      'name': 'delivered',
    },
  ];

  @override
  void initState() {
    fetchHistoryData = UserApiServices().getHistories();
    super.initState();
  }

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
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
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
                  UIHelper.verticalSpaceMedium,
                  openCat
                      ? SizedBox(
                          height: 80,
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: categories.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: 30,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return CategorySelection(
                                accountType: categories[index]['name'],
                                active:
                                    _selectedIndexCat == index ? true : false,
                                onPressed: () {
                                  setState(() {
                                    if (_selectedIndexCat == index) {
                                      _selectedIndexCat = null;
                                    } else {
                                      _selectedIndexCat = index;
                                    }
                                    selectedCat =
                                        "${categories[_selectedIndexCat!]["name"]}";
                                    fetchHistoryData = UserApiServices()
                                        .getHistories(
                                            params: selectedCat,
                                          );
                                  });
                                },
                              );
                            },
                          ),
                        )
                      : openStatus
                          ? SizedBox(
                              height: 50,
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: status.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisExtent: 30,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return CategorySelection(
                                    accountType: status[index]['name'],
                                    active: _selectedIndexStatus == index
                                        ? true
                                        : false,
                                    onPressed: () {
                                      setState(() {
                                        if (_selectedIndexStatus == index) {
                                          _selectedIndexStatus = null;
                                        } else {
                                          _selectedIndexStatus = index;
                                        }
                                        selectedStatus =
                                            "${status[_selectedIndexStatus!]["name"]}";
                                        fetchHistoryData = UserApiServices()
                                            .getHistories(
                                                params: selectedStatus,
                                                isStatus: true);
                                      });
                                    },
                                  );
                                },
                              ),
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
                  future: fetchHistoryData,
                  builder: (context, snapshot) {
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
                          itemCount: _history
                              .data.length, //_cBeneficiary.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: InkWell(
                                    onTap: () {
                                      NavigateClass().pushNamed(
                                        context: context,
                                        routName: Routes.transactionDetail,
                                        args: _history.data[index],
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height:
                                                  screenAwareSize(60, context),
                                              width:
                                                  screenAwareSize(60, context),
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ColorManager.primaryColor
                                                    .withOpacity(.2),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                _history
                                                    .data[index].operatorCode
                                                    .substring(0, 2)
                                                    .toUpperCase(),
                                                style: getBoldStyle(
                                                  color:
                                                      ColorManager.blackColor,
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
                                                  _history.data[index].purchase,
                                                  style: getBoldStyle(
                                                    color:
                                                        ColorManager.blackColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                UIHelper.verticalSpaceSmall,
                                                Text(
                                                  //"July 12th, 11:45:04",
                                                  _history
                                                      .data[index].completedUtc,
                                                  style: getRegularStyle(
                                                    color:
                                                        ColorManager.blackColor,
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
                                              style: getBoldStyle(
                                                color: ColorManager.blackColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                            UIHelper.verticalSpaceSmall,
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                color: _history.data[index]
                                                            .processingState !=
                                                        "delivered"
                                                    ? ColorManager.errorColor
                                                        .withOpacity(.1)
                                                    :  ColorManager
                                                            .activeColor
                                                            .withOpacity(.1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                //"Successful",
                                                _history
                                                    .data[index].processingState
                                                    .toString(),
                                                style: getRegularStyle(
                                                  color: _history.data[index]
                                                              .processingState !=
                                                          "delivered"
                                                      ? ColorManager.errorColor
                                                      : ColorManager
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

class CategorySelection extends StatelessWidget {
  const CategorySelection({
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: active
              ? ColorManager.primaryColor.withOpacity(.2)
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
            accountType.toUpperCase(),
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
