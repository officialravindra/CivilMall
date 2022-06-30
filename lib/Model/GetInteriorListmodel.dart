/// status : "Success"
/// message : "fetch successfully"
/// data : [{"id":1,"size_id":6,"category_id":2,"image":"https://civildeal.com/civilmall/images/interdesign/pexels-eberhard-grossgasteiger-1428277.jpg","status":1,"category_name":"kitchen","size_name":"100/60"}]

class GetInteriorListmodel {
  GetInteriorListmodel({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetInteriorListmodel.fromJson(dynamic json) {
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

/// id : 1
/// size_id : 6
/// category_id : 2
/// image : "https://civildeal.com/civilmall/images/interdesign/pexels-eberhard-grossgasteiger-1428277.jpg"
/// status : 1
/// category_name : "kitchen"
/// size_name : "100/60"

class Data {
  Data({
      int? id, 
      int? sizeId, 
      int? categoryId, 
      String? image, 
      int? status, 
      String? categoryName, 
      String? sizeName,}){
    _id = id;
    _sizeId = sizeId;
    _categoryId = categoryId;
    _image = image;
    _status = status;
    _categoryName = categoryName;
    _sizeName = sizeName;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _sizeId = json['size_id'];
    _categoryId = json['category_id'];
    _image = json['image'];
    _status = json['status'];
    _categoryName = json['category_name'];
    _sizeName = json['size_name'];
  }
  int? _id;
  int? _sizeId;
  int? _categoryId;
  String? _image;
  int? _status;
  String? _categoryName;
  String? _sizeName;

  int? get id => _id;
  int? get sizeId => _sizeId;
  int? get categoryId => _categoryId;
  String? get image => _image;
  int? get status => _status;
  String? get categoryName => _categoryName;
  String? get sizeName => _sizeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['size_id'] = _sizeId;
    map['category_id'] = _categoryId;
    map['image'] = _image;
    map['status'] = _status;
    map['category_name'] = _categoryName;
    map['size_name'] = _sizeName;
    return map;
  }

}