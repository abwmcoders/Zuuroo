import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../history/transaction_details.dart';
import '../../vtu/airtime/airtime.dart';

class Website extends StatefulWidget {
  @override
  _WebsiteState createState() => _WebsiteState();
}

class _WebsiteState extends State<Website> {
  InAppWebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: "Zuuroo Website"),
      // AppBar(
      //   title: Text('Inline WebView Example'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.refresh),
      //       onPressed: () {
      //         _webViewController?.reload();
      //       },
      //     ),
      //   ],
      // ),
      body: ContainerWidget(
        content: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri("https://www.zuuroo.com/"),
          ),
           initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            clearCache: true,
            supportZoom: false,
          ),
          onWebViewCreated: (controller) {
            _webViewController = controller;
          },
          onLoadStart: (controller, url) {
            print("Started loading: $url");
          },
          onLoadStop: (controller, url) async {
            print("Finished loading: $url");
          },
           onLoadError: (controller, url, code, message) {
            print("Error loading: $message");
          },
        ),
      ),
    );
  }
}
