// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Settings extends ChangeNotifier {
//   String? _savedId;
//   String? _defaultName;

//   String? get savedId => _savedId;
//   String? get defaultName => _defaultName;

//   Settings() {
//     readData();
//   }

//   // readData() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   _savedId = prefs.getString('savedId');
//   //   _defaultName = prefs.getString('defaultName');
//   //   notifyListeners();
//   // }

//   // setSavedId(String newId) async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   await prefs.setString('savedId', newId);
//   //   _savedId = newId;
//   //   notifyListeners();
//   // }

//   // setDefaultName(String newName) async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   await prefs.setString('defaultName', newName);
//   //   _defaultName = newName;
//   //   notifyListeners();
//   // }
// }
