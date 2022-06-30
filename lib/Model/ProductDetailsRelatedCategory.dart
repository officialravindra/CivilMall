/// status : "Success"
/// message : "fetch successfully"
/// data : {"product_id":2,"location_id":1,"sub_category_id":2,"category_id":1,"sub_category_name":"normal brick","category_name":"Bricks","name":"Red Bricks","selling_price":4,"mrp_price":4,"order_limit":10,"packing_quantity":1,"description":"the product","stock":500,"taxes":0,"brand":"Keshav Entreprise","image":"62ab03f1449c3.jpeg","status":1,"min_order_limit":12,"product_by":"kapil enterprise","size":"12","colour":"12","material":"12","added_date":"2022-06-16 10:20:33","stock_status":"Stock Available","is_added":"1"}

class ProductDetailsRelatedCategory {
  ProductDetailsRelatedCategory({
      String? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ProductDetailsRelatedCategory.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  String? _message;
  Data? _data;

  String? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// product_id : 2
/// location_id : 1
/// sub_category_id : 2
/// category_id : 1
/// sub_category_name : "normal brick"
/// category_name : "Bricks"
/// name : "Red Bricks"
/// selling_price : 4
/// mrp_price : 4
/// order_limit : 10
/// packing_quantity : 1
/// description : "the product"
/// stock : 500
/// taxes : 0
/// brand : "Keshav Entreprise"
/// image : "62ab03f1449c3.jpeg"
/// status : 1
/// min_order_limit : 12
/// product_by : "kapil enterprise"
/// size : "12"
/// colour : "12"
/// material : "12"
/// added_date : "2022-06-16 10:20:33"
/// stock_status : "Stock Available"
/// is_added : "1"

class Data {
  Data({
      int? productId, 
      int? locationId, 
      int? subCategoryId, 
      int? categoryId, 
      String? subCategoryName, 
      String? categoryName, 
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
      String? addedDate, 
      String? stockStatus, 
      String? isAdded,}){
    _productId = productId;
    _locationId = locationId;
    _subCategoryId = subCategoryId;
    _categoryId = categoryId;
    _subCategoryName = subCategoryName;
    _categoryName = categoryName;
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
    _stockStatus = stockStatus;
    _isAdded = isAdded;
}

  Data.fromJson(dynamic json) {
    _productId = json['product_id'];
    _locationId = json['location_id'];
    _subCategoryId = json['sub_category_id'];
    _categoryId = json['category_id'];
    _subCategoryName = json['sub_category_name'];
    _categoryName = json['category_name'];
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
    _stockStatus = json['stock_status'];
    _isAdded = json['is_added'];
  }
  int? _productId;
  int? _locationId;
  int? _subCategoryId;
  int? _categoryId;
  String? _subCategoryName;
  String? _categoryName;
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
  String? _stockStatus;
  String? _isAdded;

  int? get productId => _productId;
  int? get locationId => _locationId;
  int? get subCategoryId => _subCategoryId;
  int? get categoryId => _categoryId;
  String? get subCategoryName => _subCategoryName;
  String? get categoryName => _categoryName;
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
  String? get stockStatus => _stockStatus;
  String? get isAdded => _isAdded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['location_id'] = _locationId;
    map['sub_category_id'] = _subCategoryId;
    map['category_id'] = _categoryId;
    map['sub_category_name'] = _subCategoryName;
    map['category_name'] = _categoryName;
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
    map['stock_status'] = _stockStatus;
    map['is_added'] = _isAdded;
    return map;
  }

}