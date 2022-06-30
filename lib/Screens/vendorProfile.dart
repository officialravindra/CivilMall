import 'dart:convert';
import 'dart:io';


import 'package:civildeal_user_app/Model/GetCityModel.dart';
import 'package:civildeal_user_app/Model/VendorProfileModel.dart';
import 'package:civildeal_user_app/Services/Utilities/app_url.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';


class VendorProfile extends StatefulWidget {
  String id;
  VendorProfile({Key? key, required this.id}) : super(key: key);

  @override
  State<VendorProfile> createState() => _VendorProfileState(id);
}

class _VendorProfileState extends State<VendorProfile> {
  String id;
  _VendorProfileState(this.id);

  final _formKey = GlobalKey<FormState>();
  TextEditingController requirmentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  List cityList = [];

  String ?_selectedCity,lead_type;

  Future<GetCityModel> getCityList () async{
    final response = await http.get(Uri.parse(AppUrl.getCityApi));
    var data = jsonDecode(response.body.toString());
    var code= data["code"];
    setState(() {
      cityList = data['data'];
    });

    print(cityList);
    if(response.statusCode==200){
      if(code == 200){
        print("sucess");
        return GetCityModel.fromJson(data);

      }
      else{
        print("fail");
        return GetCityModel.fromJson(data);

      }
    }
    else{
      return GetCityModel.fromJson(data);
    }
  }

