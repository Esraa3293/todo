import 'package:flutter/material.dart';
import 'package:todo/shared/styles/my_theme.dart';

import 'home_layout/home_layout.dart';

void main(){
  runApp(MyApplication());
}

class MyApplication extends StatelessWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: HomeLayout.routeName,
      routes: {
        HomeLayout.routeName : (context) => HomeLayout(),
      },
    );
  }
}
