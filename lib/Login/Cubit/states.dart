import 'package:shop_app/Models/LoginModel.dart';

abstract class LoginStates {}

class InitState extends LoginStates {}

class Loading extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginFaildState extends LoginStates {
  final LoginModel loginModel;

  LoginFaildState(this.loginModel);
}

class ChangeVisibilty extends LoginStates {}
