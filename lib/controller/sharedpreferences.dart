import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  Future localStorage({data}) async {
    //creating instance
    final prefs = await SharedPreferences.getInstance();

    return prefs;
  }

  Future localStoreForAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
