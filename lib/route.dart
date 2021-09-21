import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gotogel/view/splash_screen.dart';
import 'package:gotogel/view/webview.dart';
import 'route_paths.dart' as route;

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) { 
    final args = settings.arguments;
    var nextScreen;
    switch (settings.name) {
        case route.Splashscreen: 
          nextScreen = SplashScreen();
          break;
        case route.WebviewScreen:
          nextScreen = WebviewScreen(args);
          break; 
          
        // case route.BackendWebView:
          // var map = args as Map;
          // var footerButtons = map['footer'];
          // nextScreen = WebviewScreen(map['url'], title: map['title'], bearerToken: map['token'], footerButtons: footerButtons != null ? footerButtons : []);
          // break;
        default:
          nextScreen = Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            );
      }
    
    return CupertinoPageRoute(builder: (context) => nextScreen);
  }
}