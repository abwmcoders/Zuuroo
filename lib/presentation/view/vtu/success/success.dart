import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/animation/navigator.dart';
import '../../../resources/resources.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(ImageAssets.success),
            UIHelper.verticalSpaceMedium,
            Text(
                "Transfer Successful",
                style:
                    getRegularStyle(color: ColorManager.blackColor, fontSize: 15),
              ),
              UIHelper.verticalSpaceSmall,
            Text(
                "₦ 2000.00",
                style:
                    getBoldStyle(color: ColorManager.blackColor, fontSize: 19),
              ),
              UIHelper.verticalSpaceSmall,
            Text(
                "You will receive your airtime within\n5 minutes",
                textAlign: TextAlign.center,
                style:
                    getRegularStyle(color: ColorManager.blackColor, fontSize: 12),
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