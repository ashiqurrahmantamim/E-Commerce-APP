// To parse this JSON data, do
//
//     final signUpRes = signUpResFromJson(jsonString);

import 'dart:convert';

SignUpRes signUpResFromJson(String str) => SignUpRes.fromJson(json.decode(str));

String signUpResToJson(SignUpRes data) => json.encode(data.toJson());

class SignUpRes {
  SignUpRes({
    this.token,
    this.permissions,
    this.customerStatus,
    this.customer,
  });

  String ? token;
  List<String> ? permissions;
  String  ?customerStatus;
  Customer ? customer;

  factory SignUpRes.fromJson(Map<String, dynamic> json) => SignUpRes(
    token: json["token"] == null ? null : json["token"],
    permissions: json["permissions"] == null ? null : List<String>.from(json["permissions"].map((x) => x)),
    customerStatus: json["customer_status"] == null ? null : json["customer_status"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token == null ? null : token,
    "permissions": permissions == null ? null : List<dynamic>.from(permissions!.map((x) => x)),
    "customer_status": customerStatus == null ? null : customerStatus,
    "customer": customer == null ? null : customer!.toJson(),
  };
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.shopId,
    this.staffId,
    this.feedback,
    this.userCategoryId,
    this.bin,
    this.permissions,
  });

  int ? id;
  String ? name;
  String ? phone;
  String ? email;
  dynamic emailVerifiedAt;
  DateTime ? createdAt;
  DateTime ? updatedAt;
  int  ?isActive;
  dynamic shopId;
  dynamic staffId;
  dynamic feedback;
  String  ?userCategoryId;
  dynamic bin;
  List<Permission> ? permissions;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    phone: json["phone"] == null ? null : json["phone"],
    email: json["email"] == null ? null : json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    isActive: json["is_active"] == null ? null : json["is_active"],
    shopId: json["shop_id"],
    staffId: json["staff_id"],
    feedback: json["feedback"],
    userCategoryId: json["user_category_id"] == null ? null : json["user_category_id"],
    bin: json["bin"],
    permissions: json["permissions"] == null ? null : List<Permission>.from(json["permissions"].map((x) => Permission.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "phone": phone == null ? null : phone,
    "email": email == null ? null : email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "is_active": isActive == null ? null : isActive,
    "shop_id": shopId,
    "staff_id": staffId,
    "feedback": feedback,
    "user_category_id": userCategoryId == null ? null : userCategoryId,
    "bin": bin,
    "permissions": permissions == null ? null : List<dynamic>.from(permissions!.map((x) => x.toJson())),
  };
}

class Permission {
  Permission({
    this.id,
    this.name,
    this.guardName,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  int ? id;
  String ? name;
  String  ?guardName;
  DateTime ?createdAt;
  DateTime ? updatedAt;
  Pivot ? pivot;

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    guardName: json["guard_name"] == null ? null : json["guard_name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "guard_name": guardName == null ? null : guardName,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "pivot": pivot == null ? null : pivot!.toJson(),
  };
}

class Pivot {
  Pivot({
    this.modelId,
    this.permissionId,
    this.modelType,
  });

  int ? modelId;
  int ? permissionId;
  String ? modelType;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    modelId: json["model_id"] == null ? null : json["model_id"],
    permissionId: json["permission_id"] == null ? null : json["permission_id"],
    modelType: json["model_type"] == null ? null : json["model_type"],
  );

  Map<String, dynamic> toJson() => {
    "model_id": modelId == null ? null : modelId,
    "permission_id": permissionId == null ? null : permissionId,
    "model_type": modelType == null ? null : modelType,
  };
}
