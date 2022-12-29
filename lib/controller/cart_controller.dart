import 'package:get/get.dart';

import '../database/database_helper.dart';
import '../main.dart';
import '../model/cart_model.dart';
import '../screens/splash_screen.dart';

class CartProvider extends GetxController {
  DBHelper db = DBHelper();
  int counter = 0;

  double _totalPrice = 0.0;

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;


  // getCartQuantity(int id){
  //   int ? result = 0;
  //   availableCart.forEach((element) {
  //     print("ID___${element.productId}");
  //     if(element.productId!.compareTo("$id")==0){
  //       result = element.quantity;
  //     }
  //   });
  //   return result!;
  // }

  getCartProductQuantity(int id) {
    int? res = 0;
    availabeCart!.forEach((element) {
      print(element.productId?.compareTo("$id"));
      if (element.productId?.compareTo("$id") == 0) {
        res = element.quantity;
      }
    });
    return res!;
  }

  Future<List<Cart>> getData() async {
    _cart = db.getCartList();

    return _cart;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    update();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    update();
  }

  Future<double> getTotalPrice() async {
    double items = 0;
    await db.getCartList().then((value) {
      value.forEach((element) {
        items += (element.productPrice * element.quantity!);
      });
    });

    _totalPrice = items;

    return _totalPrice;
  }

  void addCounter() {
    counter++;
    update();
  }

  void removerCounter() {
    counter--;
    update();
    getCounter();
  }

  Future<int> getCounter() async {
    await db.getCartList().then((value) {
      counter = value.length;

    });

    return counter;
  }
}
