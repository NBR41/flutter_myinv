import 'package:flutter/material.dart';
import '../service/factory.dart';

final servFactory = ServiceFactory(domain: 'foo');

const TITLE = 'MyInventory';

/// STYLES
const BIGGERFONT = TextStyle(fontSize: 18.0);
const MYSTYLEBIGBOLDWHITE =
    TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold);
const MYSTYLEMEDIUMBOLDWHITE =
    TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold);
//var mainColor = Colors.purple.shade200.withOpacity(0.5);

/// COLORS
final myColorBlue = const Color(0xff0C7088);
final myColorGreen = const Color(0xff1DBF90);
final myColorYellow = const Color(0xffDEDC9E);
final myColorOrange = const Color(0xffDC9A55);
final myColorRed = const Color(0xffD84A49);

final myPrimarySwatch = MaterialColor(
  0xff0C7088,
  {
    50: const Color(0xffe2eef1),
    100: const Color(0xffb6d4db),
    200: const Color(0xff86b8c4),
    300: const Color(0xff559bac),
    400: const Color(0xff30859a),
    500: const Color(0xff0c7088),
    600: const Color(0xff0a6880),
    700: const Color(0xff085d75),
    800: const Color(0xff06536b),
    900: const Color(0xff034158),
  },
);
