/// status : "Success"
/// message : "fetch successfully"
/// data : [{"sub_category_id":1,"name":"samsung","image":"6298a41549b33.png","category_id":"1","category_name":"mobile","status":1,"added_date":"2022-06-02 11:50:45"},{"sub_category_id":2,"name":"realme","image":"6298a41c49d18.png","category_id":"1","category_name":"mobile","status":1,"added_date":"2022-06-02 11:50:52"}]

class GetProductSubCategoryModel {
  GetProductSubCategoryModel({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetProductSubCategoryModel.fromJson(dynamic json) {
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

/// sub_category_id : 1
/// name : "samsung"
/// image : "6298a41549b33.png"
/// category_id : "1"
/// category_name : "mobile"
/// status : 1
/// added_date : "2022-06-02 11:50:45"

class Data {
  Data({
      int? subCategoryId, 
      String? name, 
      String? image, 
      String? categoryId, 
      String? categoryName, 
      int? status, 
      String? addedDate,}){
    _subCategoryId = subCategoryId;
    _name = name;
    _image = image;
    _categoryId = categoryId;
    _categoryName = categoryName;
    _status = status;
    _addedDate = addedDate;
}

  Data.fromJson(dynamic json) {
    _subCategoryId = json['sub_category_id'];
    _name = json['name'];
    _image = json['image'];
    _categoryId = json['category_id'];
    _categoryName = json['category_name'];
    _status = json['status'];
    _addedDate = json['added_date'];
  }
  int? _subCategoryId;
  String? _name;
  String? _image;
  String? _categoryId;
  String? _categoryName;
  int? _status;
  String? _addedDate;

  int? get subCategoryId => _subCategoryId;
  String? get name => _name;
  String? get image => _image;
  String? get categoryId => _categoryId;
  String? get categoryName => _categoryName;
  int? get status => _status;
  String? get addedDate => _addedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sub_category_id'] = _subCategoryId;
    map['name'] = _name;
    map['image'] = _image;
    map['category_id'] = _categoryId;
    map['category_name'] = _categoryName;
    map['status'] = _status;
    map['added_date'] = _addedDate;
    return map;
  }

}