import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Dio/Dio.dart';
import 'package:shop_app/Onboarding/onboard.dart';
import 'package:shop_app/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplshScreen(),
      themeMode: ThemeMode.light,
      theme:ThemeData(
        fontFamily: 'Fantasio',
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            statusBarColor: Colors.white,
            systemNavigationBarDividerColor: Colors.white,
          )
        )
      )
    );
  }
}