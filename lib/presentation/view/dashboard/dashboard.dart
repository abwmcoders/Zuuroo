import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/resources.dart';
import '../history/history.dart';
import '../home/home.dart';
import '../profile/profile.dart';
import '../wallet/wallet.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int _selectedPage = 0;
  final _pageOptions = [
    const Home(),
    const Wallet(),
   const TransactionHistory(),
   const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: ColorManager.whiteColor,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    gradient: _selectedPage == 0
                        ? ColorManager.homeGradient : const LinearGradient(colors: [
                          Colors.transparent,
                          Colors.transparent,
                        ],),
                        borderRadius: BorderRadius.circular(8)
                  ),
                  child: ImageIcon(
                    const AssetImage(ImageAssets.home),
                    color: _selectedPage == 0
                        ? ColorManager.whiteColor
                        : ColorManager.blackColor,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _selectedPage = 0;
                  });
                },
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      gradient: _selectedPage == 1
                          ? ColorManager.homeGradient
                          : const LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                              ],
                            ),
                      borderRadius: BorderRadius.circular(8)),
                  child: ImageIcon(
                    const AssetImage(ImageAssets.wallet),
                    color: _selectedPage == 1
                        ? ColorManager.whiteColor
                        : ColorManager.blackColor,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _selectedPage = 1;
                  });
                },
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      gradient: _selectedPage == 2
                          ? ColorManager.homeGradient
                          : const LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                              ],
                            ),
                      borderRadius: BorderRadius.circular(8)),
                  child: ImageIcon(
                    const AssetImage(ImageAssets.history),
                    color: _selectedPage == 2
                        ? ColorManager.whiteColor
                        : ColorManager.blackColor,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _selectedPage = 2;
                  });
                },
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      gradient: _selectedPage == 3
                          ? ColorManager.homeGradient
                          : const LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                              ],
                            ),
                      borderRadius: BorderRadius.circular(8)),
                  child: ImageIcon(
                    const AssetImage(ImageAssets.profile),
                    color: _selectedPage == 3
                        ? ColorManager.whiteColor
                        : ColorManager.blackColor,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _selectedPage = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  SignOutButton({
    super.key,
    this.color,
    this.iconColor,
  });

  Color? color, iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Row(
          children: [
            Text(
              "Sign Out",
              style: getBoldStyle(color: color ?? ColorManager.whiteColor)
                  .copyWith(fontSize: 18),
            ),
            Icon(
              Icons.arrow_forward,
              color: iconColor ?? ColorManager.secondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onPressed,
    this.isLast = false,
  });

  final String title, imageUrl;
  final VoidCallback onPressed;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      child: ListTile(
        minLeadingWidth: 5,
        minVerticalPadding: 2,
        contentPadding: EdgeInsets.zero,
        leading: SvgPicture.asset(imageUrl, color: ColorManager.whiteColor, width: 30, height: 30,),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: getBoldStyle(color: ColorManager.whiteColor)
                  .copyWith(fontSize: 17),
            ),
            UIHelper.verticalSpaceSmall,
            !isLast
                ? Divider(
                    color: ColorManager.whiteColor,
                  )
                : Container(),
          ],
        ),
        onTap: onPressed,
      ),
    );
  }
}
