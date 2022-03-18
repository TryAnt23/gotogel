import 'package:flutter/material.dart';
import 'package:gotogel/values/global.dart';
import 'package:gotogel/route_paths.dart' as route;
import 'package:gotogel/values/values.dart';

class MaintenanceScreen extends StatefulWidget {
  final String body;
  MaintenanceScreen({this.body});

  @override
  State createState() => new MaintenanceState();
}

class MaintenanceState extends State<MaintenanceScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset(
                  ImagePath.logo,
                  height: 300,
                  width: 300,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                height: 30.0,
              ),
              Text(
                'Hi, Member!',
                textAlign: TextAlign.center,
              ),
              Text(
                'Please check your connection or click refresh button ' +
                    '\n\nThank you!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0),
              ),
              Container(
                height: 10.0,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide(color: Colors.transparent)),
                    padding: EdgeInsets.all(8.0),
                    backgroundColor: Colors.white30,
                  ),
                  child: Text('Refresh',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                          letterSpacing: 1)),
                  onPressed: () {
                    Global.getRemoteConfig().then((remoteConfig) {
                      debugPrint('========cekURL2========');
                      debugPrint(remoteConfig.getString('main_url'));
                      Global.latestUriGlobal =
                          remoteConfig.getString('main_url');
                      if (Global.latestUriGlobal != '') {
                        //lempar ke page refresh layout single button
                        Navigator.pushNamedAndRemoveUntil(
                            context, route.HomeScreen, (route) => false);
                      }
                    });
                    // launch(widget.updateUrl);
                  })
            ],
          ),
        ));
  }
}
