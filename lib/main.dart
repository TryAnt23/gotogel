import 'package:flutter/material.dart';
import 'package:gotogel/route.dart' as routes;
import 'package:gotogel/route_paths.dart' as route;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gotogel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: route.Splashscreen,
      onGenerateRoute: routes.Router.generateRoute,
    );
  }
}

