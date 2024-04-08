import 'package:cars_app/admin/add_gallery.dart';
import 'package:cars_app/admin/admin_gallery.dart';
import 'package:cars_app/auth/login_page.dart';
import 'package:cars_app/gallery/buying_gallery.dart';
import 'package:cars_app/gallery/gallery_cars.dart';
import 'package:cars_app/gallery/replacing_gallery.dart';
import 'package:cars_app/models/galleryu_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class GalleryHome extends StatefulWidget {
  static const routeName = '/galleryHome';
  const GalleryHome({super.key});

  @override
  State<GalleryHome> createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late GalleryU currentUser;

  void didChangeDependencies() {
    getUserData();
    super.didChangeDependencies();
  }

  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("gallery")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = GalleryU.fromSnapshot(snapshot);
    });
  }

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
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Open shopping cart',
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('تأكيد'),
                            content: Text('هل انت متأكد من تسجيل الخروج'),
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
                ),
              ],
            ),
            body: Column(
              children: [
                Center(
                    child:
                        Image.asset("assets/images/hh.png", height: 400.h)),
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return GalleryCars(
                                galleryName: '${currentUser.name}',
                              );
                            }));
                          },
                          child: card("اضافة سيارة", )),
                      SizedBox(
                        width: 13.w,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return BuyingGallery(
                                name: '${currentUser.name}',
                              );
                            }));
                          },
                          child: card("طلبات الشراء", )),
                      SizedBox(
                        width: 13.w,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ReplacingGallery(
                                name: '${currentUser.name}',
                              );
                            }));
                          },
                          child: card("طلبات البدل", )),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

Widget card(String text) {
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
            child: Image.asset('assets/images/hh.png'),
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
