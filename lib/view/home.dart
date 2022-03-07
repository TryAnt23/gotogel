import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gotogel/values/values.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:gotogel/route_paths.dart' as route;

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

WebViewController controllerGlobal;

class HomeScreenState extends State<HomeScreen> //{
                    with TickerProviderStateMixin<HomeScreen>{ 
  TabController _tabController;
  DateTime currentBackPressTime;
  bool isLoading=true;
  AnimationController controller;
  bool isProcess=true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true); 

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

  }
  

  @override
  void dispose() { 
    controller.dispose();
    super.dispose();
  }

  Widget getTabBar() {
  return TabBar(
    controller: _tabController,
    onTap: (index){
      controllerGlobal.reload();
      _tabController.animateTo(0);
      switch(index){
        case 1:
          Map args = {
            'url' : StringConst.URL_ONE,
            'token' : '',
            'title' : "Chat"
          };
          Navigator.of(context).pushNamed(route.WebViewOne, arguments: args);
          break;
        case 2:
          Map args = {
            'url' : StringConst.URL_TWO,
            'token' : '',
            'title' : "Hasil"
          };
          Navigator.of(context).pushNamed(route.WebViewOne, arguments: args);
          break;
      }
    },
    indicatorPadding: EdgeInsets.all(10),
    unselectedLabelColor: Colors.white,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Color(0xff02570a)),
    tabs: [
      Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon(Icons.add_chart),
          const SizedBox(width: 8),
          Text('Home'),
        ],
      ),
    ),
    Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon(Icons.add_chart),
          const SizedBox(width: 8),
          Text('Chat'),
        ],
      ),
    ),
    Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon(Icons.info_outline),
          const SizedBox(width: 8),
          Text('Hasil'),
        ],
      ),
    ),
  ]);
}

Widget home(BuildContext context){
  return  
    Container(color: Colors.black,
    child:
      Stack(
        children: <Widget>[
          WebView(
            initialUrl: StringConst.URL_NAME,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              // _controller.complete(webViewController);
              controllerGlobal = webViewController;
            },
            onProgress: (int progress) {
              if(progress<80){
                isProcess = true;
              }else{
                isProcess = false;
              }
              // print("WebView is loading (progress : $progress%)");
            },
            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                // print('blocking navigation to $request}');
                return NavigationDecision.prevent;
              }
              // print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              // print('Page started loading: $url');
            },
            onPageFinished: (String url) async {
              setState(() {
                isLoading = false;
              });
              try {
                await controllerGlobal.evaluateJavascript("console.log(document.documentElement.innerHTML);");
              } catch (e) {
                print(e.toString());
              }
            },
            gestureNavigationEnabled: true,
            onWebResourceError: (WebResourceError webviewerrr) {
              print("Handle your Error Page here $isLoading");
          },
          ),
        isLoading ? 
        Container(
          color: Colors.black,
          child: Center(child: CircularProgressIndicator()),
        ) : Stack(),
        // Container(height:10,child:
        isProcess ?
          LinearProgressIndicator(
            backgroundColor: Colors.black,
            valueColor: AlwaysStoppedAnimation(Color(0xff00880c)),
            minHeight: 3,
          ) : Container(),
      ],
    )
  );
}

JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  return JavascriptChannel(
    name: 'Toaster',
    onMessageReceived: (JavascriptMessage message) {
      print(message.message);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message.message)));
    });
  }

// ignore: missing_return
Future<bool> onWillPop(context) async {
    DateTime now = DateTime.now();
    if (await controllerGlobal.canGoBack()) {
      // print("onwill goback");
      controllerGlobal.goBack();
    } else {
      if (currentBackPressTime == null || 
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tekan sekali lagi untuk keluar")));
        return Future.value(false);
      }
      return Future.value(true);
    }
  }

  @override
    Widget build(BuildContext context) { 
      return DefaultTabController(
        length: 3,
        child: 
        WillPopScope(
          onWillPop: () => onWillPop(context),
          child: 
          Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff00880c),
              elevation: 0,
              automaticallyImplyLeading: false,
              flexibleSpace: SafeArea(
                child: getTabBar(),
              ),
            ),
            body:  
              home(context)), 
        )
      );
    }

}
