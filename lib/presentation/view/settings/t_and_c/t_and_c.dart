import 'package:flutter/material.dart';
import 'package:zuuro/presentation/resources/resources.dart';
import 'package:zuuro/presentation/resources/style_manager.dart';

import 'package:zuuro/presentation/view/history/transaction_details.dart';

import '../../vtu/airtime/airtime.dart';

class TAndC extends StatelessWidget {
  const TAndC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Terms and condition"),
      body: ContainerWidget(
          content: ListView(
        children: [
          ...List.generate(4, (index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.",
                style: getBoldStyle(
                  color: ColorManager.blackColor,
                  fontSize: 12,
                ),
              ),
            );
          })
        ],
      )),
    );
  }
}
