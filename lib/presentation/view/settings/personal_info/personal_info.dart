import 'package:flutter/material.dart';
import 'package:zuuro/app/app_constants.dart';
import 'package:zuuro/presentation/view/home/model/home_model.dart';

import '../../../../app/animation/navigator.dart';
import '../../../resources/resources.dart';
import '../../history/transaction_details.dart';
import '../../vtu/airtime/airtime.dart';

class PersonalInfo extends StatelessWidget {
  PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    User user = AppConstants.homeModel!.data.user;
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
                gradient: ColorManager.buttonGradient
                //color: ColorManager.activeColor,
              ),
              child: Center(
                          child: Text(
                        AppConstants.homeModel != null
                            ? AppConstants.homeModel!.data.user.name
                                .substring(0, 2)
                                .toUpperCase()
                            : "",
                        style: getBoldStyle(
                          color: ColorManager.whiteColor,
                          fontSize: 25,
                        ),
                      ),),
            ),
            UIHelper.verticalSpaceLarge,

            RowTile(
              title: "Full name",
              value: user.name,
            ),
            RowTile(
              title: "Phone number",
              value: user.phoneNumber,
              valueTextColor: ColorManager.selectColor,
            ),
             RowTile(
              title: "Nickname",
              value: user.username.isEmpty ? "..." : user.username,
            ),
             RowTile(
              title: "Gender",
              value: user.gender != null ? user.gender!.toUpperCase() : "NILL",
            ),
             RowTile(
              title: "Date of birth",
              value: user.dateOfBirth != null ? user.dateOfBirth! : "--/--/----",
            ),
            RowTile(
              title: "Email",
              value: user.email,
              valueTextColor: ColorManager.selectColor,
            ),
             RowTile(
              title: "Address",
              value: user.address != null ? user.address! : "---------------",
            ),
           
            UIHelper.verticalSpaceSmall,
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: (){
                  NavigateClass().pushNamed(
                    context: context,
                    args: user,
                    routName: Routes.editProfile,
                  );
                },
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
            ),
          ],
        ),
      ),
    );
  }
}

class RowTile extends StatelessWidget {
  const RowTile({
    super.key,
    required this.title,
    required this.value,
    this.valueTextColor,
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
              style: getRegularStyle(
                  color: ColorManager.deepGreyColor, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 6,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                value,
                textAlign: TextAlign.start,
                style: getBoldStyle(
                    color: valueTextColor ?? ColorManager.blackColor,
                    fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
