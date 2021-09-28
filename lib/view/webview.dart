import 'dart:io';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';
import 'package:gotogel/values/component.dart';

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

  @override
  void initState() {
    super.initState();
    url = widget.url;
  }

  @override
  void dispose() {  
    super.dispose();
  }

  @override
    Widget build(BuildContext context) { 
      return Scaffold(
        backgroundColor: Color(0xff00880c),
        appBar: getAppBar(widget.title),
        body: WebviewScaffold(
          initialChild: 
          Container(
            color: Colors.black,
            child: Center(child: 
            CircularProgressIndicator()),
          ),
          url: url,
          withJavascript: true,
          hidden: true,
          ignoreSSLErrors: true,
          headers: widget.bearerToken != null ? {
            HttpHeaders.authorizationHeader: 'Bearer ${widget.bearerToken}',
          } : {},
        )
      );
      
    }
  
}
