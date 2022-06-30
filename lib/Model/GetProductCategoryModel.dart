/// status : "Success"
/// message : "fetch successfully"
/// data : [{"category_id":1,"name":"mobile","image":"6298a3f375524.png","status":1,"added_date":"2022-06-02 11:50:11"},{"category_id":2,"name":"tv","image":"6298a3fc4f731.png","status":1,"added_date":"2022-06-02 11:50:20"},{"category_id":3,"name":"akka","image":"62a82cb01b57b.png","status":1,"added_date":"2022-06-14 06:37:36"},{"category_id":4,"name":"akka","image":"62a82cb54fb8c.png","status":1,"added_date":"2022-06-14 06:37:41"},{"category_id":5,"name":"akka","image":"62a830edea454.png","status":1,"added_date":"2022-06-14 06:55:41"},{"category_id":6,"name":"akka","image":"62a833a44ac12.png","status":1,"added_date":"2022-06-14 07:07:16"}]

class GetProductCategoryModel {
  GetProductCategoryModel({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetProductCategoryModel.fromJson(dynamic json) {
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

/// category_id : 1
/// name : "mobile"
/// image : "6298a3f375524.png"
/// status : 1
/// added_date : "2022-06-02 11:50:11"

class Data {
  Data({
      int? categoryId, 
      String? name, 
      String? image, 
      int? status, 
      String? addedDate,}){
    _categoryId = categoryId;
    _name = name;
    _image = image;
    _status = status;
    _addedDate = addedDate;
}

  Data.fromJson(dynamic json) {
    _categoryId = json['category_id'];
    _name = json['name'];
    _image = json['image'];
    _status = json['status'];
    _addedDate = json['added_date'];
  }
  int? _categoryId;
  String? _name;
  String? _image;
  int? _status;
  String? _addedDate;

  int? get categoryId => _categoryId;
  String? get name => _name;
  String? get image => _image;
  int? get status => _status;
  String? get addedDate => _addedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_id'] = _categoryId;
    map['name'] = _name;
    map['image'] = _image;
    map['status'] = _status;
    map['added_date'] = _addedDate;
    return map;
  }

}