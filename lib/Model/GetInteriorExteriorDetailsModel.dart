/// status : "Success"
/// message : "fetch successfully"
/// id : "1"
/// size : "100/60"
/// image : ["https://civildeal.com/civilmall/images/interdesign/pexels-eberhard-grossgasteiger-1428277.jpg","https://civildeal.com/civilmall/images/interdesign/pexels-eberhard-grossgasteiger-1428277.jpg","https://civildeal.com/civilmall/images/interdesign/pexels-eberhard-grossgasteiger-1428277.jpg"]

class GetInteriorExteriorDetailsModel {
  GetInteriorDetailsmodel({
      String? status, 
      String? message, 
      String? id, 
      String? size, 
      List<String>? image,}){
    _status = status;
    _message = message;
    _id = id;
    _size = size;
    _image = image;
}

  GetInteriorExteriorDetailsModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _id = json['id'];
    _size = json['size'];
    _image = json['image'] != null ? json['image'].cast<String>() : [];
  }
  String? _status;
  String? _message;
  String? _id;
  String? _size;
  List<String>? _image;

  String? get status => _status;
  String? get message => _message;
  String? get id => _id;
  String? get size => _size;
  List<String>? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['id'] = _id;
    map['size'] = _size;
    map['image'] = _image;
    return map;
  }

}