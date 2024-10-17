import 'package:flutter/material.dart';
import 'package:zuuro/presentation/resources/resources.dart';

appBottomSheet(BuildContext context, Widget sheetBody,
    {bool isNotTabScreen = false}) {
  showModalBottomSheet(
    backgroundColor: ColorManager.greyColor,
    useRootNavigator: true,
    context: context,
    isScrollControlled: true,
    enableDrag: true,
    anchorPoint: const Offset(0, 500),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: sheetBody,
          ),
    ),
  );
}
