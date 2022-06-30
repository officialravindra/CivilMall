/// status : "Success"
/// message : "fetch successfully"
/// data : {"quantity":"15","total_price":60}

class GetCartIncrementPrice {
  GetCartIncrementPriceModel({
      String? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetCartIncrementPrice.fromJson(dynamic json) {
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

/// quantity : "15"
/// total_price : 60

class Data {
  Data({
      String? quantity, 
      int? totalPrice,}){
    _quantity = quantity;
    _totalPrice = totalPrice;
}

  Data.fromJson(dynamic json) {
    _quantity = json['quantity'];
    _totalPrice = json['total_price'];
  }
  String? _quantity;
  int? _totalPrice;

  String? get quantity => _quantity;
  int? get totalPrice => _totalPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = _quantity;
    map['total_price'] = _totalPrice;
    return map;
  }

}