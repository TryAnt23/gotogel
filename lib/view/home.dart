import 'package:flutter/material.dart';
import 'package:gotogel/values/values.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:gotogel/route_paths.dart' as route;

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}



class HomeScreenState extends State<HomeScreen> //{
                    with TickerProviderStateMixin<HomeScreen>{

  // final Completer<WebViewController> _controller = Completer<WebViewController>();
  TabController _tabController;
  DateTime currentBackPressTime;
  bool isLoading=true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);

    // _tabController.addListener((){
    //   print('my index is'+ _tabController.index.toString());
    // });
  }

  @override
  void dispose() {  
    // _tabController.dispose();
    super.dispose();
  }

  Widget getTabBar() {
  return TabBar(
    controller: _tabController,
    onTap: (index){
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
  // WebviewScaffold(
  //   initialChild: 
  //   Container(
  //     color: Colors.black,
  //     child: Center(child: CircularProgressIndicator()),
  //     // Image.asset('assets/images/loading.gif', width: 40, height: 40)), 
  //   ),
  //   url: StringConst.URL_NAME,
  //   withJavascript: true,
  //   hidden: true,
  //   ignoreSSLErrors: true,
  // );
  
  Container(color: Colors.black,
  child:
    Stack(
      children: <Widget>[
        WebView(
          initialUrl: StringConst.URL_NAME,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            // _controller.complete(webViewController);
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
            setState(() {
              isLoading = false;
            });
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        ),
      isLoading ? 
      Container(
        color: Colors.black,
        child: Center(child: CircularProgressIndicator()),
      ) : Stack(),
    ],
  )
  );
}

// JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
//   return JavascriptChannel(
//     name: 'Toaster',
//     onMessageReceived: (JavascriptMessage message) {
//       // ignore: deprecated_member_use
//       Scaffold.of(context).showSnackBar(
//         SnackBar(content: Text(message.message)),
//       );
//     });
//   }

Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || 
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      SnackBar(
        content: Text('Press back again to exit'),
        duration: Duration(seconds: 3),
      );
      // Fluttertoast.showToast(msg: exit_warning);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
    Widget build(BuildContext context) { 
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff00880c),
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: SafeArea(
              child: getTabBar(),
            ),
          ),
          body: WillPopScope(child: home(context), onWillPop: onWillPop),
          // TabBarView(children: [
          //   home(context),
          //   home(context),
          //   home(context),
          // ]),
        )
     );
    }

}
