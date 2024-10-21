import 'package:flutter/material.dart';
import 'package:zuuro/presentation/view/home/model/home_model.dart';

import '../../../../app/base/base_screen.dart';
import '../../../../app/validator.dart';
import '../../../resources/resources.dart';
import '../../history/transaction_details.dart';
import '../../onboarding/onboarding.dart';
import '../../vtu/airtime/airtime.dart';
import '../kyc/model/kyc_model.dart';
import '../kyc/provider/kyc_provider.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key, required this.user});

  final User user;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // form variables
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController number = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController dob = TextEditingController();

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
    name.text = user.name;
    email.text = user.email;
    number.text = user.phoneNumber;
    gender.text = user.gender!;
    dob.text = user.dateOfBirth!;
    address.text = user.address!;
    username.text = user.username;
    return Scaffold(
      appBar: const SimpleAppBar(title: "Edit Profile"),
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
                        AppFormField(
                          hintText: "Full name",
                          prefix: const Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          fieldController: name,
                          keyboardType: TextInputType.name,
                          validator: (String? val) =>
                              FieldValidator().validate(val!),
                        ),
                        UIHelper.verticalSpaceSmall,
                        AppFormField(
                          hintText: AppStrings.email,
                          prefix: const Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          fieldController: email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? val) =>
                              FieldValidator().validateEmail(val!),
                        ),
                        UIHelper.verticalSpaceSmall,
                        AppFormField(
                          hintText: "Address",
                          prefix: const Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          fieldController: address,
                          keyboardType: TextInputType.name,
                          validator: (String? val) =>
                              FieldValidator().validate(val!),
                        ),
                        UIHelper.verticalSpaceSmall,
                        AppFormField(
                          hintText: "Username",
                          prefix: const Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          fieldController: username,
                          keyboardType: TextInputType.name,
                          validator: (String? val) =>
                              FieldValidator().validate(val!),
                        ),
                        UIHelper.verticalSpaceSmall,
                        AppFormField(
                          hintText: "Gender",
                          prefix: const Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          fieldController: gender,
                          keyboardType: TextInputType.name,
                          validator: (String? val) =>
                              FieldValidator().validate(val!),
                        ),
                        UIHelper.verticalSpaceSmall,
                        AppFormField(
                          hintText: "Dob",
                          prefix: const Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          fieldController: dob,
                          keyboardType: TextInputType.name,
                          validator: (String? val) =>
                              FieldValidator().validate(val!),
                        ),
                        UIHelper.verticalSpaceSmall,
                        AppFormField(
                          hintText: "Number",
                          prefix: const Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          fieldController: number,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your number';
                            }
                            final numericRegex = RegExp(r'^\d+$');
                            if (!numericRegex.hasMatch(value)) {
                              return 'Number must be numeric';
                            }
                            if (value.length != 10) {
                              return 'Number must be exactly 10 digits';
                            }

                            return null;
                          },
                        ),
                        UIHelper.verticalSpaceSmall,
                        UIHelper.verticalSpaceSmall,
                        UIHelper.verticalSpaceMediumPlus,
                        AppButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          buttonText: "Update",
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
