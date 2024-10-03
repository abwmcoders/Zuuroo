import 'package:flutter/material.dart';

import '../../../resources/resources.dart';

class HWidgetHomeCards extends StatelessWidget {
  final String? cardPicturePath;
  final VoidCallback? onTap;
  final String? cardLabel;
  final Color? cardColor;
  final Color? textColor;
  final String? cardLabelDetails;
  final String? cardAmount;
  final String? imageUrl;
  final IconData? icon;

  HWidgetHomeCards({
    this.cardAmount,
    this.onTap,
    this.cardLabel,
    this.cardColor,
    this.cardLabelDetails,
    this.cardPicturePath,
    this.textColor,
    this.imageUrl,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return HWidgetDisplayTopCard(
        imageUrl: imageUrl,
        cardChildren: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Image.asset(cardPicturePath!),
            ),
            UIHelper.horizontalSpaceMedium,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardLabel!,
                    style: getBoldStyle(color: ColorManager.whiteColor).copyWith(
                      fontSize: screenAwareSize(28, context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  UIHelper.verticalSpaceSmall,
                  // Text(
                  //   cardLabelDetails!,
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w400,
                  //     color: textColor,
                  //   ),
                  // ),
                  //UIHelper.verticalSpaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cardAmount!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      IconButton(
                        onPressed: onTap,
                        icon: Icon(
                          icon,
                          color: cardColor,
                          size: 20, // Adjust the icon size
                        ),
                        padding: const EdgeInsets.all(
                            8), // Adjust padding around the icon
                        color: Colors.white, // Adjust the icon color
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class HWidgetDisplayTopCard extends StatelessWidget {
  final Widget? cardChildren;
  final Color? color;
  final String? imageUrl;
  const HWidgetDisplayTopCard({
    this.cardChildren,
    this.color,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(
            imageUrl!,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: ColorManager.blackColor.withOpacity(.8)),
          child: cardChildren),
    );
  }
}
