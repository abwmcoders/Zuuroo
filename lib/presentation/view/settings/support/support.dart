import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../resources/resources.dart';
import '../../history/transaction_details.dart';
import '../../vtu/airtime/airtime.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  final Uri _urlFacebook = Uri.parse('https://www.facebook.com');
  final Uri _urlTwitter = Uri.parse('https://www.twitter.com');
  final Uri _urlInstagram = Uri.parse('https://www.instagram.com');
  final Uri _urlLinkedin = Uri.parse('https://www.linkedin.com/');

  final List<Map<String, String>> faqData = [
    {
      "question": "What is Flutter?",
      "answer": "Flutter is an open-source UI toolkit from Google."
    },
    {
      "question": "How to use Flutter?",
      "answer": "You can use Flutter to build natively compiled apps."
    },
    {
      "question": "What platforms does Flutter support?",
      "answer": "Flutter supports Android, iOS, web, and desktop."
    },
  ];

  Future<void> _launchTwitterUrl() async {
    if (await canLaunchUrl(_urlTwitter)) {
      await launchUrl(_urlTwitter, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $_urlTwitter';
    }
  }

  Future<void> _launchFacebookUrl() async {
    if (await canLaunchUrl(_urlFacebook)) {
      await launchUrl(_urlFacebook, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $_urlFacebook';
    }
  }

  Future<void> _launchInstagramUrl() async {
    if (await canLaunchUrl(_urlInstagram)) {
      await launchUrl(_urlInstagram, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $_urlInstagram';
    }
  }

  Future<void> _launchLinkedinUrl() async {
    if (await canLaunchUrl(_urlLinkedin)) {
      await launchUrl(_urlLinkedin, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $_urlLinkedin';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Help & Support"),
      body: ContainerWidget(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Connect with us on our social handles",
              style: getBoldStyle(color: ColorManager.blackColor),
            ),
            UIHelper.verticalSpaceMedium,
            supportTile(
              "Facebook",
              "assets/icons/facebook.png",
              "https://www.facebook.com/",
              _launchFacebookUrl,
            ),
            supportTile(
              "Twitter",
              "assets/icons/twitter.png",
              "https://www.twitter.com/",
              _launchTwitterUrl,
            ),
            supportTile(
              "Instagram",
              "assets/icons/instagram.png",
              "https://www.instagram.com/",
              _launchTwitterUrl,
            ),
            supportTile(
              "Linkedin",
              "assets/icons/linkedin.png",
              "https://www.instagram.com/",
              _launchLinkedinUrl,
            ),
            UIHelper.verticalSpaceLarge,
            Text(
              "FAQS",
              style: getBoldStyle(color: ColorManager.blackColor),
            ),
            UIHelper.verticalSpaceSmall,
            Expanded(
              child: ListView.builder(
                itemCount: faqData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: ColorManager.blackColor),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3), // Shadow position
                            ),
                          ],
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor:
                                Colors.transparent, // Hide divider line
                          ),
                          child: ExpansionTile(
                            title: Text(
                              faqData[index]['question']!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(faqData[index]['answer']!),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget supportTile(
    String title,
    String imageUrl,
    String url,
    VoidCallback onPressed,
  ) {
    return ListTile(
      leading: Container(
        height: screenAwareSize(60, context),
        width: screenAwareSize(60, context),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage(
                  imageUrl,
                ),
                fit: BoxFit.contain)),
      ),
      // CircleAvatar(
      //   radius: 25,
      //   child: Image.asset(
      //     imageUrl,
      //     fit: BoxFit.cover,
      //   ),
      // ),
      title: Text(
        title,
        style: getBoldStyle(color: ColorManager.blackColor),
      ),
      subtitle: Text(
        url,
        style: TextStyle(fontSize: 10),
      ),
      trailing: IconButton(
          icon: Icon(
            Icons.eco_rounded,
            size: 20.0,
            color: Colors.brown[900],
          ),
          onPressed: onPressed),
    );
  }
}
