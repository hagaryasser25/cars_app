import 'package:cars_app/admin/add_gallery.dart';
import 'package:cars_app/admin/admin_gallery.dart';
import 'package:cars_app/admin/buying_list.dart';
import 'package:cars_app/admin/replacing_list.dart';
import 'package:cars_app/admin/selling_list.dart';
import 'package:cars_app/auth/login_page.dart';
import 'package:cars_app/user/buy_car.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/adminHome';
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Center(
                  child: Text(
                'الصفحة الرئيسية',
                style: TextStyle(color: Colors.white),
              )),
            ),
            body: Column(
              children: [
                Center(
                    child: Image.asset("assets/images/car.png", height: 320.h)),
                Text(
                  "الخدمات",
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'Lemonada',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, BuyingList.routeName);
                          },
                          child: card('طلبات الشراء', Icons.wallet)),
                      SizedBox(
                        width: 13.w,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, SellingList.routeName);
                          },
                          child: card("طلبات البيع", Icons.sell)),
                      SizedBox(
                        width: 13.w,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, ReplacingList.routeName);
                          },
                          child: card("طلبات البدل", Icons.car_rental)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AdminGallery.routeName);
                          },
                          child: card("أضافة معرض", Icons.add)),
                      SizedBox(
                        width: 13.w,
                      ),
                      InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('تأكيد'),
                                    content:
                                        Text('هل انت متأكد من تسجيل الخروج'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          Navigator.pushNamed(
                                              context, UserLogin.routeName);
                                        },
                                        child: Text('نعم'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('لا'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: card("تسجيل الخروج", Icons.logout)),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

Widget card(String text, IconData icon) {
  return Container(
    color: HexColor('#ffffff'),
    child: Card(
      elevation: 0.5,
      color: HexColor('#ffffff'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: 100.w,
        height: 130.h,
        child: Column(children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: HexColor('#D4E5F3'),
            ),
            child: Icon(
              icon,
              color: Colors.blue,
            ),
            alignment: Alignment.center,
          ),
          SizedBox(height: 5),
          Text(text,
              style: TextStyle(
                fontSize: 16,
              ))
        ]),
      ),
    ),
  );
}
