import 'package:cars_app/admin/add_gallery.dart';
import 'package:cars_app/gallery/add_car.dart';
import 'package:cars_app/models/cars_model.dart';
import 'package:cars_app/models/gallery_model.dart';
import 'package:cars_app/user/buy_car.dart';
import 'package:cars_app/user/replace_car.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class UserCars extends StatefulWidget {
  String galleryName;
  static const routeName = '/galleryCars';
  UserCars({required this.galleryName});

  @override
  State<UserCars> createState() => _UserCarsState();
}

class _UserCarsState extends State<UserCars> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Cars> carsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCars();
  }

  @override
  void fetchCars() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("cars").child(widget.galleryName);
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Cars p = Cars.fromJson(event.snapshot.value);
      carsList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {
        print(carsList.length);
      });
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
              'السيارات',
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
                  itemCount: carsList.length,
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
                                            carsList[index].imageUrl.toString()),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        carsList[index].name.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Marhey',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'موديل السيارة : ${carsList[index].model.toString()}',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'سعة الموتور : ${carsList[index].capacity.toString()}',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'السعر : ${carsList[index].price.toString()}',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'الألوان المتوفرة : ${carsList[index].color.toString()}',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(
                                            width: 100.w, height: 40.h),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blue,
                                          ),
                                          onPressed: () async {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return BuyCar(
                                                galleryName:
                                                    widget.galleryName,
                                                carName: carsList[index].name.toString(),
                                              );
                                            }));
                                          },
                                          child: Text("شراء",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(
                                            width: 100.w, height: 40.h),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blue,
                                          ),
                                          onPressed: () async {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return ReplaceCar(
                                                galleryName:
                                                    widget.galleryName,
                                                carName: carsList[index].name.toString(),
                                              );
                                            }));
                                          },
                                          child: Text("استبدال",
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
