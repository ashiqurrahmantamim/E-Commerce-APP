import 'dart:convert';

import 'package:food_app/model/search_model.dart';

import '../model/product_model.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<SearchModel?> getProductdata(String searchName) async {
    var response = await http.get(Uri.parse(
        "https://grocery.ebasket.com.bd/api/products?search=name:$searchName;status:publish&searchJoin=and&page=1&limit=50"));
    if (response.statusCode == 200) {
       var jsonResponse = json.decode(response.body);
      final myMap = Map<String, dynamic>.from(jsonResponse);
      return SearchModel.fromJson(myMap);
    }
  }
}
