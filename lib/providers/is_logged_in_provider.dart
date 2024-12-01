import 'package:flutter/material.dart';
import 'package:lab_assessment_1/services/shared_prefs_service.dart';

class isLogged extends ChangeNotifier{
  bool _isLoggedIn= SharedPrefs().getBool('logged')?? false ;

  bool get isLoggedIn => _isLoggedIn;

  void changeState(){
    _isLoggedIn = !_isLoggedIn;
    SharedPrefs().saveBool('logged', _isLoggedIn);
    notifyListeners();

  }

}