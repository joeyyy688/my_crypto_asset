// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:my_crypto_asset/models/userInfo.dart';

class UserDataProvider extends ChangeNotifier {
  //Local Variables
  UserInfoData? _userInfoData;

  //Getters
  UserInfoData get getUserInfoData => _userInfoData!;

  //Methods
  void setUserInfoData(UserInfoData user) {
    _userInfoData = user;
    notifyListeners();
  }
}
