import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zuuro/app/animation/navigator.dart';
import 'package:zuuro/presentation/view/history/transaction_details.dart';

import '../../resources/resources.dart';

class AddMoney extends StatelessWidget {
  const AddMoney({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Add Money"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Column(
          children: [
            AddMoneyTile(
              imageUrl: ImageAssets.tf,
              title: "Automated Bank Transfer",
              subtile: "₦50 charges applied on all deposit",
              onPressed: () {
                NavigateClass().pushNamed(
                  context: context,
                  routName: Routes.bankTransfer,
                );
              },
            ),
            AddMoneyTile(
              imageUrl: ImageAssets.card,
              title: "Card Funding",
              subtile: "₦50 charges applied on all deposit",
              onPressed: () {
                NavigateClass().pushNamed(
                  context: context,
                  routName: Routes.cardFunding,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddMoneyTile extends StatelessWidget {
  const AddMoneyTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtile,
    required this.onPressed,
  });

  final String title, subtile, imageUrl;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: SvgPicture.asset(imageUrl),
                ),
              ),
              UIHelper.horizontalSpaceSmall,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getBoldStyle(color: ColorManager.blackColor)
                        .copyWith(fontSize: 14),
                  ),
                  Text(
                    subtile,
                    //overflow: TextOverflow.ellipsis,
                    style: getRegularStyle(color: ColorManager.greyColor)
                        .copyWith(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }
}
