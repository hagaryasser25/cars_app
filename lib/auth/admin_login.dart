// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:cars_app/admin/admin_home.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:ndialog/ndialog.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import 'admin_login.dart';

class AdminLogin extends StatefulWidget {
  static const routeName = '/adminLogin';
  AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  // text editing controllers
  final passwordController = TextEditingController();

  final emailController = TextEditingController();

  double _sigmaX = 5;
  // from 0-10
  double _sigmaY = 5;
  // from 0-10
  double _opacity = 0.2;

  double _width = 350;

  double _height = 300;

  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() {
    if (_formKey.currentState!.validate()) {
      print('valid');
    } else {
      print('not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          backgroundColor: Colors.grey[300],
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/car.jpg',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.26),
                      Padding(
                        padding: EdgeInsets.only(right: 75.w),
                        child: const Text("تسجيل الدخول",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: _sigmaX, sigmaY: _sigmaY),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(0, 0, 0, 1)
                                    .withOpacity(_opacity),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.51,
                            child: Form(
                              key: _formKey,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 75.h,
                                      child: MyTextField(
                                        controller: emailController,
                                        hintText: 'البريد الألكترونى',
                                        obscureText: false,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 75.h,
                                      child: MyPasswordTextField(
                                        controller: passwordController,
                                        hintText: 'كلمة السر',
                                        obscureText: true,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SizedBox(
                                          height: 60.h,
                                          child: MyButtonAgree(
                                            text: "سجل دخول",
                                            onTap: () async {
                                              var email =
                                                  emailController.text.trim();
                                              var password = passwordController
                                                  .text
                                                  .trim();

                                              if (email.isEmpty ||
                                                  password.isEmpty) {
                                                MotionToast(
                                                        primaryColor:
                                                            Colors.blue,
                                                        width: 300,
                                                        height: 50,
                                                        position:
                                                            MotionToastPosition
                                                                .center,
                                                        description: Text(
                                                            "please fill all fields"))
                                                    .show(context);

                                                return;
                                              }
                                              if (email != 'admin@gmail.com') {
                                                CherryToast.info(
                                                  title: Text(
                                                      'Wrong email or password'),
                                                  actionHandler: () {},
                                                ).show(context);

                                                return;
                                              }

                                              if (password != '123456789') {
                                                CherryToast.info(
                                                  title: Text(
                                                      'Wrong email or password'),
                                                  actionHandler: () {},
                                                ).show(context);

                                                return;
                                              }

                                              ProgressDialog progressDialog =
                                                  ProgressDialog(context,
                                                      title: Text('Logging In'),
                                                      message:
                                                          Text('Please Wait'));
                                              progressDialog.show();

                                              try {
                                                FirebaseAuth auth =
                                                    FirebaseAuth.instance;
                                                UserCredential userCredential =
                                                    await auth
                                                        .signInWithEmailAndPassword(
                                                            email: email,
                                                            password: password);

                                                if (userCredential.user !=
                                                    null) {
                                                  progressDialog.dismiss();
                                                  Navigator.pushNamed(context,
                                                      AdminHome.routeName);
                                                }
                                              } on FirebaseAuthException catch (e) {
                                                progressDialog.dismiss();
                                                if (e.code ==
                                                    'user-not-found') {
                                                  MotionToast(
                                                          primaryColor:
                                                              Colors.blue,
                                                          width: 300,
                                                          height: 50,
                                                          position:
                                                              MotionToastPosition
                                                                  .center,
                                                          description: Text(
                                                              "user not found"))
                                                      .show(context);

                                                  return;
                                                } else if (e.code ==
                                                    'wrong-password') {
                                                  MotionToast(
                                                          primaryColor:
                                                              Colors.blue,
                                                          width: 300,
                                                          height: 50,
                                                          position:
                                                              MotionToastPosition
                                                                  .center,
                                                          description: Text(
                                                              "wrong email or password"))
                                                      .show(context);

                                                  return;
                                                }
                                              } catch (e) {
                                                MotionToast(
                                                        primaryColor:
                                                            Colors.blue,
                                                        width: 300,
                                                        height: 50,
                                                        position:
                                                            MotionToastPosition
                                                                .center,
                                                        description: Text(
                                                            "something went wrong"))
                                                    .show(context);

                                                progressDialog.dismiss();
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
