
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
@singleton
class Shared{
  final SharedPreferences sharedPreferences;
  const Shared({required this.sharedPreferences});
  set token(String? param) {
    if (param == null) {
      sharedPreferences.remove('token');
    } else {
      sharedPreferences.setString('token', param);
    }
  }

  String? get token {
    try {
      final tokenStr = sharedPreferences.getString('token');
      return tokenStr;
    } catch (e) {
      return null;
    }
  }
}