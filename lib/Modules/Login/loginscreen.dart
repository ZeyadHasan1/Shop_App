import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Modules/Login/Cubit/bloc.dart';
import 'package:shop_app/Modules/Login/Cubit/states.dart';
import 'package:shop_app/Modules/Shop/Layout.dart';
import 'package:shop_app/Shared/Components/components.dart';
import 'package:shop_app/Shared/cashhelper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status == true) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value)
              {
                token = state.loginModel.data!.token!;

                navigateAndFinish(
                  context,
                  ShopLayout(),
                );
              });
              print(state.loginModel.data!.token);
            } else {
              showToast(
                text: '${state.loginModel.message}',
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.lightBlueAccent.withOpacity(.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Form(
                        key: formkey,
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  'Login to Start Shopping',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                TextFormField(
                                  onFieldSubmitted: (value) {
                                    if (formkey.currentState!.validate()) {
                                      email.text = value;
                                    }
                                  },
                                  validator: (s) {
                                    if (s!.isEmpty) {
                                      return 'This Field Can\'t Be Empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: email,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  validator: (s) {
                                    if (s!.isEmpty) {
                                      return 'This Field Can\'t Be Empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onFieldSubmitted: (value) {
                                    if (formkey.currentState!.validate()) {
                                      LoginCubit.get(context).postdata(
                                        email: email.text,
                                        pass: password.text,
                                      );
                                    }
                                  },
                                  controller: password,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        LoginCubit.get(context)
                                            .changevisisblity();
                                      },
                                      icon: Icon(
                                          LoginCubit.get(context).visibility),
                                    ),
                                  ),
                                  obscureText:
                                      LoginCubit.get(context).isvisibile,
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: state is! Loading ||
                                          state is LoginSuccessState
                                      ? MaterialButton(
                                          color: Colors.blue,
                                          onPressed: () {
                                            if (formkey.currentState!
                                                .validate()) {
                                              LoginCubit.get(context).postdata(
                                                email: email.text,
                                                pass: password.text,
                                              );
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              'LOGIN',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: CircularProgressIndicator()),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Have not an email ?'),
                                    SizedBox(width: 10),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text('Register Now'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
