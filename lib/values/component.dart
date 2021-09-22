import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'dart:io' ;
import 'package:gotogel/values/global.dart';
 
showAlert(BuildContext context,String title,{String description, Widget okAction, String closeButtonTitle = 'Close', VoidCallback closeAction}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {

      List<Widget> actions = [];
      if (okAction != null) {
        actions.add(okAction);
      }
      actions.add(new TextButton(
        child: new Text(closeButtonTitle, style: TextStyle(color: Colors.black),),
        onPressed: closeAction == null ? () {                                                                                                                                                                                                       
          hideLoadingIndicator(context);
        } : closeAction,
      ));

      return new AlertDialog(
        title: new Text(title, style: TextStyle(fontSize: 14.0),),
        content: description == null ? null : new Text(description),
        actions: actions,
      );
    }
  );
}

hideLoadingIndicator(BuildContext context) {
  if (Global.isLoading) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
    Global.isLoading = false;
  }
}

showLoadingIndicator(BuildContext context) {
  if (!Global.isLoading) {
    Global.isLoading = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => loadingIndicator
    );
    
  }
  
}

Widget get loadingIndicator {   
  return Container(
    padding: EdgeInsets.all(10),
    child: Center(child: Image.asset('assets/images/loading.gif', width: 70, height: 70)), 
  );
}

RichText getTwoSpacesLogo({double fontSize = 25.0, Color color = Colors.black}) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      children: [
        TextSpan(text: 'TWO', style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Advent Pro', fontSize: fontSize, color: color)),
        TextSpan(text: 'SPACES', style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Advent Pro', fontSize: fontSize, letterSpacing: 1.1, color: color))
      ]
    ),
  );
}

AppBar getAppBar(String title, {Color titleColor = Colors.black, Color iconTheme = Colors.black, Color backgroundColor = Colors.white24, List<Widget> actions} ) {
  return AppBar(title: Text(title, style: TextStyle(color: titleColor)),
    backgroundColor: backgroundColor,
    elevation: 0.0,
    centerTitle: true,
    iconTheme: IconThemeData(
      color: iconTheme,
    ),
    actions: actions,
    );
}

//
//* HTTP Request
//

const REQUEST_TIMEOUT_DURATION = Duration(seconds: 50);
const Map<String, String> headers = {
  'Content-type' : 'application/json',
  'Accept': 'application/json',
};
  
String get deviceType {
    return Platform.isAndroid ? 'android' : Platform.isIOS ? 'ios' : 'other';
}

 

String formatMobileNo(String mobileNo) {
  var formatted = mobileNo;
  if (formatted.startsWith('08')) {
    formatted = formatted.replaceFirst('08', '628');
  }
  if (formatted.startsWith('8')) {
    formatted = formatted.replaceFirst('8', '628');
  }

  return formatted;
}

String formatMoney(double amount) {
  var formatted = ((((amount)/10000)).ceil()*10000);
  final oCcy = new NumberFormat("#,##0", "in");
  return oCcy.format(formatted).replaceAll('.', ',');
}

String formatCredit(double amount) {
  var formatted = (((amount)).ceil());
  final oCcy = new NumberFormat("#,##0", "en_US");
  return oCcy.format(formatted);
}

String getPriceInCredit(double amount) {
  var amountCredit = amount/10000;
  var formatted = (((amountCredit)).ceil());
  final oCcy = new NumberFormat("#,##0", "en_US");
  return oCcy.format(formatted);
}

String getImageUrl(String imageUrl, {String size = 'l'}) {
  var finalUrl = imageUrl;
  if (finalUrl.contains('imgur') && !finalUrl.contains('$size.jpg')) {
    finalUrl = finalUrl.replaceAll('.jpg', '$size.jpg');
    finalUrl = finalUrl.replaceAll('.png', '$size.png');
  }
  return finalUrl;
}

  String getSpaceIconName(String spaceName) {
    String iconName = 'ico_workspace';

    if (spaceName.toLowerCase().contains('desk')) {
      iconName = 'ico_hotdesk';
    } else if (spaceName.toLowerCase().contains('training')) {
      iconName = 'ico_cotraining';
    } else if (spaceName.toLowerCase().contains('event')) {
      iconName = 'ico_eventspace';
    } else if (spaceName.toLowerCase().contains('private')) {
      iconName = 'ico_privateoffice';
    } else if (spaceName.toLowerCase().contains('retailspace')) {
      iconName = 'ico_retailspace';
    } else if (spaceName.toLowerCase().contains('warehouse')) {
      iconName = 'ico_retailspace';
    } else if (spaceName.toLowerCase().contains('living')) {
      iconName = 'ico_livespace';
    } else if (spaceName.toLowerCase().contains('meeting')) {
      iconName = 'ico_meeting';
    } else if (spaceName.toLowerCase().contains('single')) {
      iconName = 'ico_single';
    } else if (spaceName.toLowerCase().contains('twin')) {
      iconName = 'ico_twin';
    } else if (spaceName.toLowerCase().contains('double')) {
      iconName = 'ico_double';
    }

    return iconName;
  }

  IconData getIconData(objectName) {
    final type = objectName.toLowerCase().trim();
    if (type.contains('cafe') || type.contains('coffee') || type.contains('restaurant')) {
      return Icons.local_cafe;
    } else if (type.contains('delivery')) {
      return Icons.local_shipping;
    } else if (type.contains('laundry')) {
      return Icons.local_laundry_service;
    } else {
      return Icons.business_center;
    }
  }