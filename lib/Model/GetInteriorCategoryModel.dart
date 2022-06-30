/// status : "Success"
/// message : "fetch successfully"
/// data : [{"id":3,"name":"Hall","status":1,"added_date":"2022-06-19 07:14:20"},{"id":2,"name":"kitchen","status":1,"added_date":"2022-06-18 12:27:27"},{"id":1,"name":"House","status":1,"added_date":"2022-06-18 12:26:45"}]

class GetInteriorCategoryModel {
  GetInteriorCategoryModel({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetInteriorCategoryModel.fromJson(dynamic json) {
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

/// id : 3
/// name : "Hall"
/// status : 1
/// added_date : "2022-06-19 07:14:20"

class Data {
  Data({
      int? id, 
      String? name, 
      int? status, 
      String? addedDate,}){
    _id = id;
    _name = name;
    _status = status;
    _addedDate = addedDate;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _status = json['status'];
    _addedDate = json['added_date'];
  }
  int? _id;
  String? _name;
  int? _status;
  String? _addedDate;

  int? get id => _id;
  String? get name => _name;
  int? get status => _status;
  String? get addedDate => _addedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['status'] = _status;
    map['added_date'] = _addedDate;
    return map;
  }

}