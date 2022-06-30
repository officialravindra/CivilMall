/// status : "Success"
/// message : "fetch successfully"
/// data : [{"id":1,"dr_size_id":3,"dr_unit_size_id":7,"dr_building_type":"double story","image":"images (2).jpg","status":1,"added_date":"2022-06-17 12:08:37"}]

class GetDrawingListmodel {
  GetDrawingListmodel({
      String? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetDrawingListmodel.fromJson(dynamic json) {
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
/// dr_size_id : 3
/// dr_unit_size_id : 7
/// dr_building_type : "double story"
/// image : "images (2).jpg"
/// status : 1
/// added_date : "2022-06-17 12:08:37"

class Data {
  Data({
      int? id, 
      int? drSizeId, 
      int? drUnitSizeId, 
      String? drBuildingType, 
      String? image, 
      int? status, 
      String? addedDate,}){
    _id = id;
    _drSizeId = drSizeId;
    _drUnitSizeId = drUnitSizeId;
    _drBuildingType = drBuildingType;
    _image = image;
    _status = status;
    _addedDate = addedDate;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _drSizeId = json['dr_size_id'];
    _drUnitSizeId = json['dr_unit_size_id'];
    _drBuildingType = json['dr_building_type'];
    _image = json['image'];
    _status = json['status'];
    _addedDate = json['added_date'];
  }
  int? _id;
  int? _drSizeId;
  int? _drUnitSizeId;
  String? _drBuildingType;
  String? _image;
  int? _status;
  String? _addedDate;

  int? get id => _id;
  int? get drSizeId => _drSizeId;
  int? get drUnitSizeId => _drUnitSizeId;
  String? get drBuildingType => _drBuildingType;
  String? get image => _image;
  int? get status => _status;
  String? get addedDate => _addedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['dr_size_id'] = _drSizeId;
    map['dr_unit_size_id'] = _drUnitSizeId;
    map['dr_building_type'] = _drBuildingType;
    map['image'] = _image;
    map['status'] = _status;
    map['added_date'] = _addedDate;
    return map;
  }

}