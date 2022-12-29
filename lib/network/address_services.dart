// import 'package:food_app/local/shared_data.dart';
// import 'package:food_app/session/key_text.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
//
// import '../model/add_address_model.dart';
// import '../model/get_address_model.dart';
//
// class AddressRepository {
//   String? token;
//   String? userId;
//
//   Future<AddressResponse> getAddressList() async {
//     token = await SharedPref.getPrefarance(TOKEN);
//
//     Uri url = Uri.parse("https://bdraj.com/api/v2/user/shipping/address");
//     final response = await http.get(
//       url,
//       headers: {
//         "Content-Type": "application/json",
//         "Authorization": "Bearer ${token}",
//       },
//     );
//     print("response.body.toString()${response.body.toString()}");
//
//     return addressResponseFromJson(response.body);
//   }
//
//   Future<AddressResponse> getHomeDeliveryAddress() async {
//     token = await SharedPref.getPrefarance(TOKEN);
//
//     Uri url = Uri.parse("https://bdraj.com/api/v2/get-home-delivery-address");
//     final response = await http.get(
//       url,
//       headers: {
//         "Content-Type": "application/json",
//         "Authorization": "Bearer ${token}",
//       },
//     );
//
//     return addressResponseFromJson(response.body);
//   }
//
//   Future<AddressAddResponse> getAddressAddResponse(
//       {@required String? address,
//       @required int? country_id,
//       @required int? state_id,
//       @required int? city_id,
//       @required String? postal_code,
//       @required String? phone}) async {
//     userId = await SharedPref.getPrefarance(USERID);
//     token = await SharedPref.getPrefarance(TOKEN);
//
//     var post_body = jsonEncode({
//       "user_id": "${userId}",
//       "address": "$address",
//       "country_id": "$country_id",
//       "state_id": "$state_id",
//       "city_id": "$city_id",
//       "postal_code": "$postal_code",
//       "phone": "$phone"
//     });
//
//     Uri url = Uri.parse("https://bdraj.com/api/v2/user/shipping/create");
//     final response = await http.post(url,
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer ${token}",
//         },
//         body: post_body);
//
//     return addressAddResponseFromJson(response.body);
//   }
// }
