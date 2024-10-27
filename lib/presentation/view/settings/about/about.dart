import 'package:flutter/material.dart';
import 'package:zuuro/presentation/resources/resources.dart';
import 'package:zuuro/presentation/resources/style_manager.dart';

import 'package:zuuro/presentation/view/history/transaction_details.dart';

import '../../../../app/services/api_rep/user_services.dart';
import '../../vtu/airtime/airtime.dart';
import 'model/model.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "About Us"),
      body: ContainerWidget(
        content: FutureBuilder(
          future: UserApiServices().getAbout(),
          builder: (context, snapshot) {
            print('about beneficiaries ----> ${snapshot.data}');
            if (snapshot.hasData) {
              print("about data true");
              AboutResponse _about = AboutResponse.fromJson(snapshot.data);
              if (_about.data.length == 0) {
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
                            "About information is not available at the moment",
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
             
              } else {
                return ListView.builder(
                  itemCount: 1, //_cBeneficiary.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        children: [
                          ...List.generate(
                            _about.data.length,
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20.0, top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _about.data[index].title,
                                      style: getBoldStyle(
                                        color: ColorManager.blackColor,
                                        fontSize: 20,
                                      ),
                                    ),
                                    UIHelper.verticalSpaceSmall,
                                    Text(
                                      _about.data[index].description,
                                      style: getBoldStyle(
                                        color: ColorManager.blackColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          // Container(
                          //   width: deviceWidth(context),
                          //   padding: const EdgeInsets.symmetric(
                          //     vertical: 15,
                          //   ),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(15),
                          //     color: ColorManager.whiteColor,
                          //   ),
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Container(
                          //         height: screenAwareSize(80, context),
                          //         width: screenAwareSize(80, context),
                          //         decoration: BoxDecoration(
                          //           shape: BoxShape.circle,
                          //           gradient: ColorManager.buttonGradient,
                          //         ),
                          //         child: Center(
                          //           child: Text(
                          //             _about.data.first.companyName
                          //                 .substring(0, 2)
                          //                 .toUpperCase(),
                          //             style: getBoldStyle(
                          //                 color: ColorManager.whiteColor,
                          //                 fontSize: 20),
                          //           ),
                          //         ),
                          //       ),
                          //       UIHelper.verticalSpaceSmall,
                          //       Text(
                          //         _about.data.first.companyName,
                          //         style: getRegularStyle(
                          //           color: ColorManager.blackColor,
                          //           fontSize: 12,
                          //         ),
                          //       ),
                          //       UIHelper.verticalSpaceSmall,
                          //       Text(
                          //         "Headquarters: ${_about.data.first.headquarters}",
                          //         style: getBoldStyle(
                          //           color: ColorManager.blackColor,
                          //           fontSize: 14,
                          //         ),
                          //       ),
                          //       UIHelper.verticalSpaceSmall,
                          //       Text(
                          //         "Email: ${_about.data.first.contactEmail}",
                          //         style: getBoldStyle(
                          //           color: ColorManager.blackColor,
                          //           fontSize: 14,
                          //         ),
                          //       ),
                          //       UIHelper.verticalSpaceSmall,
                          //       Text(
                          //         "Website: ${_about.data.first.websiteUrl}",
                          //         style: getBoldStyle(
                          //           color: ColorManager.blackColor,
                          //           fontSize: 14,
                          //         ),
                          //       ),
                          //       UIHelper.verticalSpaceSmall,
                          //       Text(
                          //         "Phone: ${_about.data.first.contactPhone}",
                          //         style: getBoldStyle(
                          //           color: ColorManager.blackColor,
                          //           fontSize: 14,
                          //         ),
                          //       ),
                          //       UIHelper.verticalSpaceSmall,
                          //     ],
                          //   ),
                          // ),
                          // UIHelper.verticalSpaceMedium,
                          // Container(
                          //   width: deviceWidth(context),
                          //   padding: const EdgeInsets.symmetric(
                          //     vertical: 15,
                          //     horizontal: 10,
                          //   ),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(15),
                          //     color: ColorManager.whiteColor,
                          //   ),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         "About Us",
                          //         style: getBoldStyle(
                          //           color: ColorManager.blackColor,
                          //           fontSize: 15,
                          //         ),
                          //       ),
                          //       UIHelper.verticalSpaceSmall,
                          //       Text(
                          //         _about.data.first.description,
                          //         style: getBoldStyle(
                          //           color: ColorManager.deepGreyColor,
                          //           fontSize: 13,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // UIHelper.verticalSpaceMedium,
                          // Container(
                          //   width: deviceWidth(context),
                          //   padding: const EdgeInsets.symmetric(
                          //     vertical: 15,
                          //     horizontal: 10,
                          //   ),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(15),
                          //     color: ColorManager.whiteColor,
                          //   ),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text(
                          //         "Services Offered",
                          //         style: getBoldStyle(
                          //           color: ColorManager.blackColor,
                          //           fontSize: 15,
                          //         ),
                          //       ),
                          //       UIHelper.verticalSpaceSmall,
                          //       ...List.generate(
                          //         _about.data.first.servicesOffered.length,
                          //         (index) => Text(
                          //           _about.data.first.servicesOffered[index],
                          //           style: getBoldStyle(
                          //             color: ColorManager.deepGreyColor,
                          //             fontSize: 13,
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // UIHelper.verticalSpaceLarge,
                        ],
                      ),
                    );
                  },
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
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return WidgetListLoaderShimmer();
            } else if(snapshot.data == null) {
              return Container(
                margin: EdgeInsets.all(20),
                height: deviceHeight(context) / 2,
                width: deviceWidth(context),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorManager.whiteColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.light_mode_sharp,
                            color: ColorManager.primaryColor,
                            size: 80,
                          ),
                          UIHelper.verticalSpaceMedium,
                          Text(
                            "There is no about information at the moment, Please check back later",
                            textAlign: TextAlign.center,
                            style: getBoldStyle(
                              color: ColorManager.blackColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
             
            }
            else {
              return WidgetListLoaderShimmer();
            }
          },
        ),
      ),
    );
  }
}
