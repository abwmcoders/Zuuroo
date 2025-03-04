import 'package:flutter/material.dart';
import 'package:zuuro/presentation/resources/resources.dart';
import 'package:zuuro/presentation/view/history/transaction_details.dart';

import '../../../../app/app_constants.dart';

class BankTransfer extends StatelessWidget {
  const BankTransfer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "Automated Bank Transfer"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child:AppConstants.homeModel != null ? ListView(
          children: [
             ...List.generate(
              AppConstants.homeModel!.data.record.length,
              (index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        width: deviceWidth(context),
                        decoration: BoxDecoration(
                          color: ColorManager.greyColor.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          AppConstants.homeModel!.data.record[index]['account_name'],
                          style: getRegularStyle(
                            color: ColorManager.blackColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        width: deviceWidth(context),
                        decoration: BoxDecoration(
                          color: ColorManager.greyColor.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                         AppConstants
                                    .homeModel!.data.record[index]['account_number'],
                          style: getRegularStyle(
                            color: ColorManager.blackColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        width: deviceWidth(context),
                        decoration: BoxDecoration(
                          color: ColorManager.greyColor.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          AppConstants
                                    .homeModel!.data.record[index]['bank_name'],
                          style: getRegularStyle(
                            color: ColorManager.blackColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ) : Container(),
      ),
    );
  }
}
