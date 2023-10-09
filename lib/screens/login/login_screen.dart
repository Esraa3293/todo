import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/base.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/home_layout/home_layout.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/create_account/create_account.dart';
import 'package:todo/screens/login/connector.dart';
import 'package:todo/screens/login/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginViewModel, LoginScreen>
    implements LoginConnector {
  var usernameController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) => Scaffold(
        body: Stack(
          children: [
            Image.asset(
              "assets/images/login_bg.png",
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);
                              if (value == null || value.isEmpty) {
                                return "Please enter Username or Email";
                              } else if (!emailValid) {
                                return "Please enter a valid Username or Email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text("Username"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColor))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            validator: (value) {
                              RegExp regex = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              if (value == null || value.isEmpty) {
                                return "Please enter Password";
                              } else if (value.length < 6) {
                                return "Please enter at least 6 char";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text("Password"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColor))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                viewModel.login(usernameController.text,
                                    passwordController.text);
                                // FirebaseFunctions.login(usernameController.text,
                                //     passwordController.text, (value) {
                                //       showDialog(
                                //         context: context,
                                //         barrierDismissible: false,
                                //         builder: (context) => AlertDialog(
                                //           title: Text("Error"),
                                //           content: Text(value),
                                //           actions: [
                                //             ElevatedButton(
                                //                 onPressed: () {
                                //                   Navigator.pop(context);
                                //                 },
                                //                 child: Text("Ok"))
                                //           ],
                                //         ),
                                //       );
                                //     }, () {
                                //       provider.initUser();
                                //       Navigator.pushReplacementNamed(
                                //           context, HomeLayout.routeName);
                                //     });
                              }
                            },
                            child: Text("Login"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text("Don't have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, SignUpScreen.routeName);
                            },
                            child: Text("Create Account"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // child: Scaffold(
      //   body: Stack(
      //     children: [
      //       Image.asset(
      //         "assets/images/login_bg.png",
      //         width: double.infinity,
      //         fit: BoxFit.fill,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Form(
      //           key: formKey,
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Expanded(
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     TextFormField(
      //                       controller: usernameController,
      //                       keyboardType: TextInputType.emailAddress,
      //                       validator: (value) {
      //                         bool emailValid = RegExp(
      //                                 r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      //                             .hasMatch(value!);
      //                         if (value == null || value.isEmpty) {
      //                           return "Please enter Username or Email";
      //                         } else if (!emailValid) {
      //                           return "Please enter a valid Username or Email";
      //                         }
      //                         return null;
      //                       },
      //                       decoration: InputDecoration(
      //                           label: Text("Username"),
      //                           border: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(12),
      //                               borderSide: BorderSide(
      //                                   color: Theme.of(context).primaryColor)),
      //                           enabledBorder: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(12),
      //                               borderSide: BorderSide(
      //                                   color: Theme.of(context).primaryColor))),
      //                     ),
      //                     SizedBox(
      //                       height: 20,
      //                     ),
      //                     TextFormField(
      //                       controller: passwordController,
      //                       keyboardType: TextInputType.number,
      //                       obscureText: true,
      //                       validator: (value) {
      //                         RegExp regex = RegExp(
      //                             r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
      //                         if (value == null || value.isEmpty) {
      //                           return "Please enter Password";
      //                         } else if (value.length < 6) {
      //                           return "Please enter at least 6 char";
      //                         }
      //                         return null;
      //                       },
      //                       decoration: InputDecoration(
      //                           label: Text("Password"),
      //                           border: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(12),
      //                               borderSide: BorderSide(
      //                                   color: Theme.of(context).primaryColor)),
      //                           enabledBorder: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(12),
      //                               borderSide: BorderSide(
      //                                   color: Theme.of(context).primaryColor))),
      //                     ),
      //                     SizedBox(
      //                       height: 20,
      //                     ),
      //                     ElevatedButton(
      //                       onPressed: () {
      //                         if (formKey.currentState!.validate()) {
      //                           FirebaseFunctions.login(usernameController.text,
      //                               passwordController.text, (value) {
      //                             showDialog(
      //                               context: context,
      //                               barrierDismissible: false,
      //                               builder: (context) => AlertDialog(
      //                                 title: Text("Error"),
      //                                 content: Text(value),
      //                                 actions: [
      //                                   ElevatedButton(
      //                                       onPressed: () {
      //                                         Navigator.pop(context);
      //                                       },
      //                                       child: Text("Ok"))
      //                                 ],
      //                               ),
      //                             );
      //                           }, () {
      //                             provider.initUser();
      //                             Navigator.pushReplacementNamed(
      //                                 context, HomeLayout.routeName);
      //                           });
      //                         }
      //                       },
      //                       child: Text("Login"),
      //                     ),
      //                     SizedBox(
      //                       height: 20,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Row(
      //                 children: [
      //                   Text("Don't have an account?"),
      //                   TextButton(
      //                       onPressed: () {
      //                         Navigator.pushReplacementNamed(
      //                             context, SignUpScreen.routeName);
      //                       },
      //                       child: Text("Create Account"))
      //                 ],
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, HomeLayout.routeName);
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }
}
