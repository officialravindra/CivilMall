/// status : "Success"
/// message : "fetch successfully"
/// data : [{"id":7,"name":"50/20","status":1,"added_date":"2022-06-18 12:19:26"},{"id":6,"name":"100/60","status":1,"added_date":"2022-06-18 12:18:59"},{"id":5,"name":"90/70","status":1,"added_date":"2022-06-18 12:18:43"},{"id":4,"name":"80/60","status":1,"added_date":"2022-06-18 12:18:28"},{"id":3,"name":"50/40","status":1,"added_date":"2022-06-18 12:18:10"},{"id":2,"name":"100/50","status":1,"added_date":"2022-06-18 12:17:43"},{"id":1,"name":"50/50","status":1,"added_date":"2022-06-18 12:17:14"}]

class GetInteriorSizeModel {
  GetInteriorSizeModel({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetInteriorSizeModel.fromJson(dynamic json) {
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

/// id : 7
/// name : "50/20"
/// status : 1
/// added_date : "2022-06-18 12:19:26"

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