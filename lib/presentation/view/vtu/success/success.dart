import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/animation/navigator.dart';
import '../../../resources/resources.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.amount});

  final String amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(ImageAssets.success),
              UIHelper.verticalSpaceMedium,
              Text(
                "Transaction Successful",
                style: getRegularStyle(
                    color: ColorManager.blackColor, fontSize: 15),
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                "₦ $amount",
                style:
                    getBoldStyle(color: ColorManager.blackColor, fontSize: 19),
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                "You will receive your purchased value within\n5 minutes max",
                textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: ColorManager.blackColor, fontSize: 12),
              ),
              UIHelper.verticalSpaceLarge,
              AppButton(
                onPressed: () {
                  NavigateClass().pushNamed(
                    context: context,
                    routName: Routes.mainRoute,
                  );
                },
                buttonText: "Home",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
