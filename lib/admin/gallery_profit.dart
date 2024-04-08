import 'package:cars_app/models/buying_model.dart';
import 'package:cars_app/models/profit_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class GalleryProfit extends StatefulWidget {
  static const routeName = '/galleryProfit';
  GalleryProfit({
    super.key,
  });

  @override
  State<GalleryProfit> createState() => _GalleryProfitState();
}

class _GalleryProfitState extends State<GalleryProfit> {
  List<Profit> profits = [
    Profit(
      name: "الجوكر",
      profit: '60%',
      loss: '10%',
      duration: 'نصف سنوى',
    ),
    Profit(
      name: "Autohub",
      profit: '40%',
      loss: '12%',
      duration: "ربع سنوى",
    ),
    Profit(
      name: "بنزاوى",
      profit: '50%',
      loss: '5%',
      duration: 'نصف سنوى',
    ),
    Profit(
      name: "سليندر",
      profit: '30%',
      loss: '15%',
      duration: "ربع سنوى",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                backgroundColor: Colors.blue,
                title: Center(
                    child: Text(
                  "طلبات الشراء",
                  style: TextStyle(color: Colors.white),
                )),
              ),
              body: Column(children: [
                Expanded(
                  flex: 8,
                  child: ListView.builder(
                    itemCount: profits.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 15, left: 15, bottom: 10),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'اسم المعرض : ${profits[index].name.toString()}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Cairo'),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'نسبة الربح : ${profits[index].profit.toString()}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Cairo'),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'نسبة الخسارة : ${profits[index].loss.toString()}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Cairo'),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'المدة الزمنية : ${profits[index].duration.toString()}',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Cairo'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ])),
        ));
  }
}
