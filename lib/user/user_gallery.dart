import 'package:cars_app/admin/add_gallery.dart';
import 'package:cars_app/models/gallery_model.dart';
import 'package:cars_app/user/user_cars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class UserGallery extends StatefulWidget {
  static const routeName = '/userGallery';
  const UserGallery({super.key});

  @override
  State<UserGallery> createState() => _UserGalleryState();
}

class _UserGalleryState extends State<UserGallery> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Gallery> galleryList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchGallerys();
  }

  @override
  void fetchGallerys() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("gallery");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Gallery p = Gallery.fromJson(event.snapshot.value);
      galleryList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
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
            title: Text(
              'المعارض',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: Container(
            child: Padding(
              padding: EdgeInsets.only(
                top: 15.h,
                right: 10.w,
                left: 10.w,
              ),
              child: ListView.builder(
                  itemCount: galleryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 15, bottom: 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 15.w),
                                        child: Image.network(
                                            '${galleryList[index].imageUrl.toString()}'),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        '${galleryList[index].name.toString()}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Marhey',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        '${galleryList[index].email.toString()}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Marhey',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        '${galleryList[index].phoneNumber.toString()}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Marhey',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        '${galleryList[index].address.toString()}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Marhey',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(
                                            width: 200.w, height: 50.h),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blue,
                                          ),
                                          onPressed: () async {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return UserCars(
                                                galleryName:
                                                    '${galleryList[index].name.toString()}',
                                              );
                                            }));
                                          },
                                          child: Text("السيارات",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
