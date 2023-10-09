import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/base.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/home_layout/home_layout.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/create_account/signUp_ViewModel.dart';
import 'package:todo/screens/create_account/signUp_connector.dart';
import 'package:todo/screens/login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends BaseView<SignUpViewModel, SignUpScreen> implements SignUpConnector{
  var nameController = TextEditingController();

  var birthdayController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.connector=this;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      builder: (context, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Image.asset(
              "assets/images/signup_bg.png",
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
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter name";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text("Name"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: birthdayController,
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your Date of Birth";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text("Date of Birth"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);
                              if (value == null || value.isEmpty) {
                                return "Please enter Email";
                              } else if (!emailValid) {
                                return "Please enter a valid Username or Email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                label: Text("Email Address"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
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
                                        color: Theme
                                            .of(context)
                                            .primaryColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Theme
                                            .of(context)
                                            .primaryColor))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                viewModel.createAccount(
                                    nameController.text, emailController.text,
                                    passwordController.text,
                                    birthdayController.text, (){
                                      provider.initUser();
                                });
                                // FirebaseFunctions.createAuthAccount(
                                //     nameController.text,
                                //     birthdayController.text,
                                //     emailController.text,
                                //     passwordController.text, (){
                                //       provider.initUser();
                                //       Navigator.pushReplacementNamed(context, HomeLayout.routeName);
                                // });
                              }
                            },
                            child: Text("Sign Up"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text("I have an account"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: Text("Login"))
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
      //   resizeToAvoidBottomInset: false,
      //   body: Stack(
      //     children: [
      //       Image.asset(
      //         "assets/images/signup_bg.png",
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
      //                       controller: nameController,
      //                       keyboardType: TextInputType.name,
      //                       validator: (value) {
      //                         if (value == null || value.isEmpty) {
      //                           return "Please enter name";
      //                         }
      //                         return null;
      //                       },
      //                       decoration: InputDecoration(
      //                           label: Text("Name"),
      //                           border: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(12),
      //                               borderSide: BorderSide(
      //                                   color: Theme
      //                                       .of(context)
      //                                       .primaryColor)),
      //                           enabledBorder: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(12),
      //                               borderSide: BorderSide(
      //                                   color: Theme
      //                                       .of(context)
      //                                       .primaryColor))),
      //                     ),
      //                     SizedBox(
      //                       height: 20,
      //                     ),
      //                     TextFormField(
      //                       controller: birthdayController,
      //                       keyboardType: TextInputType.datetime,
      //                       validator: (value) {
      //                         if (value == null || value.isEmpty) {
      //                           return "Please enter your Date of Birth";
      //                         }
      //                         return null;
      //                       },
      //                       decoration: InputDecoration(
      //                           label: Text("Date of Birth"),
      //                           border: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(12),
      //                               borderSide: BorderSide(
      //                                   color: Theme
      //                                       .of(context)
      //                                       .primaryColor)),
      //                           enabledBorder: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(12),
      //                               borderSide: BorderSide(
      //                                   color: Theme
      //                                       .of(context)
      //                                       .primaryColor))),
      //                     ),
      //                     SizedBox(
      //                       height: 20,
      //                     ),
      //                     TextFormField(
      //                       controller: emailController,
      //                       keyboardType: TextInputType.emailAddress,
      //                       validator: (value) {
      //                         bool emailValid = RegExp(
      //                             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      //                             .hasMatch(value!);
      //                         if (value == null || value.isEmpty) {
      //                           return "Please enter Email";
      //                         } else if (!emailValid) {
      //                           return "Please enter a valid Username or Email";
      //                         }
      //                         return null;
      //                       },
      //                       decoration: InputDecoration(
      //                           label: Text("Email Address"),
      //                           border: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(12),
      //                               borderSide: BorderSide(
      //                                   color: Theme
      //                                       .of(context)
      //                                       .primaryColor)),
      //                           enabledBorder: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(12),
      //                               borderSide: BorderSide(
      //                                   color: Theme
      //                                       .of(context)
      //                                       .primaryColor))),
      //                     ),
      //                     SizedBox(
      //                       height: 20,
      //                     ),
      //                     TextFormField(
      //                       controller: passwordController,
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
      //                                   color: Theme
      //                                       .of(context)
      //                                       .primaryColor)),
      //                           enabledBorder: OutlineInputBorder(
      //                               borderRadius: BorderRadius.circular(12),
      //                               borderSide: BorderSide(
      //                                   color: Theme
      //                                       .of(context)
      //                                       .primaryColor))),
      //                     ),
      //                     SizedBox(
      //                       height: 20,
      //                     ),
      //                     ElevatedButton(
      //                       onPressed: () {
      //                         if (formKey.currentState!.validate()) {
      //                           viewModel.createAccount(
      //                               nameController.text, emailController.text,
      //                               passwordController.text,
      //                               birthdayController.text);
      //                           // FirebaseFunctions.createAuthAccount(
      //                           //     nameController.text,
      //                           //     birthdayController.text,
      //                           //     emailController.text,
      //                           //     passwordController.text, (){
      //                           //       provider.initUser();
      //                           //       Navigator.pushReplacementNamed(context, HomeLayout.routeName);
      //                           // });
      //                         }
      //                       },
      //                       child: Text("Sign Up"),
      //                     ),
      //                     SizedBox(
      //                       height: 20,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Row(
      //                 children: [
      //                   Text("I have an account"),
      //                   TextButton(
      //                       onPressed: () {
      //                         Navigator.pushReplacementNamed(
      //                             context, LoginScreen.routeName);
      //                       },
      //                       child: Text("Login"))
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
  SignUpViewModel initViewModel() {
    return SignUpViewModel();
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, HomeLayout.routeName);
  }
}
