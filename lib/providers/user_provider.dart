import 'package:flutter/foundation.dart';

import '../models/user_profile.dart';

class UserProvider extends ChangeNotifier {
  UserProfile? _user;

  UserProfile? get user => _user;
  bool get isLoggedIn => _user != null;

  void login(UserProfile user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  void updateProfile(UserProfile newProfile) {
    _user = newProfile;
    notifyListeners();
  }
}
