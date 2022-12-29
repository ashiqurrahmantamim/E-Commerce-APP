import 'package:food_app/screens/home_screen.dart';
import 'package:food_app/screens/registration_screen.dart';
import 'package:get/get.dart';

import '../local/shared_data.dart';
import '../screens/login_screen.dart';
import '../session/key_text.dart';

class SplashController extends GetxController {
  String ? token;

  getToken() async {
     await MyPrefs.getToken().then((value) {
      token = value;
      update();
    });
    update();
  }


  @override
  void onReady() async {
    await getToken();
    if(token==null || token == ""){
      Future.delayed(Duration(seconds: 5),(){
        Get.offAll(LoginScreen());

      });

    }else{
      Get.offAll(HomeScreen());
    }



    super.onReady();
  }
}
