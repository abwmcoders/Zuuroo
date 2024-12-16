// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:zuuro/app/animation/navigator.dart';
import 'package:zuuro/presentation/resources/resources.dart';
import 'package:zuuro/presentation/view/history/transaction_details.dart';

import '../../../../app/app_constants.dart';
import '../../../../app/functions.dart';
import '../../../../app/services/api_rep/user_services.dart';

class CardFunding extends StatelessWidget {
  CardFunding({super.key});

  final TextEditingController amount = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

   String generatePaystackReferenceWithTimestamp() {
    DateTime now = DateTime.now();
    return 'TX_${now.millisecondsSinceEpoch}';
  }


  Future<void> initialize(BuildContext ctx) async {
    try {
      var response = await UserApiServices().initializePayment({
        "amount": amount.text.trim(),
      });
      print("initialize response ---> $response");
      if (response["status"] == "success") {
        String paymentUrl = response['payment_url'];
        String reference = response['reference'];

        PayWithPayStack().now(
            callbackUrl: paymentUrl,
            context: ctx,
            secretKey:
                "sk_live_7570700bb6e02b66cb43cc0040b5dcb9fc72985d", // "sk_test_52fdad00c5f938381b29d16a6e4c516bea328ff5",
            customerEmail: AppConstants.homeModel!.data.user.email,
            reference: "${reference + generatePaystackReferenceWithTimestamp()}",
            currency: "NGN",
            amount: double.parse(amount.text.trim()),
            transactionCompleted: () {
              amount.clear();
              NavigateClass().pushReplacementNamed(
                context: ctx,
                routName: Routes.mainRoute,
              );
              MekNotification().showMessage(
                ctx,
                color: ColorManager.activeColor,
                message: "Payment successful",
              );
            },
            transactionNotCompleted: () {
              MekNotification().showMessage(
                ctx,
                message: "Payment Failed",
              );
            });
      } else {
        MekNotification().showMessage(
          ctx,
          message: "An error occurred, Please check your internet connection",
        );
        print('Error: ${response.body}');
      }
    } catch (e) {
      MekNotification().showMessage(
        ctx,
        message: "An error occurred, Please try again later",
      );
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Card Funding"),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Amount",
                      style: getRegularStyle(
                        color: ColorManager.blackColor,
                        fontSize: 14,
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: amount,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontFamily: "NT",
                        color: ColorManager.blackColor,
                      ),
                      decoration: InputDecoration(
                        //border: InputBorder.none,
                        hintText: "Enter amount",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 1.5,
                          fontFamily: "NT",
                          color: ColorManager.greyColor,
                        ),

                        prefix: Text(
                          AppConstants.currencySymbol,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontFamily: "NT",
                            color: ColorManager.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpaceLarge,
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //   margin: EdgeInsets.only(bottom: 10),
              //   decoration: BoxDecoration(
              //     color: ColorManager.whiteColor,
              //     borderRadius: BorderRadius.circular(13),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Added Cards",
              //         style: getRegularStyle(
              //           color: ColorManager.blackColor,
              //           fontSize: 14,
              //         ),
              //       ),
              //       UIHelper.verticalSpaceSmall,
              //       ...List.generate(
              //         4,
              //         (index) {
              //           return Container(
              //             margin: EdgeInsets.only(bottom: 10),
              //             padding: EdgeInsets.symmetric(
              //               horizontal: 10,
              //               vertical: 10,
              //             ),
              //             decoration: BoxDecoration(
              //               color: ColorManager.greyColor.withOpacity(.4),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Row(
              //                   children: [
              //                     Container(
              //                       height: screenAwareSize(60, context),
              //                       width: screenAwareSize(60, context),
              //                       decoration: BoxDecoration(
              //                         shape: BoxShape.circle,
              //                         color: ColorManager.whiteColor,
              //                       ),
              //                     ),
              //                     UIHelper.horizontalSpaceSmall,
              //                     Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Text(
              //                           "Wema Bank",
              //                           style: getBoldStyle(
              //                               color: ColorManager.blackColor,
              //                               fontSize: 14),
              //                         ),
              //                         Text(
              //                           "414488********4119",
              //                           style: getRegularStyle(
              //                               color: ColorManager.greyColor,
              //                               fontSize: 12),
              //                         ),
              //                       ],
              //                     )
              //                   ],
              //                 )
              //               ],
              //             ),
              //           );
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              // UIHelper.verticalSpaceLarge,
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //   margin: const EdgeInsets.only(bottom: 10),
              //   decoration: BoxDecoration(
              //     color: ColorManager.whiteColor,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Row(
              //         children: [
              //           Container(
              //             height: screenAwareSize(50, context),
              //             width: screenAwareSize(50, context),
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               color: ColorManager.primaryColor.withOpacity(.4),
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.all(6.0),
              //               child: SvgPicture.asset(ImageAssets.card),
              //             ),
              //           ),
              //           UIHelper.horizontalSpaceMedium,
              //           Text(
              //             "Add a Bank Card",
              //             style: getBoldStyle(color: ColorManager.blackColor)
              //                 .copyWith(fontSize: 14),
              //           ),
              //         ],
              //       ),
              //       IconButton(
              //         onPressed: () {},
              //         icon: const Icon(
              //           Icons.arrow_forward_ios,
              //           size: 14,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // UIHelper.verticalSpaceMedium,
              AppButton(
                buttonText: "Continue",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    initialize(context);
                  } else {
                    MekNotification().showMessage(
                      context,
                      message: "Please enter amount to deposit!!!",
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
