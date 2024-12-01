import 'package:flutter/material.dart';
import 'package:lab_assessment_1/services/shared_prefs_service.dart';

class theme extends ChangeNotifier{
  bool _dark= SharedPrefs().getBool('dark')?? false ;

  bool get dark => _dark;

  void changeTheme(){
    _dark= !_dark;
    SharedPrefs().saveBool('dark', _dark);
    notifyListeners();
}
}