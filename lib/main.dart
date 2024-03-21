import 'package:cars_app/admin/add_gallery.dart';
import 'package:cars_app/admin/admin_gallery.dart';
import 'package:cars_app/admin/admin_home.dart';
import 'package:cars_app/auth/admin_login.dart';
import 'package:cars_app/auth/gallery_login.dart';
import 'package:cars_app/auth/login_page.dart';
import 'package:cars_app/auth/signup_page.dart';
import 'package:cars_app/gallery/add_car.dart';
import 'package:cars_app/gallery/gallery_cars.dart';
import 'package:cars_app/gallery/gallery_home.dart';
import 'package:cars_app/user/user_gallery.dart';
import 'package:cars_app/user/user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            color: Colors.white, //<-- SEE HERE
          ),
          useMaterial3: true,
        ),
        home: FirebaseAuth.instance.currentUser == null
            ? UserLogin()
            : FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
                ? const AdminHome()
                : FirebaseAuth.instance.currentUser!.displayName == 'معرض'
                    ? const GalleryHome()
                    : UserHome(),
        routes: {
          SignUp.routeName: (ctx) => SignUp(),
          UserLogin.routeName: (ctx) => UserLogin(),
          AdminLogin.routeName: (ctx) => AdminLogin(),
          AdminHome.routeName: (ctx) => const AdminHome(),
          AdminGallery.routeName: (ctx) => const AdminGallery(),
          UserGallery.routeName: (ctx) => const UserGallery(),
          AddGallery.routeName: (ctx) => const AddGallery(),
          GalleryLogin.routeName: (ctx) => GalleryLogin(),
          GalleryHome.routeName: (ctx) => GalleryHome(),
          AddCar.routeName: (ctx) => AddCar(),
          UserHome.routeName: (ctx) => UserHome(),
        });
  }
}
