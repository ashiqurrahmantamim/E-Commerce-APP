// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel({
    this.data,
    this.success,
    this.status,
  });

  List<Datum> ? data;
  bool ? success;
  int  ?status;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    success: json["success"] == null ? null : json["success"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "success": success == null ? null : success,
    "status": status == null ? null : status,
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.apartment,
    this.floorNo,
    this.userId,
    this.address,
    this.countryId,
    this.stateId,
    this.cityId,
    this.countryName,
    this.stateName,
    this.cityName,
    this.postalCode,
    this.phone,
    this.setDefault,
    this.locationAvailable,
    this.lat,
    this.lang,
  });

  int ? id;
  String ? name;
  String  ?apartment;
  String ? floorNo;
  int ? userId;
  String ? address;
  int  ?countryId;
  int  ?stateId;
  int  ?cityId;
  String ? countryName;
  String ? stateName;
  String  ?cityName;
  dynamic? postalCode;
  String  ?phone;
  int ? setDefault;
  bool ? locationAvailable;
  double ? lat;
  double ? lang;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    apartment: json["apartment"] == null ? null : json["apartment"],
    floorNo: json["floor_no"] == null ? null : json["floor_no"],
    userId: json["user_id"] == null ? null : json["user_id"],
    address: json["address"] == null ? null : json["address"],
    countryId: json["country_id"] == null ? null : json["country_id"],
    stateId: json["state_id"] == null ? null : json["state_id"],
    cityId: json["city_id"] == null ? null : json["city_id"],
    countryName: json["country_name"] == null ? null : json["country_name"],
    stateName: json["state_name"] == null ? null : json["state_name"],
    cityName: json["city_name"] == null ? null : json["city_name"],
    postalCode: json["postal_code"],
    phone: json["phone"] == null ? null : json["phone"],
    setDefault: json["set_default"] == null ? null : json["set_default"],
    locationAvailable: json["location_available"] == null ? null : json["location_available"],
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lang: json["lang"] == null ? null : json["lang"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "apartment": apartment == null ? null : apartment,
    "floor_no": floorNo == null ? null : floorNo,
    "user_id": userId == null ? null : userId,
    "address": address == null ? null : address,
    "country_id": countryId == null ? null : countryId,
    "state_id": stateId == null ? null : stateId,
    "city_id": cityId == null ? null : cityId,
    "country_name": countryName == null ? null : countryName,
    "state_name": stateName == null ? null : stateName,
    "city_name": cityName == null ? null : cityName,
    "postal_code": postalCode,
    "phone": phone == null ? null : phone,
    "set_default": setDefault == null ? null : setDefault,
    "location_available": locationAvailable == null ? null : locationAvailable,
    "lat": lat == null ? null : lat,
    "lang": lang == null ? null : lang,
  };
}
