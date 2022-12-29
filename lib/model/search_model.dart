import 'dart:convert';

class SearchModel {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null? nextPageUrl;
  String? path;
  String? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  SearchModel(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  SearchModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }

}

class Data {
  int? id;
  String? name;
  String? slug;
  String? description;
  int? typeId;
  int? price;
  int? shopId;
  int? salePrice;
  String? sku;
  int? quantity;
  int? inStock;
  int? isTaxable;
  Null? shippingClassId;
  String? status;
  String? productType;
  String? purchasePrice;
  String? unit;
  Null? height;
  Null? width;
  Null? length;
  Image? image;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  Null? maxPrice;
  Null? minPrice;
  String? deadline;
  int? targetSale;
  String? delivryDate;
  Type? type;
  Shop? shop;
  List<Categories>? categories;
  List<Null>? tags;
  List<Null>? variations;

  Data(
      {this.id,
        this.name,
        this.slug,
        this.description,
        this.typeId,
        this.price,
        this.shopId,
        this.salePrice,
        this.sku,
        this.quantity,
        this.inStock,
        this.isTaxable,
        this.shippingClassId,
        this.status,
        this.productType,
        this.purchasePrice,
        this.unit,
        this.height,
        this.width,
        this.length,
        this.image,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.maxPrice,
        this.minPrice,
        this.deadline,
        this.targetSale,
        this.delivryDate,
        this.type,
        this.shop,
        this.categories,
        this.tags,
        this.variations});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    typeId = json['type_id'];
    price = json['price'];
    shopId = json['shop_id'];
    salePrice = json['sale_price'];
    sku = json['sku'];
    quantity = json['quantity'];
    inStock = json['in_stock'];
    isTaxable = json['is_taxable'];
    shippingClassId = json['shipping_class_id'];
    status = json['status'];
    productType = json['product_type'];
    purchasePrice = json['purchase_price'];
    unit = json['unit'];
    height = json['height'];
    width = json['width'];
    length = json['length'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;

    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    maxPrice = json['max_price'];
    minPrice = json['min_price'];
    deadline = json['deadline'];
    targetSale = json['target_sale'];
    delivryDate = json['delivry_date'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['type_id'] = this.typeId;
    data['price'] = this.price;
    data['shop_id'] = this.shopId;
    data['sale_price'] = this.salePrice;
    data['sku'] = this.sku;
    data['quantity'] = this.quantity;
    data['in_stock'] = this.inStock;
    data['is_taxable'] = this.isTaxable;
    data['shipping_class_id'] = this.shippingClassId;
    data['status'] = this.status;
    data['product_type'] = this.productType;
    data['purchase_price'] = this.purchasePrice;
    data['unit'] = this.unit;
    data['height'] = this.height;
    data['width'] = this.width;
    data['length'] = this.length;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }

    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['max_price'] = this.maxPrice;
    data['min_price'] = this.minPrice;
    data['deadline'] = this.deadline;
    data['target_sale'] = this.targetSale;
    data['delivry_date'] = this.delivryDate;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Image {
  String? thumbnail;
  String? original;
  int? id;

  Image({this.thumbnail, this.original, this.id});

  Image.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    original = json['original'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    data['original'] = this.original;
    data['id'] = this.id;
    return data;
  }
}

class Type {
  int? id;
  String? name;
  String? slug;
  String? icon;
  Null? gallery;
  String? createdAt;
  String? updatedAt;

  Type(
      {this.id,
        this.name,
        this.slug,
        this.icon,
        this.gallery,
        this.createdAt,
        this.updatedAt});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    gallery = json['gallery'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['icon'] = this.icon;
    data['gallery'] = this.gallery;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Shop {
  int? id;
  int? ownerId;
  String? name;
  String? slug;
  String? description;
  Image? coverImage;
  Image? logo;
  int? isActive;
  Address? address;
  Settings? settings;
  String? createdAt;
  String? updatedAt;

  Shop(
      {this.id,
        this.ownerId,
        this.name,
        this.slug,
        this.description,
        this.coverImage,
        this.logo,
        this.isActive,
        this.address,
        this.settings,
        this.createdAt,
        this.updatedAt});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['owner_id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    coverImage = json['cover_image'] != null
        ? new Image.fromJson(json['cover_image'])
        : null;
    logo = json['logo'] != null ? new Image.fromJson(json['logo']) : null;
    isActive = json['is_active'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner_id'] = this.ownerId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    if (this.coverImage != null) {
      data['cover_image'] = this.coverImage!.toJson();
    }
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['is_active'] = this.isActive;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Address {
  String? country;
  String? city;
  String? state;
  String? zip;
  String? streetAddress;

  Address({this.country, this.city, this.state, this.zip, this.streetAddress});

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    streetAddress = json['street_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['street_address'] = this.streetAddress;
    return data;
  }
}

class Settings {
  String? contact;
  String? website;
  List<Null>? location;
  List<Null>? socials;

  Settings({this.contact, this.website, this.location, this.socials});

  Settings.fromJson(Map<String, dynamic> json) {
    contact = json['contact'];
    website = json['website'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact'] = this.contact;
    data['website'] = this.website;

    return data;
  }
}

class Categories {
  int? id;
  int? menuId;
  String? name;
  String? slug;
  String? icon;
  Image? image;
  String? imageIcon;
  String? details;
  int? parent;
  int? typeId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Pivot? pivot;

  Categories(
      {this.id,
        this.menuId,
        this.name,
        this.slug,
        this.icon,
        this.image,
        this.imageIcon,
        this.details,
        this.parent,
        this.typeId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.pivot});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    // image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    imageIcon = json['image_icon'];
    details = json['details'];
    parent = json['parent'];
    typeId = json['type_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['icon'] = this.icon;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['image_icon'] = this.imageIcon;
    data['details'] = this.details;
    data['parent'] = this.parent;
    data['type_id'] = this.typeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? productId;
  int? categoryId;

  Pivot({this.productId, this.categoryId});

  Pivot.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
