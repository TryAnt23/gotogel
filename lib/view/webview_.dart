import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {

  final String title;
  final String url;
  final List<Widget> footerButtons;
  final bool shouldPrepareUrl;
  final String bearerToken;

  WebviewScreen(this.url, {Key key, this.title = 'Gotogel', this.footerButtons = const [], this.shouldPrepareUrl = true, this.bearerToken}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WebviewState();
  }
}



class WebviewState extends State<WebviewScreen> {

  String url;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // url = widget.shouldPrepareUrl ? prepareUrl(widget.url, user: widget.user) : widget.url;
    url = widget.url;
  }

  @override
  void dispose() {  
    super.dispose();
  }

  @override
    Widget build(BuildContext context) { 
      return Scaffold(
        backgroundColor: Colors.white,
        // appBar: getAppBar(widget.title),
        body:
        WebView(
          initialUrl: 'http://206.189.227.248/',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
          // javascriptChannels: <JavascriptChannel>{
          //   _toasterJavascriptChannel(context),
          // },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        )
      );
      
    }
  
}
