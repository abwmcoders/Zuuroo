import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zuuro/presentation/resources/resources.dart';

class AppPinField extends StatelessWidget {
  const AppPinField({
    super.key,
    required this.length,
    required this.controller,
    required this.validator,
    this.onChanged,
    this.onCompleted,
    this.obscure = false,
  });

  final int length;
  final bool obscure;
  final TextEditingController controller;
  final String? Function(String v) validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    const horizontalPadding = 48;
    final minimumSpacing = 10 * length;
    final spaceForFields = (screen - horizontalPadding - minimumSpacing);
    final width = (spaceForFields / length).clamp(32.0, 100.0);
    //final colors = ColorManager();
    final outlineColor = ColorManager.primaryColor;
    final bg = ColorManager.scaffoldBg;

    return PinCodeTextField(
      obscureText: obscure,
      autoDisposeControllers: false,
      appContext: context,
      length: length,
      controller: controller,
      onChanged: onChanged ?? (_) {},
      onCompleted: onCompleted,
      keyboardType: TextInputType.number,
      animationType: AnimationType.scale,
      backgroundColor: null,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textStyle: getBoldStyle(color: ColorManager.primaryColor),
      showCursor: true,
      cursorHeight: 16,
      cursorColor: ColorManager.primaryColor,
      cursorWidth: 1,
      autoFocus: true,
      enableActiveFill: true,
      errorTextSpace: 24,
      validator: (v) => validator(v ?? ''),
      pinTheme: PinTheme(
        borderRadius: BorderRadius.circular(12),
        activeFillColor: bg,
        inactiveFillColor: bg,
        selectedFillColor: bg,
        activeColor: outlineColor,
        inactiveColor: outlineColor,
        selectedColor: outlineColor,
        disabledColor: outlineColor,
        fieldHeight: 64,
        fieldWidth: width,
        borderWidth: 1,
        shape: PinCodeFieldShape.box,
      ),
    );
  }
}
