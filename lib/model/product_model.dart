// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.data,
    this.links,
    this.meta,
    this.success,
    this.status,
  });

  List<Datum> ? data;
  ProductModelLinks ? links;
  Meta ? meta;
  bool ? success;
  int ? status;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: json["links"] == null ? null : ProductModelLinks.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    success: json["success"] == null ? null : json["success"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links == null ? null : links!.toJson(),
    "meta": meta == null ? null : meta!.toJson(),
    "success": success == null ? null : success,
    "status": status == null ? null : status,
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.thumbnailImage,
    this.bannerImage,
    this.hasDiscount,
    this.strokedPrice,
    this.minQty,
    this.maxQty,
    this.mainPrice,
    this.strokedPriceWu,
    this.mainPriceWu,
    this.rating,
    this.sales,
    this.inCart,
    this.unit,
    this.unitValue,
    this.lowStockQuantity,
    this.quantity,
    this.stock,
    this.description,
    this.links,
  });

  int ? id;
  String ?name;
  String ?thumbnailImage;
  dynamic bannerImage;
  bool? hasDiscount;
  String? strokedPrice;
  int? minQty;
  int? maxQty;
  String? mainPrice;
  int? strokedPriceWu;
  int? mainPriceWu;
  int ?rating;
  int? sales;
  int? inCart;
  Unit? unit;
  int ?unitValue;
  int? lowStockQuantity;
  int? quantity;
  int? stock;
  String? description;
  DatumLinks? links;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    thumbnailImage: json["thumbnail_image"] == null ? null : json["thumbnail_image"],
    bannerImage: json["banner_image"],
    hasDiscount: json["has_discount"] == null ? null : json["has_discount"],
    strokedPrice: json["stroked_price"] == null ? null : json["stroked_price"],
    minQty: json["min_qty"] == null ? null : json["min_qty"],
    maxQty: json["max_qty"] == null ? null : json["max_qty"],
    mainPrice: json["main_price"] == null ? null : json["main_price"],
    strokedPriceWu: json["stroked_price_wu"] == null ? null : json["stroked_price_wu"],
    mainPriceWu: json["main_price_wu"] == null ? null : json["main_price_wu"],
    rating: json["rating"] == null ? null : json["rating"],
    sales: json["sales"] == null ? null : json["sales"],
    inCart: json["in_cart"] == null ? null : json["in_cart"],
    unit: json["unit"] == null ? null : unitValues.map![json["unit"]],
    unitValue: json["unit_value"] == null ? null : json["unit_value"],
    lowStockQuantity: json["low_stock_quantity"] == null ? null : json["low_stock_quantity"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    stock: json["stock"] == null ? null : json["stock"],
    description: json["description"] == null ? null : json["description"],
    links: json["links"] == null ? null : DatumLinks.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "thumbnail_image": thumbnailImage == null ? null : thumbnailImage,
    "banner_image": bannerImage,
    "has_discount": hasDiscount == null ? null : hasDiscount,
    "stroked_price": strokedPrice == null ? null : strokedPrice,
    "min_qty": minQty == null ? null : minQty,
    "max_qty": maxQty == null ? null : maxQty,
    "main_price": mainPrice == null ? null : mainPrice,
    "stroked_price_wu": strokedPriceWu == null ? null : strokedPriceWu,
    "main_price_wu": mainPriceWu == null ? null : mainPriceWu,
    "rating": rating == null ? null : rating,
    "sales": sales == null ? null : sales,
    "in_cart": inCart == null ? null : inCart,
    "unit": unit == null ? null : unitValues.reverse[unit],
    "unit_value": unitValue == null ? null : unitValue,
    "low_stock_quantity": lowStockQuantity == null ? null : lowStockQuantity,
    "quantity": quantity == null ? null : quantity,
    "stock": stock == null ? null : stock,
    "description": description == null ? null : description,
    "links": links == null ? null : links!.toJson(),
  };
}

class DatumLinks {
  DatumLinks({
    this.details,
  });

  String? details;

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
    details: json["details"] == null ? null : json["details"],
  );

  Map<String, dynamic> toJson() => {
    "details": details == null ? null : details,
  };
}

enum Unit { THE_1_BUNDLE, THE_1_KG }

final unitValues = EnumValues({
  "1 bundle": Unit.THE_1_BUNDLE,
  "1 kg": Unit.THE_1_KG
});

class ProductModelLinks {
  ProductModelLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String ? first;
  String? last;
  dynamic? prev;
  String? next;

  factory ProductModelLinks.fromJson(Map<String, dynamic> json) => ProductModelLinks(
    first: json["first"] == null ? null : json["first"],
    last: json["last"] == null ? null : json["last"],
    prev: json["prev"],
    next: json["next"] == null ? null : json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first == null ? null : first,
    "last": last == null ? null : last,
    "prev": prev,
    "next": next == null ? null : next,
  };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int ? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int?total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    from: json["from"] == null ? null : json["from"],
    lastPage: json["last_page"] == null ? null : json["last_page"],
    links: json["links"] == null ? null : List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"] == null ? null : json["path"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    to: json["to"] == null ? null : json["to"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage == null ? null : currentPage,
    "from": from == null ? null : from,
    "last_page": lastPage == null ? null : lastPage,
    "links": links == null ? null : List<dynamic>.from(links!.map((x) => x.toJson())),
    "path": path == null ? null : path,
    "per_page": perPage == null ? null : perPage,
    "to": to == null ? null : to,
    "total": total == null ? null : total,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String ?url;
  String ?label;
  bool ?active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"] == null ? null : json["label"],
    active: json["active"] == null ? null : json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label == null ? null : label,
    "active": active == null ? null : active,
  };
}

class EnumValues<T> {
  Map<String, T> ? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
