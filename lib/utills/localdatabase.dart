import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabase{
  SharedPreferences? sharedPreferences;

  getData({String? key})async {
    sharedPreferences=await SharedPreferences.getInstance();
    return  sharedPreferences!.getBool(key!);
  }
  setData({String? key,bool? value})async{
    sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences!.setBool(key!, value!);
  }
  removeData({String? key})async {
    sharedPreferences=await SharedPreferences.getInstance();
    return  sharedPreferences!.remove(key!);
  }
}