  openwhatsapp(String mobile) async{
    print(mobile);
    var whatsappURl_android = "whatsapp://send?phone="+mobile+"&text=hello";
    var whatappURL_ios ="https://wa.me/$mobile?text=${Uri.parse("hello")}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp not installed")));
      }
    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp not installed")));
      }
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<VendorProfileModel> getVendorProfile (String id) async{

    final response = await http.post(Uri.parse("https://civildeal.com/Api/getVendorProfile"),
        body: {
          'vendor_id':id,
        }
    );
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      var responseData = json.decode(response.body);
      var code= responseData["code"];
      var message= responseData["message"];

      if(code==200){
        return VendorProfileModel.fromJson(data);
      }else{
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return VendorProfileModel.fromJson(data);
      }
    }
    else
    {
      return VendorProfileModel.fromJson(data);
    }

  }

  void submitSendEnquiry(String requirment , name , email , mobile , cityid) async{

    if(_formKey.currentState!.validate()){

      try{

        Response response = await post(
            Uri.parse(AppUrl.directVendorEnquiryApi),
            body: {
              'query':requirment,
              'name':name,
              'email':email,
              'phone':mobile,
              'citi_id':cityid,
              'vendor_id':id,
              'service_id':"",
              'product_id':"",
              'leadtype':lead_type,
            }
        );

        if(response.statusCode==200){


          var responseData = json.decode(response.body);


          var code= responseData["code"];


          print("responseCode"+code.toString());


          if(code == 200)
          {
            var data = responseData["data"];
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text("Enquiry Send Succesfully"),
            // ));
            requirmentController.clear();
            nameController.clear();
            emailController.clear();
            mobileController.clear();
            Fluttertoast.showToast(
                msg: "Enquiry Send Succesfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
            print(responseData["message"]);

          }
          else{

            var message = responseData["message"];
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text(""+message),
            // ));
            Fluttertoast.showToast(
                msg: message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }



        }else{
          var responseData = json.decode(response.body);

        }
      }catch(e){
        print("exc "+e.toString());
      }
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCityList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendor Profile"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                MyTheme.lightorange,
                MyTheme.orange
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: MyTheme.creamColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder<VendorProfileModel>(
                future: getVendorProfile(id),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    lead_type=snapshot.data!.data![0].vendorType.toString();
                    return SingleChildScrollView(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,

                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Container(
                                    height:200,
                                    width: double.infinity,
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/images/cd_image.jpeg',
                                        image: 'https://civildeal.com/public/assets/uploads/vendor/images/'+snapshot.data!.data![0].workImage1.toString(),
                                        imageErrorBuilder: (c, o, s) => Image.asset('assets/images/cd_image.jpeg', fit: BoxFit.cover),
                                        fit: BoxFit.cover,
                                      )
                                    // decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(10),
                                    //     image: DecorationImage(
                                    //       fit: BoxFit.fill,
                                    //       image: NetworkImage("https://civildeal.com/public/assets/uploads/vendor/images/" +snapshot.data!.data![0].workImage1.toString() ?? "https://stackoverflow.design/assets/img/logos/so/logo-stackoverflow.png"),
                                    //     )
                                    // ),
                                  ),
                                ),
                                Positioned(
                                  top: 200-60,
                                    left: 20,
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey.shade800,
                                        backgroundImage:
                                        NetworkImage('https://civildeal.com/public/assets/uploads/vendor/'+snapshot.data!.data![0].userimage!.toString()),
                                      ),
                                    )),


                              ],
                            ),
                            SizedBox(height: 30,),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0,left: 35),
                              child: Text(snapshot.data!.data![0].name!.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black
                                ),),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: InkWell(
                                    onTap: (){
                                      openwhatsapp("+91 "+snapshot.data!.data![0].mobile.toString());
                                    },
                                    child: Container(
                                      height:50,
                                      width: 50,
                                      child: Center(
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage("assets/images/whats_app.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: InkWell(
                                    onTap: (){
                                      _makePhoneCall('tel:'+snapshot.data!.data![0].mobile.toString());
                                    },
                                    child: Container(
                                      height:50,
                                      width: 50,
                                      child: Center(
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage("assets/images/telephone1.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0,right: 30.0,top: 5.0,bottom: 5.0),
                              child: Container(
                                height: 50,
                                child: Material(
                                  color: MyTheme.skyblue,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                                  elevation: 6.0,
                                  //shadowColor: Colors.grey[50],

                                  child: InkWell(
                                    splashColor: const Color(0x8034b0fc),
                                    onTap: () {
                                      sendEnquiry();                      },
                                    child: Container(

                                      //decoration: ,

                                      child: Center(
                                        child: Text(
                                          'Send Enquiry',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 40,
                                        color: MyTheme.creamColor,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex:40,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 2.0),
                                                child: Text("Company Name",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex:60,
                                              child: Text(snapshot.data!.data![0].companyName!.toString().trim(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex:40,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 2.0),
                                                child: Text("Address",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex:60,
                                              child: Text(snapshot.data!.data![0].address!.toString().trim(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        color: MyTheme.creamColor,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex:40,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 2.0),
                                                child: Text("Quality",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex:60,
                                              child: Text(snapshot.data!.data![0].quality!.toString().trim(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex:40,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 2.0),
                                                child: Text("Experience",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex:60,
                                              child: Text(snapshot.data!.data![0].experience!.toString().trim(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        color: MyTheme.creamColor,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex:40,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 2.0),
                                                child: Text("Project Details",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex:60,
                                              child: Text(snapshot.data!.data![0].projectDetail!.toString().trim(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text("Description",
                                      style:TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        color: Colors.black12,
                                        height: 1,
                                        width: double.infinity,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(snapshot.data!.data![0].shortDescription.toString(),
                                      style: TextStyle(
                                        fontSize: 12
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),

                      ),
                    );
                  }else
                    {
                      return Text("Loading...");
                    }
                },
              ),
            )

          ],
        ),
      ),
    );
  }

  void sendEnquiry() {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(

              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("TELL US WHAT YOU",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: MyTheme.skyblue,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                                  child: Text(
                                    "NEED",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        color: Colors.black54,
                        height: 1,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 15,),
        Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Enter Requirment",
                          labelText: "Requirment",
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Requirment cannot be empty";
                        }
                        return null;
                      },
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      controller: requirmentController,
                    ),

                    SizedBox(height: 20.0,),

                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Enter Your Name",
                          labelText: "Name",
                          suffixIcon: Icon(Icons.person),
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Name cannot be empty";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      controller: nameController,
                    ),

                    SizedBox(height: 20.0,),

                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: "Enter Email",
                          labelText: "Email",
                          suffixIcon: Icon(Icons.email),
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Email cannot be empty";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    SizedBox(height: 20.0,),

                    TextFormField(
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                          hintText: "Enter Mobile",
                          labelText: "Mobile",
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Mobile cannot be empty";
                        }else if(value.length < 10){
                          return "Fill 10 number digit";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: mobileController,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        color: Colors.black45, style: BorderStyle.solid, width: 0.80),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _selectedCity,
                      onChanged: (newCity){
                        setState(() {
                          _selectedCity = "$newCity";
                          print("citi "+_selectedCity!);
                        });
                      },
                      items: cityList.map((item) {
                        return DropdownMenuItem(
                          child: Text(item['name']),
                          value: item['id'].toString(),
                        );
                      }).toList(),
                      hint: Text("Select City"),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0,bottom: 100.0),
                child: InkWell(
                  onTap: (){
                     submitSendEnquiry(requirmentController.text.toString(),nameController.text.toString(),emailController.text.toString(),mobileController.text.toString(),_selectedCity);
                  },
                  child: Ink(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyTheme.skyblue,
                    ),

                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
        ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => errorDialog);}

}
