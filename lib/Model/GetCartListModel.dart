/// status : "Success"
/// message : "Added successfully"
/// total_cart : "248"
/// data : [{"cart_id":64,"user_id":2379,"product_id":2,"product_name":"Red Bricks","product_image":"62ab03f1449c3.jpeg","quantity":27,"selling_price":4,"mrp_price":4,"total_price":108,"status":0,"order_id":"0","added_date":"2022-06-22 09:14:03"},{"cart_id":66,"user_id":2379,"product_id":3,"product_name":"Grey Bricks","product_image":"62ac16dbe30e5.jpeg","quantity":28,"selling_price":5,"mrp_price":5,"total_price":140,"status":0,"order_id":"0","added_date":"2022-06-22 11:33:36"}]

class GetCartListModel {
  GetCartListModel({
      String? status, 
      String? message, 
      String? totalCart, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _totalCart = totalCart;
    _data = data;
}

  GetCartListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _totalCart = json['total_cart'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  String? _totalCart;
  List<Data>? _data;

  String? get status => _status;
  String? get message => _message;
  String? get totalCart => _totalCart;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['total_cart'] = _totalCart;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// cart_id : 64
/// user_id : 2379
/// product_id : 2
/// product_name : "Red Bricks"
/// product_image : "62ab03f1449c3.jpeg"
/// quantity : 27
/// selling_price : 4
/// mrp_price : 4
/// total_price : 108
/// status : 0
/// order_id : "0"
/// added_date : "2022-06-22 09:14:03"

class Data {
  Data({
      int? cartId, 
      int? userId, 
      int? productId, 
      String? productName, 
      String? productImage, 
      int? quantity, 
      int? sellingPrice, 
      int? mrpPrice, 
      int? totalPrice, 
      int? status, 
      String? orderId, 
      String? addedDate,}){
    _cartId = cartId;
    _userId = userId;
    _productId = productId;
    _productName = productName;
    _productImage = productImage;
    _quantity = quantity;
    _sellingPrice = sellingPrice;
    _mrpPrice = mrpPrice;
    _totalPrice = totalPrice;
    _status = status;
    _orderId = orderId;
    _addedDate = addedDate;
}

  Data.fromJson(dynamic json) {
    _cartId = json['cart_id'];
    _userId = json['user_id'];
    _productId = json['product_id'];
    _productName = json['product_name'];
    _productImage = json['product_image'];
    _quantity = json['quantity'];
    _sellingPrice = json['selling_price'];
    _mrpPrice = json['mrp_price'];
    _totalPrice = json['total_price'];
    _status = json['status'];
    _orderId = json['order_id'];
    _addedDate = json['added_date'];
  }
  int? _cartId;
  int? _userId;
  int? _productId;
  String? _productName;
  String? _productImage;
  int? _quantity;
  int? _sellingPrice;
  int? _mrpPrice;
  int? _totalPrice;
  int? _status;
  String? _orderId;
  String? _addedDate;

  int? get cartId => _cartId;
  int? get userId => _userId;
  int? get productId => _productId;
  String? get productName => _productName;
  String? get productImage => _productImage;
  int? get quantity => _quantity;
  int? get sellingPrice => _sellingPrice;
  int? get mrpPrice => _mrpPrice;
  int? get totalPrice => _totalPrice;
  int? get status => _status;
  String? get orderId => _orderId;
  String? get addedDate => _addedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cart_id'] = _cartId;
    map['user_id'] = _userId;
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    map['product_image'] = _productImage;
    map['quantity'] = _quantity;
    map['selling_price'] = _sellingPrice;
    map['mrp_price'] = _mrpPrice;
    map['total_price'] = _totalPrice;
    map['status'] = _status;
    map['order_id'] = _orderId;
    map['added_date'] = _addedDate;
    return map;
  }

}