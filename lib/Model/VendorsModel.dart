/// code : 200
/// status : true
/// data : [{"id":187,"vendor_code":"CDMTg3187","name":"Jitendra Goutam","lastname":"","email":"jitendra@gmail.com","mobile":"9887955320","password":"$2y$10$xp6p2Qanuqc2o9FUZQQi1OWQdANW/CNzP2UyYNNS1B/6sVaYtqiui","type":"2","vendor_type":"service","service_id":1,"product_id":"","service_prouduct_name":"Architect","userimage":"1624867862user.jpeg","work_image1":"","work_image2":"","location_id":1,"other_location":null,"short_description":"Architectural Designing Interior Designing 3D Views Township Planning","description":"","pdf_profile":"1635334372pdf.pdf","status":"1","otp":0,"leadlimit":null,"address":" 119,Pushp Enclave,Pratap Nagar, Tonk Road, Jaipur  ","pan":"    ","gst":"    ","experience":" 11 years  ","quality":" Best quality  ","team":" 8 Team members ","project_detail":" Bunglow Hanuman Nagar,Mata ji Mandir Fagi,Villa Kishor Nagar  ","company_name":"Creation Design Studio","service_amount":"","remember_token":null,"google2fa_secret":"","order_by":0,"created_at":"2021-06-28 13:41:02","updated_at":"2021-10-27 17:02:52","locationName":"Jaipur"}]
/// message : "Search Vendor fetch  successfully"

class VendorsModel {
  VendorsModel({
      int? code, 
      bool? status, 
      List<Data>? data, 
      String? message,}){
    _code = code;
    _status = status;
    _data = data;
    _message = message;
}

