import 'package:food_app/model/product_model.dart';
import 'package:food_app/network/product_services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var loader = false.obs;
  var productlist = ProductModel().obs;
  final ProductServices _productServices = ProductServices();

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    loader.value = true;

    var resultdata = await _productServices.getProductdata();
    if (resultdata != null) {
      productlist.value = resultdata;
      loader.value = false;
      update();
    }
  }
}
