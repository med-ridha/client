import 'package:juridoc/module/UserModule.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static SharedPreferences? _prefs;

  static const _keyName = 'name';
  static const _keySurname = 'surname';
  static const _keyEmail = 'email';
  static const _keyPhoneNumber = "phoneNumber";
  static const _keyNomStructure = "nomStructure";
  static const _keyPhoneStructure = "phoneStructure";
  static const _keyAdressStructure = "adressStructure";
  static const _keyNumFiscal = "numFiscal";
  static const _keyFavored = "favored";
  static const _keyAbonnement = "abonnement";
  static const _keyCollabId = "collabId";
  static const _keyIsLogedIn = "IsLogedIn";
  static const _keyIsCollabOwner = "IsCollabOwner";
  static const _keyModulesHasAccessTo = "ModulesHasAccessTo";

  static Future save(UserModule user) async {
    await UserPrefs.setName(user.name!);
    await UserPrefs.setSurname(user.surname!);
    await UserPrefs.setEmail(user.email!);
    await UserPrefs.setPhoneNumber(user.phoneNumber!);
    await UserPrefs.setNomStructure(user.nomStructure!);
    await UserPrefs.setPhoneStructure(user.phoneStructure!);
    await UserPrefs.setNumFiscal(user.numFiscal!);
    await UserPrefs.setAdressStructure(user.adressStructure!);
    await UserPrefs.setCollabId(user.collabId ?? "");
    await UserPrefs.setListFavorit(user.favored ?? []);
    await UserPrefs.setListAbonn(user.abonnement ?? []);
  }

  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static Future clear() async => await _prefs!.clear();

  static Future setModulesHasAccessTo(List<String> value) async =>
      await _prefs!.setStringList(_keyModulesHasAccessTo, value);

  static List<String> getModulesHasAccessTo() =>
      _prefs!.getStringList(_keyModulesHasAccessTo) ?? [];

  static Future setListFavorit(List<String> value) async =>
      await _prefs!.setStringList(_keyFavored, value);

  static List<String> getListFavorit() =>
      _prefs!.getStringList(_keyFavored) ?? [];

  static Future setListAbonn(List<String> value) async =>
      await _prefs!.setStringList(_keyAbonnement, value);

  static List<String> getListAbonn() =>
      _prefs!.getStringList(_keyAbonnement) ?? [];

  static Future setIsCollabOwner(bool value) async =>
      await _prefs!.setBool(_keyIsCollabOwner, value);

  static bool getIsCollabOwner() => _prefs!.getBool(_keyIsCollabOwner) ?? false;

  static Future setIsLogedIn(bool value) async =>
      await _prefs!.setBool(_keyIsLogedIn, value);

  static bool? getIsLogedIn() => _prefs!.getBool(_keyIsLogedIn) ?? false;

  static Future setCollabId(String value) async =>
      await _prefs!.setString(_keyCollabId, value);

  static String? getCollabId() => _prefs!.getString(_keyCollabId);

  static Future setName(String value) async =>
      await _prefs!.setString(_keyName, value);

  static String? getName() => _prefs!.getString(_keyName);

  static Future setSurname(String value) async =>
      await _prefs!.setString(_keySurname, value);

  static String? getSurname() => _prefs!.getString(_keySurname);

  static Future setEmail(String value) async =>
      await _prefs!.setString(_keyEmail, value);

  static String? getEmail() => _prefs!.getString(_keyEmail);

  static Future setPhoneNumber(String value) async =>
      await _prefs!.setString(_keyPhoneNumber, value);

  static String? getPhoneNumber() => _prefs!.getString(_keyPhoneNumber);

  static Future setNomStructure(String value) async =>
      await _prefs!.setString(_keyNomStructure, value);

  static String? getNomStructure() => _prefs!.getString(_keyNomStructure);

  static Future setPhoneStructure(String value) async =>
      await _prefs!.setString(_keyPhoneStructure, value);

  static String? getPhoneStructure() => _prefs!.getString(_keyPhoneStructure);

  static Future setAdressStructure(String value) async =>
      await _prefs!.setString(_keyAdressStructure, value);

  static String? getAdressStructure() => _prefs!.getString(_keyAdressStructure);

  static Future setNumFiscal(String value) async =>
      await _prefs!.setString(_keyNumFiscal, value);

  static String? getNumFiscal() => _prefs!.getString(_keyNumFiscal);
}
