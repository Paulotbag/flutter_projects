import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository {
  static String? firstName;
  static String? lastName;
  static String? phoneNumber;
  static String? emailAddress;

  static final EncryptedSharedPreferences _prefs = EncryptedSharedPreferences();

  static Future<void> loadData() async {
    firstName = await _prefs.getString('firstName');
    lastName = await _prefs.getString('lastName');
    phoneNumber = await _prefs.getString('phoneNumber');
    emailAddress = await _prefs.getString('emailAddress');
  }

  static Future<void> saveData() async {
    if (firstName != null) await _prefs.setString('firstName', firstName!);
    if (lastName != null) await _prefs.setString('lastName', lastName!);
    if (phoneNumber != null) await _prefs.setString('phoneNumber', phoneNumber!);
    if (emailAddress != null) await _prefs.setString('emailAddress', emailAddress!);
  }
}