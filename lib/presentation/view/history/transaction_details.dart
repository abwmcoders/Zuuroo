import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/resources.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Transaction Details"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorManager.whiteColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(ImageAssets.mtn),
                    UIHelper.verticalSpaceSmall,
                    Text(
                      "MTN",
                      style: getRegularStyle(
                        color: ColorManager.blackColor,
                        fontSize: 12,
                      ),
                    ),
                    UIHelper.verticalSpaceSmall,
                    Text(
                      "₦ 2000.00",
                      style: getBoldStyle(
                        color: ColorManager.blackColor,
                        fontSize: 14,
                      ),
                    ),
                    UIHelper.verticalSpaceSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: screenAwareSize(40, context),
                          width: screenAwareSize(40, context),
                          //padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.activeColor,
                          ),
                          child: Icon(
                            Icons.check,
                            color: ColorManager.whiteColor,
                            size: 20,
                          ),
                        ),
                        UIHelper.horizontalSpaceSmall,
                        Text(
                          "Successful",
                          style: getBoldStyle(
                            color: ColorManager.activeColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              UIHelper.verticalSpaceMedium,
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorManager.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Transactions details",
                      style: getBoldStyle(
                        color: ColorManager.blackColor,
                        fontSize: 13,
                      ),
                    ),
                    UIHelper.verticalSpaceSmall,
                    const DeatilsTile(
                      value: "Payment Number",
                      detail: "0806789435",
                    ),
                    const DeatilsTile(
                      value: "Payment Type",
                      detail: "Airtime",
                    ),
                    const DeatilsTile(
                      value: "Payment Method",
                      detail: "Loan",
                    ),
                    const DeatilsTile(
                      value: "Transaction Number",
                      detail: "575849394857678348",
                    ),
                    const DeatilsTile(
                      value: "Transaction Date",
                      detail: "July 12th,2024 09:45 :35",
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpaceLarge,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: AppButton(
                      buttonText: "Report Issue",
                      onPressed: () {},
                    ),
                  ),
                  UIHelper.horizontalSpaceSmall,
                  Expanded(
                    child: AppButton(
                      buttonText: "Chat with support",
                      onPressed: () {},
                      buttonColor: ColorManager.whiteColor,
                      buttonTextColor: ColorManager.primaryColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DeatilsTile extends StatelessWidget {
  const DeatilsTile({
    super.key,
    required this.value,
    required this.detail,
  });

  final String value, detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: getRegularStyle(
              color: ColorManager.deepGreyColor,
              fontSize: 12,
            ),
          ),
          Text(
            detail,
            style: getBoldStyle(
              color: ColorManager.deepGreyColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class SimpleAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SimpleAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<SimpleAppBar> createState() => _SimpleAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _SimpleAppBarState extends State<SimpleAppBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50.0),
      child: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: ColorManager.whiteColor,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        centerTitle: false,
        title: Text(
          widget.title,
          style: getRegularStyle(color: ColorManager.blackColor, fontSize: 18),
        ),
      ),
    );
  }
}
