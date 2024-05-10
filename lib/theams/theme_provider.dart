import 'package:flutter/material.dart';
import 'package:social_media/theams/dark_mode.dart';
import 'package:social_media/theams/light_mode.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightmode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggletheme(){
    if(_themeData == darkMode){
      themeData = lightmode;
    }else{
      themeData = darkMode;
    }
  }

}