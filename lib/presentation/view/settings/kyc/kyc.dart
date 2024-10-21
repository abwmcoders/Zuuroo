import 'package:flutter/material.dart';

import '../../../../app/base/base_screen.dart';
import '../../../../app/cache/storage.dart';
import '../../../../app/locator.dart';
import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../../auth/login/provider/login_provider.dart';
import '../../history/transaction_details.dart';
import '../../onboarding/onboarding.dart';
import 'model/kyc_model.dart';
import 'provider/kyc_provider.dart';

class Kyc extends StatelessWidget {
  Kyc({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // form variables
  final TextEditingController first = TextEditingController();
  final TextEditingController last = TextEditingController();
  final TextEditingController middle = TextEditingController();
  final TextEditingController bvn = TextEditingController();
  final TextEditingController dd = TextEditingController();
  final TextEditingController mm = TextEditingController();
  final TextEditingController yyyy = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView(
      vmBuilder: (context) => KycProvider(
        context: context,
      ),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, KycProvider kycProvider) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "BVN Verification"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  flex: 9,
                  child: ListView(
                    children: [
                      GradientText(
                        gradient: LinearGradient(
                          colors: [
                            ColorManager.blackColor,
                            ColorManager.primaryColor,
                            ColorManager.primaryColor,
                            ColorManager.primaryColor,
                            ColorManager.primaryColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        "Kyc Verification",
                        style: getBoldStyle(color: ColorManager.whiteColor)
                            .copyWith(fontSize: 22),
                      ),
                      UIHelper.verticalSpaceMedium,
                      AppFormField(
                        hintText: AppStrings.first,
                        prefix: const Padding(
                          padding: const EdgeInsets.all(12.0),
                        ),
                        fieldController: first,
                        keyboardType: TextInputType.name,
                        validator: (String? val) =>
                            FieldValidator().validate(val!),
                      ),
                      UIHelper.verticalSpaceSmall,
                      AppFormField(
                        hintText: AppStrings.last,
                        prefix: const Padding(
                          padding: const EdgeInsets.all(12.0),
                        ),
                        fieldController: last,
                        keyboardType: TextInputType.name,
                        validator: (String? val) =>
                            FieldValidator().validate(val!),
                      ),
                      UIHelper.verticalSpaceSmall,
                      AppFormField(
                        hintText: AppStrings.middle,
                        prefix: const Padding(
                          padding: const EdgeInsets.all(12.0),
                        ),
                        fieldController: middle,
                        keyboardType: TextInputType.name,
                        validator: (String? val) =>
                            FieldValidator().validate(val!),
                      ),
                      UIHelper.verticalSpaceSmall,
                      AppFormField(
                        hintText: "BVN",
                        prefix: const Padding(
                          padding: const EdgeInsets.all(12.0),
                        ),
                        fieldController: bvn,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your BVN';
                          }
                          final numericRegex = RegExp(r'^\d+$');
                          if (!numericRegex.hasMatch(value)) {
                            return 'BVN must be numeric';
                          }
                          if (value.length != 11) {
                            return 'BVN must be exactly 11 digits';
                          }

                          return null;
                        },
                      ),
                      UIHelper.verticalSpaceSmall,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: AppFormField(
                              hintText: "dd",
                              prefix: const Padding(
                                padding: const EdgeInsets.all(12.0),
                              ),
                              fieldController: dd,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a day';
                                }
                                final int? day = int.tryParse(value);
                                if (day == null) {
                                  return 'Please enter a valid number';
                                }
                                if (day < 1 || day > 31) {
                                  return 'Day must be between 1 and 31';
                                }

                                return null;
                              },
                            ),
                          ),
                          UIHelper.horizontalSpaceSmall,
                          Expanded(
                            child: AppFormField(
                              hintText: "mm",
                              prefix: const Padding(
                                padding: const EdgeInsets.all(12.0),
                              ),
                              fieldController: mm,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a month';
                                }
                                final int? month = int.tryParse(value);
                                if (month == null) {
                                  return 'Please enter a valid number';
                                }
                                if (month < 1 || month > 12) {
                                  return 'Month must be between 1 and 12';
                                }

                                return null;
                              },
                            ),
                          ),
                          UIHelper.horizontalSpaceSmall,
                          Expanded(
                            child: AppFormField(
                              hintText: "yyyy",
                              prefix: const Padding(
                                padding: const EdgeInsets.all(12.0),
                              ),
                              fieldController: yyyy,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a year';
                                }
                                final int? year = int.tryParse(value);
                                if (year == null) {
                                  return 'Please enter a valid number';
                                }
                                if (year < 1800 || year > 3000) {
                                  return 'Year must be between 1900 and 2100';
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      UIHelper.verticalSpaceSmall,
                      UIHelper.verticalSpaceMediumPlus,
                      AppButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            KycModel kycValue = KycModel(
                              first: first.text.trim(),
                              last: last.text.trim(),
                              middle: middle.text.trim(),
                              dd: dd.toString().trim(),
                              mm: mm.text.trim(),
                              yyyy: yyyy.text.trim(),
                              bvn: bvn.text.trim(),
                            );
                            kycProvider.verifyKyc(kyc: kycValue);
                          }
                        },
                        buttonText: "Verify",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
