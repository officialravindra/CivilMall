/// code : 200
/// status : true
/// data : [{"id":1331,"user_id":34,"name":"tarun kumar ","email":"tarun@gmail.com","title":"apna.com","description":"Best ","select_size":"running feet","size":"500","min_bujet":"250000","max_bujet":"500000","location":"1","other_location":"","images":"6281f1d169368.jpeg","post_type":null,"service_id":null,"product_id":null,"is_profile_visited":"0","expired_date":null,"status":"Active","created_at":"2022-05-16 12:10:17","updated_at":"2022-05-16 12:10:17","locationName":"Jaipur","image_path":"https://civildeal.com/public/assets/uploads/project_document/projectpost/34-1331"}]
/// message : ""

class CheckBidModel {
  CheckBidModel({
      int? code, 
      bool? status, 
      List<Data>? data, 
      String? message,}){
    _code = code;
    _status = status;
    _data = data;
    _message = message;
}

  CheckBidModel.fromJson(dynamic json) {
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

/// id : 1331
/// user_id : 34
/// name : "tarun kumar "
/// email : "tarun@gmail.com"
/// title : "apna.com"
/// description : "Best "
/// select_size : "running feet"
/// size : "500"
/// min_bujet : "250000"
/// max_bujet : "500000"
/// location : "1"
/// other_location : ""
/// images : "6281f1d169368.jpeg"
/// post_type : null
/// service_id : null
/// product_id : null
/// is_profile_visited : "0"
/// expired_date : null
/// status : "Active"
/// created_at : "2022-05-16 12:10:17"
/// updated_at : "2022-05-16 12:10:17"
/// locationName : "Jaipur"
/// image_path : "https://civildeal.com/public/assets/uploads/project_document/projectpost/34-1331"

class Data {
  Data({
      int? id, 
      int? userId, 
      String? name, 
      String? email, 
      String? title, 
      String? description, 
      String? selectSize, 
      String? size, 
      String? minBujet, 
      String? maxBujet, 
      String? location, 
      String? otherLocation, 
      String? images, 
      dynamic postType, 
      dynamic serviceId, 
      dynamic productId, 
      String? isProfileVisited, 
      dynamic expiredDate, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      String? locationName, 
      String? imagePath,}){
    _id = id;
    _userId = userId;
    _name = name;
    _email = email;
    _title = title;
    _description = description;
    _selectSize = selectSize;
    _size = size;
    _minBujet = minBujet;
    _maxBujet = maxBujet;
    _location = location;
    _otherLocation = otherLocation;
    _images = images;
    _postType = postType;
    _serviceId = serviceId;
    _productId = productId;
    _isProfileVisited = isProfileVisited;
    _expiredDate = expiredDate;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _locationName = locationName;
    _imagePath = imagePath;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _name = json['name'];
    _email = json['email'];
    _title = json['title'];
    _description = json['description'];
    _selectSize = json['select_size'];
    _size = json['size'];
    _minBujet = json['min_bujet'];
    _maxBujet = json['max_bujet'];
    _location = json['location'];
    _otherLocation = json['other_location'];
    _images = json['images'];
    _postType = json['post_type'];
    _serviceId = json['service_id'];
    _productId = json['product_id'];
    _isProfileVisited = json['is_profile_visited'];
    _expiredDate = json['expired_date'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _locationName = json['locationName'];
    _imagePath = json['image_path'];
  }
  int? _id;
  int? _userId;
  String? _name;
  String? _email;
  String? _title;
  String? _description;
  String? _selectSize;
  String? _size;
  String? _minBujet;
  String? _maxBujet;
  String? _location;
  String? _otherLocation;
  String? _images;
  dynamic _postType;
  dynamic _serviceId;
  dynamic _productId;
  String? _isProfileVisited;
  dynamic _expiredDate;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _locationName;
  String? _imagePath;

  int? get id => _id;
  int? get userId => _userId;
  String? get name => _name;
  String? get email => _email;
  String? get title => _title;
  String? get description => _description;
  String? get selectSize => _selectSize;
  String? get size => _size;
  String? get minBujet => _minBujet;
  String? get maxBujet => _maxBujet;
  String? get location => _location;
  String? get otherLocation => _otherLocation;
  String? get images => _images;
  dynamic get postType => _postType;
  dynamic get serviceId => _serviceId;
  dynamic get productId => _productId;
  String? get isProfileVisited => _isProfileVisited;
  dynamic get expiredDate => _expiredDate;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get locationName => _locationName;
  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['name'] = _name;
    map['email'] = _email;
    map['title'] = _title;
    map['description'] = _description;
    map['select_size'] = _selectSize;
    map['size'] = _size;
    map['min_bujet'] = _minBujet;
    map['max_bujet'] = _maxBujet;
    map['location'] = _location;
    map['other_location'] = _otherLocation;
    map['images'] = _images;
    map['post_type'] = _postType;
    map['service_id'] = _serviceId;
    map['product_id'] = _productId;
    map['is_profile_visited'] = _isProfileVisited;
    map['expired_date'] = _expiredDate;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['locationName'] = _locationName;
    map['image_path'] = _imagePath;
    return map;
  }

}