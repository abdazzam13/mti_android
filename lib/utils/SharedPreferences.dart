import 'package:shared_preferences/shared_preferences.dart';

import 'Constants.dart';

class SharedPref {
  static SharedPreferences? _sharedPref;

  static Future init() async =>
      _sharedPref ??= await SharedPreferences.getInstance();

  static Future setIsFirstTime(bool isFirstTime) async =>
      await _sharedPref?.setBool(isFirstTimeKey, isFirstTime);
  bool? getIsFirstTime() => _sharedPref?.getBool(isFirstTimeKey) ?? false;

  static Future setEmail(String email) async =>
      await _sharedPref?.setString(emailKey, email);
  String? getEmail() => _sharedPref?.getString(emailKey);

  static Future setUsername(String username) async =>
      await _sharedPref?.setString(usernameKey, username);
  String? getUsername() => _sharedPref?.getString(usernameKey);

  static Future setPassword(String password) async =>
      await _sharedPref?.setString(passwordKey, password);
  String? getPassword() => _sharedPref?.getString(passwordKey);

  static Future setName(String name) async =>
      await _sharedPref?.setString(nameKey, name);
  String? getName() => _sharedPref?.getString(nameKey);

  static Future setAvatar(String avatar) async =>
      await _sharedPref?.setString(avatarKey, avatar);
  String? getAvatar() => _sharedPref?.getString(avatarKey);

  static Future setDisplayName(String displayName) async =>
      await _sharedPref?.setString(displayNameKey, displayName);
  String? getDisplayName() => _sharedPref?.getString(displayNameKey);

  static Future setIsLogin(bool isLogin) async =>
      await _sharedPref?.setBool(isLoginKey, isLogin);
  bool? getIsLogin() => _sharedPref?.getBool(isLoginKey) ?? false;

  static Future setIsLoginByGoogle(bool isLogin) async =>
      await _sharedPref?.setBool(isLoginByGoogleKey, isLogin);
  bool? getIsLoginByGoogle() => _sharedPref?.getBool(isLoginByGoogleKey) ?? false;

}