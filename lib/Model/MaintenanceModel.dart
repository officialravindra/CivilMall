/// code : 200
/// status : true
/// data : [{"id":29,"parent_id":null,"name":"Electric repairing","description":"<p>&nbsp;Electric repairing&nbsp;</p>","banner_image":"1618822266.jpeg","inner_image":"55681618822266.jpeg","meta_title":"Electric repairing","meta_description":"Electric repairing","meta_keywords":"","service_slug":"electrician-service","user_id":null,"status":1,"location":"1","serviceorder":1,"servicetype":"maintenance","created_at":"2021-04-19 05:58:28","updated_at":"2021-04-19 08:51:06"},{"id":30,"parent_id":null,"name":"Plumbing repairing","description":"<p>Plumbing repairing &amp; maintenance service</p>","banner_image":"1618822203.jpeg","inner_image":"67141618822203.jpeg","meta_title":"Plumbing repairing","meta_description":"Plumbing repairing & maintenance service","meta_keywords":"","service_slug":"plumbing-service","user_id":null,"status":1,"location":"1","serviceorder":2,"servicetype":"maintenance","created_at":"2021-04-19 06:00:30","updated_at":"2021-04-19 08:50:03"},{"id":35,"parent_id":null,"name":"Cctv maintenance","description":"<p>cctv maintenance&nbsp;</p>","banner_image":"1633508621.png","inner_image":"61831633508621.png","meta_title":"Cctv Maintenance","meta_description":"cctv maintenance","meta_keywords":"","service_slug":"cctv-maintenance","user_id":null,"status":1,"location":"","serviceorder":2,"servicetype":"maintenance","created_at":"2021-09-24 08:54:20","updated_at":"2021-10-06 08:23:41"},{"id":31,"parent_id":null,"name":"RO & Geyser Repairing","description":"<p>&nbsp;RO &amp; Geyser repairing &amp; maintenance service&nbsp;</p>","banner_image":"1618821899.jpeg","inner_image":"81151618821899.jpeg","meta_title":"RO & Geyser Repairing","meta_description":"RO repairing & maintenance service","meta_keywords":"","service_slug":"ro-service","user_id":null,"status":1,"location":"1","serviceorder":3,"servicetype":"maintenance","created_at":"2021-04-19 06:03:06","updated_at":"2021-04-27 10:24:35"},{"id":32,"parent_id":null,"name":"AC Repairing","description":"<p>AC Repeiring &amp; maintenance service</p>","banner_image":"1618821776.png","inner_image":"58231618821759.png","meta_title":"AC repairing","meta_description":"AC repairing","meta_keywords":"","service_slug":"ac-service","user_id":null,"status":1,"location":"1","serviceorder":4,"servicetype":"maintenance","created_at":"2021-04-19 06:04:17","updated_at":"2021-04-19 08:48:03"},{"id":37,"parent_id":null,"name":"plaster repairing service","description":"<p>plaster repairing service&nbsp;</p>","banner_image":"1633508984.jpg","inner_image":"13131633508984.jpg","meta_title":"plaster repairing service","meta_description":"plaster repairing service","meta_keywords":"","service_slug":"plaster-repairing-service","user_id":null,"status":1,"location":"","serviceorder":5,"servicetype":"maintenance","created_at":"2021-09-28 10:41:27","updated_at":"2021-10-06 08:29:44"}]
/// message : "Maintenance data fetch successfully"

class MaintenanceModel {
  MaintenanceModel({
      int? code, 
      bool? status, 
      List<Data>? data, 
      String? message,}){
    _code = code;
    _status = status;
    _data = data;
    _message = message;
}

  MaintenanceModel.fromJson(dynamic json) {
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

/// id : 29
/// parent_id : null
/// name : "Electric repairing"
/// description : "<p>&nbsp;Electric repairing&nbsp;</p>"
/// banner_image : "1618822266.jpeg"
/// inner_image : "55681618822266.jpeg"
/// meta_title : "Electric repairing"
/// meta_description : "Electric repairing"
/// meta_keywords : ""
/// service_slug : "electrician-service"
/// user_id : null
/// status : 1
/// location : "1"
/// serviceorder : 1
/// servicetype : "maintenance"
/// created_at : "2021-04-19 05:58:28"
/// updated_at : "2021-04-19 08:51:06"

class Data {
  Data({
      int? id, 
      dynamic parentId, 
      String? name, 
      String? description, 
      String? bannerImage, 
      String? innerImage, 
      String? metaTitle, 
      String? metaDescription, 
      String? metaKeywords, 
      String? serviceSlug, 
      dynamic userId, 
      int? status, 
      String? location, 
      int? serviceorder, 
      String? servicetype, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _parentId = parentId;
    _name = name;
    _description = description;
    _bannerImage = bannerImage;
    _innerImage = innerImage;
    _metaTitle = metaTitle;
    _metaDescription = metaDescription;
    _metaKeywords = metaKeywords;
    _serviceSlug = serviceSlug;
    _userId = userId;
    _status = status;
    _location = location;
    _serviceorder = serviceorder;
    _servicetype = servicetype;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parent_id'];
    _name = json['name'];
    _description = json['description'];
    _bannerImage = json['banner_image'];
    _innerImage = json['inner_image'];
    _metaTitle = json['meta_title'];
    _metaDescription = json['meta_description'];
    _metaKeywords = json['meta_keywords'];
    _serviceSlug = json['service_slug'];
    _userId = json['user_id'];
    _status = json['status'];
    _location = json['location'];
    _serviceorder = json['serviceorder'];
    _servicetype = json['servicetype'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  dynamic _parentId;
  String? _name;
  String? _description;
  String? _bannerImage;
  String? _innerImage;
  String? _metaTitle;
  String? _metaDescription;
  String? _metaKeywords;
  String? _serviceSlug;
  dynamic _userId;
  int? _status;
  String? _location;
  int? _serviceorder;
  String? _servicetype;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  dynamic get parentId => _parentId;
  String? get name => _name;
  String? get description => _description;
  String? get bannerImage => _bannerImage;
  String? get innerImage => _innerImage;
  String? get metaTitle => _metaTitle;
  String? get metaDescription => _metaDescription;
  String? get metaKeywords => _metaKeywords;
  String? get serviceSlug => _serviceSlug;
  dynamic get userId => _userId;
  int? get status => _status;
  String? get location => _location;
  int? get serviceorder => _serviceorder;
  String? get servicetype => _servicetype;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parent_id'] = _parentId;
    map['name'] = _name;
    map['description'] = _description;
    map['banner_image'] = _bannerImage;
    map['inner_image'] = _innerImage;
    map['meta_title'] = _metaTitle;
    map['meta_description'] = _metaDescription;
    map['meta_keywords'] = _metaKeywords;
    map['service_slug'] = _serviceSlug;
    map['user_id'] = _userId;
    map['status'] = _status;
    map['location'] = _location;
    map['serviceorder'] = _serviceorder;
    map['servicetype'] = _servicetype;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}