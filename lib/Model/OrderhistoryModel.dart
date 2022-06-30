/// status : "Success"
/// message : "Orders fetch successfully"
/// data : [{"cart_id":81,"user_id":2379,"product_id":3,"product_name":"Grey Bricks","product_image":"62ac16dbe30e5.jpeg","quantity":20,"selling_price":5,"mrp_price":5,"total_price":100,"status":"ordered","order_id":"1aedb4e0f1b98093e","added_date":"2022-06-24 07:07:13","id":5,"transaction_id":"pay_JlFA5yS9NhcFQp","amount":100,"email":"akabhinavv@gmail.com"},{"cart_id":82,"user_id":2379,"product_id":3,"product_name":"Grey Bricks","product_image":"62ac16dbe30e5.jpeg","quantity":20,"selling_price":5,"mrp_price":5,"total_price":100,"status":"ordered","order_id":"4ad6897c5b464147e","added_date":"2022-06-24 07:09:00","id":6,"transaction_id":"pay_JlFBya9eVvNowN","amount":100,"email":"akabhinavv@gmail.com"}]

class OrderhistoryModel {
  OrderhistoryModel({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  OrderhistoryModel.fromJson(dynamic json) {
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

/// cart_id : 81
/// user_id : 2379
/// product_id : 3
/// product_name : "Grey Bricks"
/// product_image : "62ac16dbe30e5.jpeg"
/// quantity : 20
/// selling_price : 5
/// mrp_price : 5
/// total_price : 100
/// status : "ordered"
/// order_id : "1aedb4e0f1b98093e"
/// added_date : "2022-06-24 07:07:13"
/// id : 5
/// transaction_id : "pay_JlFA5yS9NhcFQp"
/// amount : 100
/// email : "akabhinavv@gmail.com"

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
      String? status, 
      String? orderId, 
      String? addedDate, 
      int? id, 
      String? transactionId, 
      int? amount, 
      String? email,}){
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
    _id = id;
    _transactionId = transactionId;
    _amount = amount;
    _email = email;
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
    _id = json['id'];
    _transactionId = json['transaction_id'];
    _amount = json['amount'];
    _email = json['email'];
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
  String? _status;
  String? _orderId;
  String? _addedDate;
  int? _id;
  String? _transactionId;
  int? _amount;
  String? _email;

  int? get cartId => _cartId;
  int? get userId => _userId;
  int? get productId => _productId;
  String? get productName => _productName;
  String? get productImage => _productImage;
  int? get quantity => _quantity;
  int? get sellingPrice => _sellingPrice;
  int? get mrpPrice => _mrpPrice;
  int? get totalPrice => _totalPrice;
  String? get status => _status;
  String? get orderId => _orderId;
  String? get addedDate => _addedDate;
  int? get id => _id;
  String? get transactionId => _transactionId;
  int? get amount => _amount;
  String? get email => _email;

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
    map['id'] = _id;
    map['transaction_id'] = _transactionId;
    map['amount'] = _amount;
    map['email'] = _email;
    return map;
  }

}