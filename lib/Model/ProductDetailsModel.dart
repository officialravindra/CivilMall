/// code : 200
/// status : true
/// data : [{"id":74,"name":"Blocks","price":0,"stock":"NA","unit":"NA","category":"","status":1,"product_image":"1633509870.jpg","product_banner":"4888_1633509870.jpg","description":"<p>Blocks</p>","meta_title":"Blocks","meta_description":"Blocks","meta_keywords":"","location_id":0,"product_slug":"blocks","created_at":"2021-02-03 06:02:48","updated_at":"2021-10-06 08:44:30"}]
/// message : "Product data fetch successfully"

class ProductDetailsModel {
  ProductDetailsModel({
      int? code, 
      bool? status, 
      List<Data>? data, 
      String? message,}){
    _code = code;
    _status = status;
    _data = data;
    _message = message;
}

  ProductDetailsModel.fromJson(dynamic json) {
    _code = json['code'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _message = json['message'];
  }
  int? _code;
  bool? _status;
  List<Data>? _data;
  String? _message;

  int? get code => _code;
  bool? get status => _status;
  List<Data>? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }

}

/// id : 74
/// name : "Blocks"
/// price : 0
/// stock : "NA"
/// unit : "NA"
/// category : ""
/// status : 1
/// product_image : "1633509870.jpg"
/// product_banner : "4888_1633509870.jpg"
/// description : "<p>Blocks</p>"
/// meta_title : "Blocks"
/// meta_description : "Blocks"
/// meta_keywords : ""
/// location_id : 0
/// product_slug : "blocks"
/// created_at : "2021-02-03 06:02:48"
/// updated_at : "2021-10-06 08:44:30"

class Data {
  Data({
      int? id, 
      String? name, 
      int? price, 
      String? stock, 
      String? unit, 
      String? category, 
      int? status, 
      String? productImage, 
      String? productBanner, 
      String? description, 
      String? metaTitle, 
      String? metaDescription, 
      String? metaKeywords, 
      int? locationId, 
      String? productSlug, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _price = price;
    _stock = stock;
    _unit = unit;
    _category = category;
    _status = status;
    _productImage = productImage;
    _productBanner = productBanner;
    _description = description;
    _metaTitle = metaTitle;
    _metaDescription = metaDescription;
    _metaKeywords = metaKeywords;
    _locationId = locationId;
    _productSlug = productSlug;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _price = json['price'];
    _stock = json['stock'];
    _unit = json['unit'];
    _category = json['category'];
    _status = json['status'];
    _productImage = json['product_image'];
    _productBanner = json['product_banner'];
    _description = json['description'];
    _metaTitle = json['meta_title'];
    _metaDescription = json['meta_description'];
    _metaKeywords = json['meta_keywords'];
    _locationId = json['location_id'];
    _productSlug = json['product_slug'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  int? _price;
  String? _stock;
  String? _unit;
  String? _category;
  int? _status;
  String? _productImage;
  String? _productBanner;
  String? _description;
  String? _metaTitle;
  String? _metaDescription;
  String? _metaKeywords;
  int? _locationId;
  String? _productSlug;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  int? get price => _price;
  String? get stock => _stock;
  String? get unit => _unit;
  String? get category => _category;
  int? get status => _status;
  String? get productImage => _productImage;
  String? get productBanner => _productBanner;
  String? get description => _description;
  String? get metaTitle => _metaTitle;
  String? get metaDescription => _metaDescription;
  String? get metaKeywords => _metaKeywords;
  int? get locationId => _locationId;
  String? get productSlug => _productSlug;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    map['stock'] = _stock;
    map['unit'] = _unit;
    map['category'] = _category;
    map['status'] = _status;
    map['product_image'] = _productImage;
    map['product_banner'] = _productBanner;
    map['description'] = _description;
    map['meta_title'] = _metaTitle;
    map['meta_description'] = _metaDescription;
    map['meta_keywords'] = _metaKeywords;
    map['location_id'] = _locationId;
    map['product_slug'] = _productSlug;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}