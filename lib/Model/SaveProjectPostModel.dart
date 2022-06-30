/// code : 200
/// status : true
/// data : 1481
/// message : "Project Post successfully"

class SaveProjectPostModel {
  SaveProjectPostModel({
      int? code, 
      bool? status, 
      int? data, 
      String? message,}){
    _code = code;
    _status = status;
    _data = data;
    _message = message;
}

  SaveProjectPostModel.fromJson(dynamic json) {
    _code = json['code'];
    _status = json['status'];
    _data = json['data'];
    _message = json['message'];
  }
  int? _code;
  bool? _status;
  int? _data;
  String? _message;

  int? get code => _code;
  bool? get status => _status;
  int? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['status'] = _status;
    map['data'] = _data;
    map['message'] = _message;
    return map;
  }

}