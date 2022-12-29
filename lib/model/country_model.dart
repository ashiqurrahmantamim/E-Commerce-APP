// To parse this JSON data, do
//
//     final countryResponse = countryResponseFromJson(jsonString);

import 'dart:convert';

CountryResponse countryResponseFromJson(String str) => CountryResponse.fromJson(json.decode(str));

String countryResponseToJson(CountryResponse data) => json.encode(data.toJson());

class CountryResponse {
  CountryResponse({
    this.data,
    this.success,
    this.status,
  });

  List<Country>  ?data;
  bool ? success;
  int ? status;

  factory CountryResponse.fromJson(Map<String, dynamic> json) => CountryResponse(
    data: List<Country>.from(json["data"].map((x) => Country.fromJson(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

class Country {
  Country({
    this.id,
    this.countryId,
    this.name,
  });

  int  ?id;
  int  ?countryId;
  String ? name;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    countryId: json["country_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "country_id": countryId,
    "name": name,
  };
}
