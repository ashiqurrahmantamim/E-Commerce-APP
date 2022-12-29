import 'package:food_app/model/product_model.dart';
import 'package:food_app/model/search_model.dart';
import 'package:food_app/network/product_services.dart';
import 'package:food_app/network/search_services.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var loader = false.obs;
  var searhList = SearchModel().obs;
  final SearchServices _searchServices = SearchServices();

  @override
  void onInit() {
    super.onInit();
  }

  void getData(String name) async {
    loader.value = true;

    var resultdata = await _searchServices.getProductdata(name);
    if (resultdata != null) {
      searhList.value = resultdata;
      loader.value = false;
      update();
    }
  }
}
