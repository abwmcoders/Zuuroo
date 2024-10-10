import 'package:flutter/material.dart';
import 'package:zuuro/app/app_constants.dart';

import '../../../app/animation/navigator.dart';
import '../../resources/resources.dart';
import '../home/home.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            children: [

                Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: ColorManager.primaryColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Available Balance",
                              style: getSemiBoldStyle(
                                color: ColorManager.blackColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Money added through deposit",
                              style: getRegularStyle(
                                color: ColorManager.deepGreyColor,
                                fontSize: 12,
                              ),
                            ),
                           
                          ],
                        ),
                       UIHelper.verticalSpaceMedium,
                        Text(
                          AppConstants.homeModel != null ? formatCurrency(
                                  double.parse(AppConstants
                                      .homeModel!.data.wallet.balance),
                                ) : "₦ 0,000",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: ColorManager.blackColor
                                ,
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
                          onTap: (){
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
                              ),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
                UIHelper.verticalSpaceMedium,
                Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: ColorManager.secondaryColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Loan Balance",
                              style: getSemiBoldStyle(
                                color: ColorManager.blackColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Money lend to you",
                              style: getRegularStyle(
                                color: ColorManager.deepGreyColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceMedium,
                        Text(
                          AppConstants.homeModel != null
                              ? formatCurrency(
                                  double.parse(AppConstants
                                      .homeModel!.data.wallet.loanBalance),
                                )
                              : "₦ 0,000",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: ColorManager.blackColor
                                ,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        UIHelper.verticalSpaceLarge,
                        Container(
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
                                  "Pay Up",
                                  style: getBoldStyle(
                                    color: ColorManager.whiteColor,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),),
                      ],
                    ),
                  ],
                ),
              ),
                UIHelper.verticalSpaceMedium,
            ],
          ),
        ),
      )),
    );
  }
}