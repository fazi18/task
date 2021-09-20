import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class TextStyleUtile {
  TextStyleUtile._();

  static TextStyle normulTextStyle(
      {required int fontSize, required Color color, double? hight}) {
    return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: fontSize.sp,
      color: color,
      height: hight,
    );
  }

  static TextStyle boldTextStyle(
      {required int fontSize, required Color color}) {
    return TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: fontSize.sp,
      color: color,
    );
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(
    double lat,
    double lng,
  ) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    } else {
      throw 'Could not open the Map';
    }
  }
}

class BrowserUtil {
  BrowserUtil._();

  static Future<void> openBrowser() async {
    const url = "https://jsonplaceholder.typicode.com/users";
    if (await canLaunch(url))
      await launch(url);
    else
      // can't launch url, there is some error
      throw "Could not launch $url";
  }
}
