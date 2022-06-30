class AppUrl {

  // this is our base URl
  static const String baseURL = 'https://civildeal.com/';


  // fetch api names

  static const String loginApiName = baseURL + 'civilmall/api/user_login';
  // static const String loginApiName = baseURL + 'Api/loginPassword';
  static const String forgotLogin = baseURL + 'civilmall/api/forgotLogin';
  static const String verifyotpLogin = baseURL + 'civilmall/api/otpVerify';
  static const String confirmpasswordLogin = baseURL + 'civilmall/api/conformPassword';
  static const String getCityApi = baseURL + 'Api/getCity';
  static const String registerApi = baseURL + 'civilmall/api/user_register';
  // static const String registerApi = baseURL + 'Api/user_register';
  static const String servicerApi = baseURL + 'Api/getServices';
  static const String productApi = baseURL + 'Api/getProduct';
  static const String maintenanceApi = baseURL + 'Api/getMaintenance';
  static const String latestProductApi = baseURL + 'civilmall/api/latestProduct';
  static const String directVendorEnquiryApi = baseURL + 'Api/saveDirectVendorEnquery';
  static const String saveProjectPostApi = baseURL + 'Api/saveProjectPost';
  static const String getallproductcategoryApi = baseURL + 'civilmall/api/getallcategory';
  static const String getDrawingUnitApi = baseURL + 'civilmall/api/getDrawingUnit';
  static const String getDrawingSizeApi = baseURL + 'civilmall/api/getDrawingSize';
  static const String getDrawingListApi = baseURL + 'civilmall/api/getdrawing';
  static const String getDrawingDetailsApi = baseURL + 'civilmall/api/getdrawingdetail';
  static const String getInteriorCategoryApi = baseURL + 'civilmall/api/getInterDesignCategory';
  static const String getInteriorSizeApi = baseURL + 'civilmall/api/getInterDesignSize';
  static const String getInteriorListApi = baseURL + 'civilmall/api/getInterDesign';
  static const String getInteriorDetailsApi = baseURL + 'civilmall/api/getInterDesigndetail';
  static const String getBannerImagesApi = baseURL + 'civilmall/api/getbanners';
}