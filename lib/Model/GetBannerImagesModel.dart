/// status : "Success"
/// message : "fetch successfully"
/// data : ["https://civildeal.com/civilmall/images/Banners/download.jpg","https://civildeal.com/civilmall/images/Banners/construction-site-silhouette-964422.jpg","https://civildeal.com/civilmall/images/Banners/download (1).jpg","https://civildeal.com/civilmall/images/Banners/images.jpg","https://civildeal.com/civilmall/images/Banners/1655378524.jpg"]

class GetBannerImagesModel {
  GetBannerImagesModel({
      String? status, 
      String? message, 
      List<String>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetBannerImagesModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? json['data'].cast<String>() : [];
  }
  String? _status;
  String? _message;
  List<String>? _data;

  String? get status => _status;
  String? get message => _message;
  List<String>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }

}