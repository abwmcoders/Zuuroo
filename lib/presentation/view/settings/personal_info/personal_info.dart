import 'package:flutter/material.dart';

import '../../../resources/resources.dart';
import '../../history/transaction_details.dart';
import '../../vtu/airtime/airtime.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Personal Information"),
      body: ContainerWidget(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenAwareSize(120, context),
              width: screenAwareSize(120, context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.activeColor,
              ),
            ),
            UIHelper.verticalSpaceLarge,
            const RowTile(
              title: "Full name",
              value: "John Doe",
            ),
            RowTile(
              title: "Phone number",
              value: "+234679054435",
              valueTextColor: ColorManager.selectColor,
            ),
            const RowTile(
              title: "Nickname",
              value: "Johnny",
            ),
            const RowTile(
              title: "Gender",
              value: "Male",
            ),
            const RowTile(
              title: "Date of birth",
              value: "09/8/2000",
            ),
            RowTile(
              title: "Email",
              value: "Johndoe@gmail.com",
              valueTextColor: ColorManager.selectColor,
            ),
            const RowTile(
              title: "Address",
              value: "No 3,Aliafia street crescent, Lagos road",
            ),
            UIHelper.verticalSpaceSmall,
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                      gradient: ColorManager.buttonGradient,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Edit Profile",
                    style: getBoldStyle(
                      color: ColorManager.whiteColor,
                      fontSize: 12,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class RowTile extends StatelessWidget {
  const RowTile({
    super.key, required this.title, required this.value, this.valueTextColor,
  });

  final String title, value;
  final Color? valueTextColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style:
                  getRegularStyle(color: ColorManager.deepGreyColor, fontSize: 13),
            ),
          ),
          Expanded(
          flex: 6,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                value,
                textAlign: TextAlign.start,
                style: getBoldStyle(color: valueTextColor ?? ColorManager.blackColor, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
