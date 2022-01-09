import 'package:shared_preferences/shared_preferences.dart';

class SharePref{
  static saveData(String key, String value)async{
    var shp = await SharedPreferences.getInstance();
    return shp.setString(key, value);
  }

  static Future getData(String key)async{
    var shp = await SharedPreferences.getInstance();
    return shp.getString(key);    
  }
}