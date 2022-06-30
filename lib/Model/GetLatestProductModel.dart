/// status : "Success"
/// message : "Orders fetch successfully"
/// data : [{"product_id":9,"location_id":1,"sub_category_id":1,"category_id":1,"name":"Red Bricks","selling_price":4,"mrp_price":4,"order_limit":1000,"packing_quantity":1,"description":"the product","stock":500,"taxes":2,"brand":"","image":"images.jpg","status":0,"min_order_limit":12,"product_by":"kapil enterprise","size":"12","colour":"12","material":"12","added_date":"2022-06-23 09:37:35"},{"product_id":8,"location_id":1,"sub_category_id":2,"category_id":1,"name":"Kapil","selling_price":5,"mrp_price":50,"order_limit":1000,"packing_quantity":1,"description":"dnf","stock":600,"taxes":12,"brand":"","image":"images.jpg","status":3,"min_order_limit":5,"product_by":"kapil","size":"12mm","colour":"red","material":"gold","added_date":"2022-06-23 06:30:15"},{"product_id":7,"location_id":1,"sub_category_id":2,"category_id":1,"name":"Grey Bricks","selling_price":5,"mrp_price":5,"order_limit":50,"packing_quantity":1,"description":"Best quality cement grey bricks.","stock":510,"taxes":1,"brand":"Kapil","image":"62ac16dbe30e5.jpeg","status":1,"min_order_limit":20,"product_by":"","size":"150*150 mm","colour":"Grey","material":"cement","added_date":"2022-06-17 05:53:31"},{"product_id":6,"location_id":1,"sub_category_id":1,"category_id":1,"name":"Red Bricks","selling_price":4,"mrp_price":4,"order_limit":1000,"packing_quantity":1,"description":"the ","stock":520,"taxes":2,"brand":"","image":"images.jpg","status":1,"min_order_limit":12,"product_by":"kapil enterprise","size":"12","colour":"12","material":"12","added_date":"2022-06-24 05:03:46"},{"product_id":5,"location_id":1,"sub_category_id":1,"category_id":1,"name":"Red Bricks","selling_price":4,"mrp_price":4,"order_limit":1000,"packing_quantity":1,"description":"the product","stock":500,"taxes":2,"brand":"","image":"images.jpg","status":0,"min_order_limit":12,"product_by":"kapil enterprise","size":"12","colour":"12","material":"12","added_date":"2022-06-23 09:37:35"}]

class GetLatestProductModel {
  GetLatestProductModel({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetLatestProductModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<Data>? _data;

  String? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// product_id : 9
/// location_id : 1
/// sub_category_id : 1
/// category_id : 1
/// name : "Red Bricks"
/// selling_price : 4
/// mrp_price : 4
/// order_limit : 1000
/// packing_quantity : 1
/// description : "the product"
/// stock : 500
/// taxes : 2
/// brand : ""
/// image : "images.jpg"
/// status : 0
/// min_order_limit : 12
/// product_by : "kapil enterprise"
/// size : "12"
/// colour : "12"
/// material : "12"
/// added_date : "2022-06-23 09:37:35"

class Data {
  Data({
      int? productId, 
      int? locationId, 
      int? subCategoryId, 
      int? categoryId, 
      String? name, 
      int? sellingPrice, 
      int? mrpPrice, 
      int? orderLimit, 
      int? packingQuantity, 
      String? description, 
      int? stock, 
      int? taxes, 
      String? brand, 
      String? image, 
      int? status, 
      int? minOrderLimit, 
      String? productBy, 
      String? size, 
      String? colour, 
      String? material, 
      String? addedDate,}){
    _productId = productId;
    _locationId = locationId;
    _subCategoryId = subCategoryId;
    _categoryId = categoryId;
    _name = name;
    _sellingPrice = sellingPrice;
    _mrpPrice = mrpPrice;
    _orderLimit = orderLimit;
    _packingQuantity = packingQuantity;
    _description = description;
    _stock = stock;
    _taxes = taxes;
    _brand = brand;
    _image = image;
    _status = status;
    _minOrderLimit = minOrderLimit;
    _productBy = productBy;
    _size = size;
    _colour = colour;
    _material = material;
    _addedDate = addedDate;
}

  Data.fromJson(dynamic json) {
    _productId = json['product_id'];
    _locationId = json['location_id'];
    _subCategoryId = json['sub_category_id'];
    _categoryId = json['category_id'];
    _name = json['name'];
    _sellingPrice = json['selling_price'];
    _mrpPrice = json['mrp_price'];
    _orderLimit = json['order_limit'];
    _packingQuantity = json['packing_quantity'];
    _description = json['description'];
    _stock = json['stock'];
    _taxes = json['taxes'];
    _brand = json['brand'];
    _image = json['image'];
    _status = json['status'];
    _minOrderLimit = json['min_order_limit'];
    _productBy = json['product_by'];
    _size = json['size'];
    _colour = json['colour'];
    _material = json['material'];
    _addedDate = json['added_date'];
  }
  int? _productId;
  int? _locationId;
  int? _subCategoryId;
  int? _categoryId;
  String? _name;
  int? _sellingPrice;
  int? _mrpPrice;
  int? _orderLimit;
  int? _packingQuantity;
  String? _description;
  int? _stock;
  int? _taxes;
  String? _brand;
  String? _image;
  int? _status;
  int? _minOrderLimit;
  String? _productBy;
  String? _size;
  String? _colour;
  String? _material;
  String? _addedDate;

  int? get productId => _productId;
  int? get locationId => _locationId;
  int? get subCategoryId => _subCategoryId;
  int? get categoryId => _categoryId;
  String? get name => _name;
  int? get sellingPrice => _sellingPrice;
  int? get mrpPrice => _mrpPrice;
  int? get orderLimit => _orderLimit;
  int? get packingQuantity => _packingQuantity;
  String? get description => _description;
  int? get stock => _stock;
  int? get taxes => _taxes;
  String? get brand => _brand;
  String? get image => _image;
  int? get status => _status;
  int? get minOrderLimit => _minOrderLimit;
  String? get productBy => _productBy;
  String? get size => _size;
  String? get colour => _colour;
  String? get material => _material;
  String? get addedDate => _addedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['location_id'] = _locationId;
    map['sub_category_id'] = _subCategoryId;
    map['category_id'] = _categoryId;
    map['name'] = _name;
    map['selling_price'] = _sellingPrice;
    map['mrp_price'] = _mrpPrice;
    map['order_limit'] = _orderLimit;
    map['packing_quantity'] = _packingQuantity;
    map['description'] = _description;
    map['stock'] = _stock;
    map['taxes'] = _taxes;
    map['brand'] = _brand;
    map['image'] = _image;
    map['status'] = _status;
    map['min_order_limit'] = _minOrderLimit;
    map['product_by'] = _productBy;
    map['size'] = _size;
    map['colour'] = _colour;
    map['material'] = _material;
    map['added_date'] = _addedDate;
    return map;
  }

}