import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils{

  static Future<void> saveString({required String key,required  String value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}


static Future<String> loadString(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? '';
}

static Future<void> deleteString(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}


}