import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// enum _Tab { one, two }

class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // _Tab _selectedTab = _Tab.one;

  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text('Logo 1'),
    1: Text('Logo 2'),
    2: Text('Logo 3'),
  };

  @override
  Widget build(BuildContext context) {
    return 
    PreferredSize(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 12),
        child: Row(
          children: <Widget>[
            SizedBox(width: 24),
            Expanded(
              child: CupertinoSegmentedControl(
                  children: const <int, Widget>{
                    0: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Midnight')),
                    1: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Viridian')),
                    2: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Cerulean'))
                  },
                  groupValue: 0,
                  onValueChanged: (value) { 
                  }),
            ),
            SizedBox(width: 24)
          ],
        ),
      ),
      preferredSize: Size(double.infinity, 48),
    
    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: [
    //     SizedBox(height: 16),
    //     CupertinoSegmentedControl<_Tab>(
    //       selectedColor: Colors.black,
    //       borderColor: Colors.black,
    //       pressedColor: Colors.grey,
    //       children: {
    //         _Tab.one: Text('One'),
    //         _Tab.two: Text('Two'),
    //       },
    //       onValueChanged: (value) {
    //         setState(() {
    //           _selectedTab = value;
    //         });
    //       },
    //       groupValue: _selectedTab,
    //     ),
    //     SizedBox(height: 64),
    //     Builder(
    //       builder: (context) {
    //         // switch (_selectedTab) {
    //         //   case 
    //         // _Tab.one:
    //             return 
    //             Center(
    //               child: Container(
    //                 width: 100,
    //                 height: 100,
    //                 color: Colors.red,
    //               ),
    //             );
    //           // case _Tab.two:
    //           //   return Center(
    //           //     child: Container(
    //           //       width: 100,
    //           //       height: 100,
    //           //       color: Colors.blue,
    //           //     ),
    //           //   );
    //         // }
    //       },
    //     ),
    //   ],
    );
  }
}