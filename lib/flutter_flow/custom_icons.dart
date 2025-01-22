import 'package:flutter/widgets.dart';

class FFIcons {
  FFIcons._();

  static const String _myFlutterAppFamily = 'MyFlutterApp';
  static const String _graduationFamily = 'Graduation';
  static const String _outlineLogoFamily = 'OutlineLogo';
  static const String _recordsFamily = 'Records';
  static const String _menuFamily = 'Menu';

  // MyFlutterApp
  static const IconData kdrawing =
      IconData(0xe800, fontFamily: _myFlutterAppFamily);
  static const IconData kminiLogo =
      IconData(0xe801, fontFamily: _myFlutterAppFamily);
  static const IconData kgraduationCap =
      IconData(0xe802, fontFamily: _myFlutterAppFamily);
  static const IconData klanguage =
      IconData(0xe803, fontFamily: _myFlutterAppFamily);
  static const IconData karrowLeft =
      IconData(0xe805, fontFamily: _myFlutterAppFamily);
  static const IconData kmenuBurger =
      IconData(0xe806, fontFamily: _myFlutterAppFamily);

  // Graduation
  static const IconData kgraduation =
      IconData(0xe800, fontFamily: _graduationFamily);

  // OutlineLogo
  static const IconData koutlineLogo1 =
      IconData(0xe803, fontFamily: _outlineLogoFamily);

  // Records
  static const IconData krecords = IconData(0xe804, fontFamily: _recordsFamily);

  // Menu
  static const IconData kbars = IconData(0xe805, fontFamily: _menuFamily);
}
