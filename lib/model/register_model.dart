// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    this.result,
    this.message,
    this.userId,
  });

  bool ? result;
  String ? message;
  int  ?userId;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    result: json["result"] == null ? null : json["result"],
    message: json["message"] == null ? null : json["message"],
    userId: json["user_id"] == null ? null : json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result,
    "message": message == null ? null : message,
    "user_id": userId == null ? null : userId,
  };
}
