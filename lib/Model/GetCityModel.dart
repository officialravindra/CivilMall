/// code : 200
/// status : true
/// data : [{"id":0,"name":"Select City","status":"0","created_at":"2021-04-08 11:14:58","updated_at":"2021-04-08 11:14:58"},{"id":1,"name":"Jaipur","status":"1","created_at":"2021-03-04 02:16:26","updated_at":"2021-03-04 02:16:26"},{"id":2,"name":"Jodhpur","status":"1","created_at":"2021-03-04 02:16:39","updated_at":"2021-03-04 02:16:39"},{"id":4,"name":"Udaipur","status":"1","created_at":"2021-04-08 11:14:58","updated_at":"2021-04-08 11:14:58"},{"id":6,"name":"alwar","status":"1","created_at":"2021-04-09 07:31:29","updated_at":"2021-04-09 07:31:29"},{"id":13,"name":"Ajmer","status":"1","created_at":"2021-04-29 09:54:48","updated_at":"2021-04-29 09:54:48"},{"id":39,"name":"Kota","status":"1","created_at":"2021-10-05 12:50:45","updated_at":"2021-10-05 12:50:45"},{"id":40,"name":"Bikaner","status":"1","created_at":"2022-01-10 12:14:30","updated_at":"2022-01-10 12:14:30"},{"id":41,"name":"Pali","status":"1","created_at":"2022-02-07 11:03:19","updated_at":"2022-02-07 11:03:19"},{"id":42,"name":"Chandigarh","status":"1","created_at":"2022-03-12 12:01:14","updated_at":"2022-03-12 12:01:14"}]
/// message : "City fetch successfully"

class GetCityModel {
  GetCityModel({
      int? code, 
      bool? status, 
      List<Data>? data, 
      String? message,}){
    _code = code;
    _status = status;
    _data = data;
    _message = message;
}

  GetCityModel.fromJson(dynamic json) {
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

/// id : 0
/// name : "Select City"
/// status : "0"
/// created_at : "2021-04-08 11:14:58"
/// updated_at : "2021-04-08 11:14:58"

class Data {
  Data({
      int? id, 
      String? name, 
      String? status, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _name;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}