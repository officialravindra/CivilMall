/// code : 200
/// status : true
/// data : [{"userimage":"622c739dd1eb5.jpeg","name":"Tarun Kumar","mobile":"9783996666","id":178,"user_id":34,"vendor_id":34,"post_id":511,"estimate_time":"2 months","bid_amount":"200000","description":"good quality","bid":1,"created_at":"2021-12-31 16:55:37"},{"userimage":"622c739dd1eb5.jpeg","name":"Tarun Kumar","mobile":"9783996666","id":179,"user_id":34,"vendor_id":34,"post_id":511,"estimate_time":"2 months ","bid_amount":"200000","description":"best","bid":1,"created_at":"2021-12-31 16:56:48"},{"userimage":"615c38683a7bf.jpeg","name":"Jagdish","mobile":"9983830066","id":183,"user_id":34,"vendor_id":107,"post_id":511,"estimate_time":"4 months","bid_amount":"70000","description":"best","bid":1,"created_at":"2021-12-31 17:26:57"}]
/// message : ""

class InterestedVendorsModel {
  InterestedVendorsModel({
      int? code, 
      bool? status, 
      List<Data>? data, 
      String? message,}){
    _code = code;
    _status = status;
    _data = data;
    _message = message;
}

  InterestedVendorsModel.fromJson(dynamic json) {
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

/// userimage : "622c739dd1eb5.jpeg"
/// name : "Tarun Kumar"
/// mobile : "9783996666"
/// id : 178
/// user_id : 34
/// vendor_id : 34
/// post_id : 511
/// estimate_time : "2 months"
/// bid_amount : "200000"
/// description : "good quality"
/// bid : 1
/// created_at : "2021-12-31 16:55:37"

class Data {
  Data({
      String? userimage, 
      String? name, 
      String? mobile, 
      int? id, 
      int? userId, 
      int? vendorId, 
      int? postId, 
      String? estimateTime, 
      String? bidAmount, 
      String? description, 
      int? bid, 
      String? createdAt,}){
    _userimage = userimage;
    _name = name;
    _mobile = mobile;
    _id = id;
    _userId = userId;
    _vendorId = vendorId;
    _postId = postId;
    _estimateTime = estimateTime;
    _bidAmount = bidAmount;
    _description = description;
    _bid = bid;
    _createdAt = createdAt;
}

  Data.fromJson(dynamic json) {
    _userimage = json['userimage'];
    _name = json['name'];
    _mobile = json['mobile'];
    _id = json['id'];
    _userId = json['user_id'];
    _vendorId = json['vendor_id'];
    _postId = json['post_id'];
    _estimateTime = json['estimate_time'];
    _bidAmount = json['bid_amount'];
    _description = json['description'];
    _bid = json['bid'];
    _createdAt = json['created_at'];
  }
  String? _userimage;
  String? _name;
  String? _mobile;
  int? _id;
  int? _userId;
  int? _vendorId;
  int? _postId;
  String? _estimateTime;
  String? _bidAmount;
  String? _description;
  int? _bid;
  String? _createdAt;

  String? get userimage => _userimage;
  String? get name => _name;
  String? get mobile => _mobile;
  int? get id => _id;
  int? get userId => _userId;
  int? get vendorId => _vendorId;
  int? get postId => _postId;
  String? get estimateTime => _estimateTime;
  String? get bidAmount => _bidAmount;
  String? get description => _description;
  int? get bid => _bid;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userimage'] = _userimage;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['id'] = _id;
    map['user_id'] = _userId;
    map['vendor_id'] = _vendorId;
    map['post_id'] = _postId;
    map['estimate_time'] = _estimateTime;
    map['bid_amount'] = _bidAmount;
    map['description'] = _description;
    map['bid'] = _bid;
    map['created_at'] = _createdAt;
    return map;
  }

}