import 'package:flutter/material.dart';
import 'package:search_image_p1/sharepreference/sharepreference.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeM = ThemeMode.light;

  checkTheme(){
    SharePref.getData('theme').then((value) {
      if(value != null){
        if(value == 'dark'){
        themeM = ThemeMode.dark;
      }
      else{
        themeM == ThemeMode.light;
      }
      }
    });
  }
  
  changeToDark(){
    themeM = ThemeMode.dark;
    SharePref.saveData('theme', 'dark');
    notifyListeners();
  }

  changeToLight(){
    themeM = ThemeMode.light;
    SharePref.saveData('theme', 'light');
    notifyListeners();
  }
}