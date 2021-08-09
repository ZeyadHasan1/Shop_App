import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Modules/Login/loginscreen.dart';
import 'package:shop_app/Modules/Onboarding/onboard.dart';
import 'package:shop_app/Modules/Shop/Layout.dart';
import 'package:shop_app/Shared/Dio/Dio.dart';
import 'package:shop_app/Shared/cashhelper.dart';
import 'package:shop_app/bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding == true) {
    if (token != '')
      widget = ShopLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoard();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
        themeMode: ThemeMode.light,
        theme: ThemeData(
            fontFamily: 'Fantasio',
            appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarColor: Colors.white,
                  statusBarColor: Colors.white,
                  systemNavigationBarDividerColor: Colors.white,
                ))));
  }
}
