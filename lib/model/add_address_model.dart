// To parse this JSON data, do
//
//     final addressAddResponse = addressAddResponseFromJson(jsonString);

import 'dart:convert';

AddressAddResponse addressAddResponseFromJson(String str) => AddressAddResponse.fromJson(json.decode(str));

String addressAddResponseToJson(AddressAddResponse data) => json.encode(data.toJson());

class AddressAddResponse {
  AddressAddResponse({
    this.result,
    this.message,
  });

  bool ? result;
  String ? message;

  factory AddressAddResponse.fromJson(Map<String, dynamic> json) => AddressAddResponse(
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
  };
}