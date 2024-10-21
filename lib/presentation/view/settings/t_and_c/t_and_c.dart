import 'package:flutter/material.dart';
import 'package:zuuro/presentation/resources/resources.dart';
import 'package:zuuro/presentation/resources/style_manager.dart';

import 'package:zuuro/presentation/view/history/transaction_details.dart';

import '../../../../app/services/api_rep/user_services.dart';
import '../../vtu/airtime/airtime.dart';
import 'model/terms_model.dart';

class TAndC extends StatelessWidget {
  const TAndC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Terms and condition"),
      body: ContainerWidget(
        content: FutureBuilder(
          future: UserApiServices().getTerms(),
          builder: (context, snapshot) {
            print('terms beneficiaries ----> ${snapshot.data}');
            if (snapshot.hasData) {
              TermsResponse _terms = TermsResponse.fromJson(snapshot.data);
              if (_terms.data.length == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: screenAwareSize(300, context),
                            height: screenAwareSize(300, context),
                            child: Icon(
                              Icons.light_mode_sharp,
                              color: ColorManager.primaryColor,
                              size: 50,
                            ),
                            // child: Image.asset(
                            //     "assets/images/noRTransaction.png"),
                          ),
                          Text(
                            "You have no transaction history",
                            style: getBoldStyle(
                              color: ColorManager.blackColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Column(
                  children: [
                    ...List.generate(
                      _terms.data.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            _terms.data[index].writeUp,
                            style: getBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: screenAwareSize(300, context),
                          height: screenAwareSize(300, context),
                          child: Icon(
                            Icons.light_mode_sharp,
                            color: ColorManager.primaryColor,
                            size: 50,
                          ),
                          // child: Image.asset(
                          //     "assets/images/noRTransaction.png"),
                        ),
                        Text(
                          "An error occurred trying to get history\nPlease try again later",
                          textAlign: TextAlign.center,
                          style: getBoldStyle(
                            color: ColorManager.blackColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return WidgetListLoaderShimmer();
            } else {
              return WidgetListLoaderShimmer();
            }
          },
        ),
      ),
    );
  }
}
