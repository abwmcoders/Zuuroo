import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zuuro/app/animation/navigator.dart';
import 'package:zuuro/presentation/resources/resources.dart';
import 'package:zuuro/presentation/view/history/transaction_details.dart';

class CardFunding extends StatelessWidget {
  const CardFunding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Card Funding"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Amount",
                    style: getRegularStyle(
                      color: ColorManager.blackColor,
                      fontSize: 14,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpaceSmall,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Funding Method",
                    style: getRegularStyle(
                      color: ColorManager.blackColor,
                      fontSize: 14,
                    ),
                  ),
                  UIHelper.verticalSpaceSmall,
                  ...List.generate(
                    4,
                    (index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.greyColor.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: screenAwareSize(60, context),
                                  width: screenAwareSize(60, context),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorManager.whiteColor,
                                  ),
                                ),
                                UIHelper.horizontalSpaceSmall,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Wema Bank",
                                      style: getBoldStyle(
                                          color: ColorManager.blackColor,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      "414488********4119",
                                      style: getRegularStyle(
                                          color: ColorManager.greyColor,
                                          fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            )
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
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: screenAwareSize(50, context),
                        width: screenAwareSize(50, context),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.primaryColor.withOpacity(.4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SvgPicture.asset(ImageAssets.card),
                        ),
                      ),
                      UIHelper.horizontalSpaceMedium,
                      Text(
                        "Add a Bank Card",
                        style: getBoldStyle(color: ColorManager.blackColor)
                            .copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpaceMedium,
            AppButton(
              buttonText: "Continue",
              onPressed: () {
                NavigateClass().pushReplacementNamed(
                  context: context,
                  routName: Routes.mainRoute,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
