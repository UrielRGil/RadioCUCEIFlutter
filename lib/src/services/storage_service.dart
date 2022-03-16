import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static late SharedPreferences _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool isPlayerIdSave() {
    final resp = _prefs.getString('player_id') ?? '';
    return resp.isNotEmpty;
  }

  static String get idPlayer => _prefs.getString('player_id') ?? '';
  static savePlayerId(String? id) {
    if (id != null) {
      _prefs.setString('player_id', id);
    }
  }
}
