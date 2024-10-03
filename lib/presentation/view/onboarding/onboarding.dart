import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/animation/navigator.dart';
import '../../../app/cache/orage_cred.dart';
import '../../../app/cache/storage.dart';
import '../../resources/resources.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          NavigateClass().pushNamed(
                            context: context,
                            routName: Routes.loginRoute,
                          );
                           
                        },
                        child: Text(
                          "Skip",
                          style: getBoldStyle(
                            color: ColorManager.blackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    height: screenAwareSize(840, context),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: onBoardData.length,
                      onPageChanged: (index) {
                        setState(
                          () {
                            pageIndex = index;
                          },
                        );
                      },
                      itemBuilder: (context, index) {
                        return OnbaordingConstantWidget(
                          title: onBoardData[index].title,
                          description: onBoardData[index].description,
                          imageUrl: onBoardData[index].image,
                          subTitle: onBoardData[index].subTitle,
                        );
                      },
                    ),
                  ),
               
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                              onBoardData.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(
                                  right: 4.0,
                                ),
                                child: DotIndicatorWidget(
                                  isActive: index == pageIndex,
                                ),
                              ),
                            ),
                          ],
                        ),
                       
                        UIHelper.verticalSpaceMedium,
                        AppButton(
                          buttonText: "Continue",
                          onPressed: (){
                            
                            NavigateClass().pushNamed(
                              context: context,
                              routName: Routes.loginRoute,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DotIndicatorWidget extends StatelessWidget {
  const DotIndicatorWidget({
    super.key,
    this.isActive = false,
    this.isReg = false,
  });

  final bool isActive, isReg;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: screenAwareSize(10, context),
      width: isActive ? screenAwareSize(80, context) : isReg ? screenAwareSize(20, context) : screenAwareSize(8, context),
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: ColorManager.blackColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class OnbaordingConstantWidget extends StatelessWidget {
  const OnbaordingConstantWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.imageUrl,
  });

  final String title, description, imageUrl, subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30, bottom: 30),
                child: SvgPicture.asset(
                  imageUrl,
                  // height: screenAwareSize(400, context),
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                text: title,
                style: getBoldStyle(color: ColorManager.blackColor)
                    .copyWith(fontSize: 22),
                children: [
                  WidgetSpan(
                    child: GradientText(
                      gradient: LinearGradient(
                        colors: [
                          ColorManager.primaryColor,
                          ColorManager.secondaryColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      subTitle,
                      style: getBoldStyle(color: ColorManager.whiteColor)
                          .copyWith(fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpaceSmall,
            Text(
              description,
              style: getRegularStyle(color: ColorManager.deepGreyColor)
                  .copyWith(fontSize: 15),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle style;

  const GradientText(
    this.text, {
    required this.gradient,
    this.style = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}

class OnBoard {
  final String title, subTitle, description, image;

  OnBoard({
    required this.title,
    required this.subTitle,
    required this.description,
    required this.image,
  });
}

List<OnBoard> onBoardData = [
  OnBoard(
      title: "Buy Airtime\n",
      description: "Top up your mobile airtime instantly, anytime, anywhere. ",
      image: ImageAssets.onb1,
      subTitle: "with Ease"),
  OnBoard(
      title: "Stay Connected\n",
      description: "Get more data with just a tap.",
      image: ImageAssets.onb2,
      subTitle: "with Data"),
  OnBoard(
      title: "Pay Bills\n",
      description:
          "Settle your electricity, TV subscriptions, and betting payments quickly and easily",
      image: ImageAssets.onb3,
      subTitle: "Effortlessly"),
  OnBoard(
    title: "Instant Loan\n",
    description: "Quick loans, anytime you need them.",
    image: ImageAssets.onb4,
    subTitle: "Anytime",
  ),
];

