import 'package:flutter/material.dart';
import 'package:my_insta/models/user_model.dart';
import 'package:my_insta/resources/auth_methods.dart';

class UserProvider with ChangeNotifier{
  UserModel? _userModel ;
  UserModel get getUser => _userModel!;
 final AuthMethods _authMethods = AuthMethods();
  Future<void>refreshUser() async{
    UserModel userModel = await _authMethods.getUserDetails();
    _userModel = userModel;
    notifyListeners();
  }
}