  VendorsModel.fromJson(dynamic json) {
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

/// id : 187
/// vendor_code : "CDMTg3187"
/// name : "Jitendra Goutam"
/// lastname : ""
/// email : "jitendra@gmail.com"
/// mobile : "9887955320"
/// password : "$2y$10$xp6p2Qanuqc2o9FUZQQi1OWQdANW/CNzP2UyYNNS1B/6sVaYtqiui"
/// type : "2"
/// vendor_type : "service"
/// service_id : 1
/// product_id : ""
/// service_prouduct_name : "Architect"
/// userimage : "1624867862user.jpeg"
/// work_image1 : ""
/// work_image2 : ""
/// location_id : 1
/// other_location : null
/// short_description : "Architectural Designing Interior Designing 3D Views Township Planning"
/// description : ""
/// pdf_profile : "1635334372pdf.pdf"
/// status : "1"
/// otp : 0
/// leadlimit : null
/// address : " 119,Pushp Enclave,Pratap Nagar, Tonk Road, Jaipur  "
/// pan : "    "
/// gst : "    "
/// experience : " 11 years  "
/// quality : " Best quality  "
/// team : " 8 Team members "
/// project_detail : " Bunglow Hanuman Nagar,Mata ji Mandir Fagi,Villa Kishor Nagar  "
/// company_name : "Creation Design Studio"
/// service_amount : ""
/// remember_token : null
/// google2fa_secret : ""
/// order_by : 0
/// created_at : "2021-06-28 13:41:02"
/// updated_at : "2021-10-27 17:02:52"
/// locationName : "Jaipur"

class Data {
  Data({
      int? id, 
      String? vendorCode, 
      String? name, 
      String? lastname, 
      String? email, 
      String? mobile, 
      String? password, 
      String? type, 
      String? vendorType, 
      int? serviceId, 
      String? productId, 
      String? serviceProuductName, 
      String? userimage, 
      String? workImage1, 
      String? workImage2, 
      int? locationId, 
      dynamic otherLocation, 
      String? shortDescription, 
      String? description, 
      String? pdfProfile, 
      String? status, 
      int? otp, 
      dynamic leadlimit, 
      String? address, 
      String? pan, 
      String? gst, 
      String? experience, 
      String? quality, 
      String? team, 
      String? projectDetail, 
      String? companyName, 
      String? serviceAmount, 
      dynamic rememberToken, 
      String? google2faSecret, 
      int? orderBy, 
      String? createdAt, 
      String? updatedAt, 
      String? locationName,}){
    _id = id;
    _vendorCode = vendorCode;
    _name = name;
    _lastname = lastname;
    _email = email;
    _mobile = mobile;
    _password = password;
    _type = type;
    _vendorType = vendorType;
    _serviceId = serviceId;
    _productId = productId;
    _serviceProuductName = serviceProuductName;
    _userimage = userimage;
    _workImage1 = workImage1;
    _workImage2 = workImage2;
    _locationId = locationId;
    _otherLocation = otherLocation;
    _shortDescription = shortDescription;
    _description = description;
    _pdfProfile = pdfProfile;
    _status = status;
    _otp = otp;
    _leadlimit = leadlimit;
    _address = address;
    _pan = pan;
    _gst = gst;
    _experience = experience;
    _quality = quality;
    _team = team;
    _projectDetail = projectDetail;
    _companyName = companyName;
    _serviceAmount = serviceAmount;
    _rememberToken = rememberToken;
    _google2faSecret = google2faSecret;
    _orderBy = orderBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _locationName = locationName;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _vendorCode = json['vendor_code'];
    _name = json['name'];
    _lastname = json['lastname'];
    _email = json['email'];
    _mobile = json['mobile'];
    _password = json['password'];
    _type = json['type'];
    _vendorType = json['vendor_type'];
    _serviceId = json['service_id'];
    _productId = json['product_id'];
    _serviceProuductName = json['service_prouduct_name'];
    _userimage = json['userimage'];
    _workImage1 = json['work_image1'];
    _workImage2 = json['work_image2'];
    _locationId = json['location_id'];
    _otherLocation = json['other_location'];
    _shortDescription = json['short_description'];
    _description = json['description'];
    _pdfProfile = json['pdf_profile'];
    _status = json['status'];
    _otp = json['otp'];
    _leadlimit = json['leadlimit'];
    _address = json['address'];
    _pan = json['pan'];
    _gst = json['gst'];
    _experience = json['experience'];
    _quality = json['quality'];
    _team = json['team'];
    _projectDetail = json['project_detail'];
    _companyName = json['company_name'];
    _serviceAmount = json['service_amount'];
    _rememberToken = json['remember_token'];
    _google2faSecret = json['google2fa_secret'];
    _orderBy = json['order_by'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _locationName = json['locationName'];
  }
  int? _id;
  String? _vendorCode;
  String? _name;
  String? _lastname;
  String? _email;
  String? _mobile;
  String? _password;
  String? _type;
  String? _vendorType;
  int? _serviceId;
  String? _productId;
  String? _serviceProuductName;
  String? _userimage;
  String? _workImage1;
  String? _workImage2;
  int? _locationId;
  dynamic _otherLocation;
  String? _shortDescription;
  String? _description;
  String? _pdfProfile;
  String? _status;
  int? _otp;
  dynamic _leadlimit;
  String? _address;
  String? _pan;
  String? _gst;
  String? _experience;
  String? _quality;
  String? _team;
  String? _projectDetail;
  String? _companyName;
  String? _serviceAmount;
  dynamic _rememberToken;
  String? _google2faSecret;
  int? _orderBy;
  String? _createdAt;
  String? _updatedAt;
  String? _locationName;

  int? get id => _id;
  String? get vendorCode => _vendorCode;
  String? get name => _name;
  String? get lastname => _lastname;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get password => _password;
  String? get type => _type;
  String? get vendorType => _vendorType;
  int? get serviceId => _serviceId;
  String? get productId => _productId;
  String? get serviceProuductName => _serviceProuductName;
  String? get userimage => _userimage;
  String? get workImage1 => _workImage1;
  String? get workImage2 => _workImage2;
  int? get locationId => _locationId;
  dynamic get otherLocation => _otherLocation;
  String? get shortDescription => _shortDescription;
  String? get description => _description;
  String? get pdfProfile => _pdfProfile;
  String? get status => _status;
  int? get otp => _otp;
  dynamic get leadlimit => _leadlimit;
  String? get address => _address;
  String? get pan => _pan;
  String? get gst => _gst;
  String? get experience => _experience;
  String? get quality => _quality;
  String? get team => _team;
  String? get projectDetail => _projectDetail;
  String? get companyName => _companyName;
  String? get serviceAmount => _serviceAmount;
  dynamic get rememberToken => _rememberToken;
  String? get google2faSecret => _google2faSecret;
  int? get orderBy => _orderBy;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get locationName => _locationName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['vendor_code'] = _vendorCode;
    map['name'] = _name;
    map['lastname'] = _lastname;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['password'] = _password;
    map['type'] = _type;
    map['vendor_type'] = _vendorType;
    map['service_id'] = _serviceId;
    map['product_id'] = _productId;
    map['service_prouduct_name'] = _serviceProuductName;
    map['userimage'] = _userimage;
    map['work_image1'] = _workImage1;
    map['work_image2'] = _workImage2;
    map['location_id'] = _locationId;
    map['other_location'] = _otherLocation;
    map['short_description'] = _shortDescription;
    map['description'] = _description;
    map['pdf_profile'] = _pdfProfile;
    map['status'] = _status;
    map['otp'] = _otp;
    map['leadlimit'] = _leadlimit;
    map['address'] = _address;
    map['pan'] = _pan;
    map['gst'] = _gst;
    map['experience'] = _experience;
    map['quality'] = _quality;
    map['team'] = _team;
    map['project_detail'] = _projectDetail;
    map['company_name'] = _companyName;
    map['service_amount'] = _serviceAmount;
    map['remember_token'] = _rememberToken;
    map['google2fa_secret'] = _google2faSecret;
    map['order_by'] = _orderBy;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['locationName'] = _locationName;
    return map;
  }

}