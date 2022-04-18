//@dart=2.9
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static SharedPreferences _prefs;

  static const _keyName = 'name';
  static const _keySurname = 'surname';
  static const _keyEmail = 'email';
  static const _keyPhoneNumber = "phoneNumber";
  static const _keyNomStructure = "nomStructure";
  static const _keyPhoneStructure = "phoneStructure";
  static const _keyAdressStructure = "adressStructure";
  static const _keyNumFiscal = "numFiscal";
  static const _keyFavored = "favored";
  static const _keyCollabId = "collabId";
  static const _keyAbonnement = "abonnement";
  static const _keyIsLogedIn = "IsLogedIn";


  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static Future clear() async => await _prefs.clear();

  static Future setIsLogedIn(bool value) async =>
      await _prefs.setBool(_keyIsLogedIn, value);

  static bool getIsLogedIn() => _prefs.getBool(_keyIsLogedIn);

  static Future setName(String value) async =>
      await _prefs.setString(_keyName, value);

  static String getName() => _prefs.getString(_keyName);

  static Future setSurname(String value) async =>
      await _prefs.setString(_keySurname, value);

  static String getSurname() => _prefs.getString(_keySurname);

  static Future setEmail(String value) async =>
      await _prefs.setString(_keyEmail, value);

  static String getEmail() => _prefs.getString(_keyEmail);

  static Future setPhoneNumber(String value) async =>
      await _prefs.setString(_keyPhoneNumber, value);

  static String getPhoneNumber() => _prefs.getString(_keyPhoneNumber);

  static Future setNomStructure(String value) async =>
      await _prefs.setString(_keyNomStructure, value);

  static String getNomStructure() => _prefs.getString(_keyNomStructure);

  static Future setPhoneStructure(String value) async =>
      await _prefs.setString(_keyPhoneStructure, value);

  static String getPhoneStructure() => _prefs.getString(_keyPhoneStructure);

  static Future setAdressStructure(String value) async =>
      await _prefs.setString(_keyAdressStructure, value);

  static String getAdressStructure() => _prefs.getString(_keyAdressStructure);

  static Future setNumFiscal(String value) async =>
      await _prefs.setString(_keyNumFiscal, value);

  static String getNumFiscal() => _prefs.getString(_keyNumFiscal);
}
