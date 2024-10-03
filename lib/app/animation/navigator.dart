import 'package:flutter/material.dart';

import '../animation/page_transition.dart';


class NavigateClass {
  pushScreen({required BuildContext context, Widget? screen}) {
    Navigator.push(context, PreviewSlideRoute(preview: screen!, duration: 2));
  }

  pushNamed({
    required BuildContext context,
    required String routName,
    dynamic args
  }) {
    Navigator.pushNamed(
      context,
      routName,
      arguments: args
    );
  }

  pushReplacementNamed({
    required BuildContext context,
    required String routName,
  }) {
    Navigator.pushReplacementNamed(
      context,
      routName,
    );
  }

  pushRemoveScreen({required BuildContext context, Widget? screen}) {
    Navigator.pushAndRemoveUntil(context,
        PreviewSlideRoute(preview: screen!, duration: 0), (route) => true);
  }
}
