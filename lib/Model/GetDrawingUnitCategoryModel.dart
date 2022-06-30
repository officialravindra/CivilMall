/// status : "Success"
/// message : "fetch successfully"
/// data : [{"id":10,"name":"H","status":1,"added_date":"2022-06-18 04:50:14"},{"id":7,"name":"Yard/Feet","status":1,"added_date":"2022-06-17 09:29:00"},{"id":6,"name":"Meter / Foot","status":1,"added_date":"2022-06-17 09:15:57"},{"id":5,"name":"Meter","status":1,"added_date":"2022-06-17 09:15:18"},{"id":4,"name":"Feet","status":1,"added_date":"2022-06-17 09:14:24"},{"id":2,"name":"Foot","status":1,"added_date":"2022-06-17 08:19:29"},{"id":1,"name":"yard","status":1,"added_date":"2022-06-17 08:01:38"}]

class GetDrawingUnitCategoryModel {
  GetDrawingUnitCategoryModel({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetDrawingUnitCategoryModel.fromJson(dynamic json) {
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

/// id : 10
/// name : "H"
/// status : 1
/// added_date : "2022-06-18 04:50:14"

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