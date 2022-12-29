import 'package:flutter/material.dart';
import 'package:food_app/database/database_helper.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';
import '../model/cart_model.dart';
import '../utils/local_assets_image.dart';
List<Cart> availabeCart =[];
DBHelper dbHelper = DBHelper();

class SpalashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dbHelper.getCartList();
    return Scaffold(
      body: GetBuilder(
        init: SplashController(),
        builder: (_) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(SPLASH_IMAGE),
                  fit: BoxFit.contain
                )),
          );
        },
      ),
    );
  }
}
