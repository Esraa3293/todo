import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/create_account/create_account.dart';
import 'package:todo/screens/login/login_screen.dart';
import 'package:todo/screens/update_screen.dart';
import 'package:todo/shared/styles/my_theme.dart';

import 'firebase_options.dart';
import 'home_layout/home_layout.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
    create: (context) => MyProvider(),
      child: MyApplication()));
}

class MyApplication extends StatelessWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: provider.firebaseUser != null ? HomeLayout.routeName : LoginScreen.routeName,
      routes: {
        HomeLayout.routeName : (context) => HomeLayout(),
        UpdateScreen.routeName : (context) => UpdateScreen(),
        LoginScreen.routeName : (context) => LoginScreen(),
        SignUpScreen.routeName : (context) => SignUpScreen()
      },
    );
  }
}
