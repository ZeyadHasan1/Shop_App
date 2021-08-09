import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Dio/Dio.dart';
import 'package:shop_app/Login/Cubit/states.dart';
import 'package:shop_app/Login/end_points.dart';
import 'package:shop_app/Models/LoginModel.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitState());

  static LoginCubit get(context)=> BlocProvider.of(context);

  late LoginModel loginmodel;

  void getdate() {
    DioHelper.getdata(
      method: '',
      query: '',
    );
  }

  void postdata({
    required String email,
    required String pass,
  }) {
    emit(Loading());
    DioHelper.insertdata(
      method: LOGIN,
      data: {
        'email': email,
        'password': pass,
      },
    ).then(
      (value) {
       loginmodel = LoginModel.profiledata(value.data);
        emit(LoginSuccessState(loginmodel));
      },
    ).catchError(
      (error) {
        print(
          error.toString(),
        );
        emit(LoginFaildState(loginmodel));
      },
    );
  }

  bool isvisibile = true ;
  IconData visibility = Icons.visibility_outlined ;

  void changevisisblity(){
    isvisibile = !isvisibile ;
    isvisibile==true?visibility=Icons.visibility_outlined:
    visibility=Icons.visibility_off_outlined;
    emit(ChangeVisibilty());
  }
}
