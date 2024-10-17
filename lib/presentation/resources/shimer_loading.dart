import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zuuro/presentation/resources/resources.dart';

class WidgetListLoaderShimmer extends StatelessWidget {
  final int? listCount;
  WidgetListLoaderShimmer({this.listCount = 20});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.whiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < listCount!; i++)
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  leading: Shimmer.fromColors(
                    baseColor: Color(0xff949599).withOpacity(0.5),
                    highlightColor: Color(0xffF0F1F5).withOpacity(0.5),
                    child: CircleAvatar(
                      radius: 25,
                    ),
                  ),
                  title: Shimmer.fromColors(
                    baseColor: Color(0xff949599).withOpacity(0.5),
                    highlightColor: Color(0xffF0F1F5).withOpacity(0.5),
                    child: Container(
                      width: screenAwareSize(100, context),
                      color: Colors.black,
                      child: Text(""),
                    ),
                  ),
                  subtitle: SizedBox(
                    width: deviceWidth(context),  //20,
                    child: Shimmer.fromColors(
                      baseColor: Color(0xff949599).withOpacity(0.5),
                      highlightColor: Color(0xffF0F1F5).withOpacity(0.5),
                      child: SizedBox(
                        width: 20,
                        child: Container(
                          width: screenAwareSize(20, context),
                          color: Colors.black,
                          child: Text(""),
                        ),
                      ),
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "",
                      ),
                      UIHelper.verticalSpaceSmall,
                      Text(
                        "",
                      )
                    ],
                  ),
                ),
            ],
          ),
        ));
  }
}
