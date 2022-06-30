import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
// import 'dart:html';
// import 'dart:typed_data';

import 'package:civildeal_user_app/Model/VendorProfileModel.dart';
import 'package:civildeal_user_app/Utils/routs.dart';
import 'package:civildeal_user_app/Widget/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descController = TextEditingController();

  late String vendor_id;
  String ?name,lastname,mobile,address,companyname,pan,desc;

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      vendor_id = pref.getString("id")!;
      // name = pref.getString("username")!;
      // lastname = pref.getString("lastname")!;
      // mobile = pref.getString("mobile")!;
      // address = pref.getString("address")!;
      // companyname = pref.getString("companyName")!;
      // pan = pref.getString("pan")!;
      // desc = pref.getString("desc")!;

      print(vendor_id);
      // print(name);
    });
  }

  Future<VendorProfileModel> getVendorProfile () async{

    final response = await http.post(Uri.parse("https://civildeal.com/Api/getVendorProfile"),
        body: {
          'vendor_id':vendor_id,
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

  void EditProfile(String vendor_id,name,lastname,mobile,address,email) async{



      try{
        Response response = await post(
            Uri.parse("https://civildeal.com/Api/updateProfile"),
            body: {
              'vendor_id':vendor_id,
              'name':name,
              'lastname':lastname,
              'mobile':mobile,
              'address':address,
              'email':email,
              // 'short_description':desc,
              // 'company_name':company_name,
            }
        );

        if(response.statusCode==200){
          var responseData = json.decode(response.body);


          var code= responseData["code"];
          var message= responseData["message"];

          print("responseCode"+code.toString());

          if(code==200){
            // saveData(nameController.text.toString(),lastnameController.text.toString(),mobileNoController.text.toString(),addressController.text.toString(),companyNameController.text.toString(),panController.text.toString(),descController.text.toString());
            setState(() {
              Navigator.pushNamed(context, MyRoutes.editprofileRoute);
            });

            print("Profile Updated Succesfully"+response.body);

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Profile Updated Succesfully"),
            ));
            Fluttertoast.showToast(
                msg: message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );

            var data = responseData["data"];


            print("data"+data[0]["name"]);
          }
          else{

            print("failed"+response.body);
            var message= responseData["message"];
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(""+message),
            ));
            Fluttertoast.showToast(
                msg: message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        }
        else{

          print("failed2"+response.body);
        }
      }catch(e){
        print("exce " +e.toString());
      }

  }

    final ImagePicker imgpicker = ImagePicker();
    String imagepath = "";


    openImage() async {
      try {
        var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
        //you can use ImageCourse.camera for Camera capture
        if(pickedFile != null){
          imagepath = pickedFile.path;
          print(imagepath);
          //output /data/user/0/com.example.testapp/cache/image_picker7973898508152261600.jpg

          File imagefile = File(imagepath); //convert Path to File
          Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
          String base64string = base64.encode(imagebytes);
          String image = "data:image/jpeg;base64," +base64string;//convert bytes to base64 string
          print(base64string);
          //
          //

          updateImage(image);
          //decode base64 stirng to bytes

          setState(() {

          });
        }else{
          print("No image is selected.");
        }
      }catch (e) {
        print("error while picking file.");
      }
    }

  void updateImage(String image) async{



    try{
      Response response = await post(
          Uri.parse("https://civildeal.com/Api/updateImage"),
          body: {
            'vendor_id':vendor_id,
            'image':image,

            // 'short_description':desc,
            // 'company_name':company_name,
          }
      );

      if(response.statusCode==200){
        var responseData = json.decode(response.body);


        var code= responseData["code"];
        var message= responseData["message"];

        print("responseCode"+code.toString());

        if(code==200){
          // saveData(nameController.text.toString(),lastnameController.text.toString(),mobileNoController.text.toString(),addressController.text.toString(),companyNameController.text.toString(),panController.text.toString(),descController.text.toString());
          setState(() {
            Navigator.pushNamed(context, MyRoutes.editprofileRoute);
          });

          print("Profile Image Updated Succesfully"+response.body);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Profile Image Updated Succesfully"),
          ));
          // Fluttertoast.showToast(
          //     msg: message,
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white,
          //     fontSize: 16.0
          // );

        }
        else{

          print("failed"+response.body);
          var message= responseData["message"];
          Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      }
      else{

        print("failed2"+response.body);
      }
    }catch(e){
      print("exce " +e.toString());
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCred();
    getVendorProfile();
    // setState(() {
    //   nameController.text = name??"";
    //   lastnameController.text = lastname??"";
    //   mobileNoController.text = mobile??"";
    //   addressController.text = address??"";
    //   companyNameController.text = companyname??"";
    //   panController.text = pan??"";
    //   descController.text = desc??"";
    // });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
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
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                children: [
                  FutureBuilder<VendorProfileModel>(
                      future: getVendorProfile(),
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          saveData(snapshot.data!.data![0].name.toString(), snapshot.data!.data![0].lastname.toString(), snapshot.data!.data![0].mobile.toString(), snapshot.data!.data![0].address.toString(), snapshot.data!.data![0].companyName.toString(), snapshot.data!.data![0].pan.toString(), snapshot.data!.data![0].description.toString());
                          return Container(
                            child: Column(
                              children: [
                                Container(
                                  color: MyTheme.creamColor,
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 30.0),
                                              child: Container(
                                                height: 100,
                                                width: 100,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(50.0),
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder: 'assets/images/man.png',
                                                    image: "https://civildeal.com/public/assets/uploads/vendor/" +snapshot.data!.data![0].userimage!.toString(),
                                                    imageErrorBuilder: (c, o, s) => Image.asset('assets/images/man.png', fit: BoxFit.cover),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 90,
                                                left: 60,
                                                child: IconButton(onPressed: openImage, icon: Icon(Icons.camera)))
                                          ],
                                        ),
                                      ),

                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 15.0),
                                          child: Text(snapshot.data!.data![0].name!.toString()+ " " +snapshot.data!.data![0].lastname!.toString(),
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                              fontWeight: FontWeight.bold
                                            ),),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 5.0,bottom: 20.0),
                                          child: Text(snapshot.data!.data![0].mobile!.toString(),
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 14
                                            ),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0,left: 15.0),
                                        child: Text("Name",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14
                                          ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: snapshot.data!.data![0].name.toString(),
                                              isDense: true,
                                              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              )
                                          ),
                                          keyboardType: TextInputType.text,
                                          controller: nameController,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0,left: 15.0),
                                        child: Text("Last Name",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14
                                          ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: snapshot.data!.data![0].lastname.toString(),
                                              isDense: true,
                                              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              )
                                          ),
                                          keyboardType: TextInputType.text,
                                          controller: lastnameController,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0,left: 15.0),
                                        child: Text("Mobile",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14,
                                          ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: snapshot.data!.data![0].mobile.toString(),
                                              isDense: true,
                                              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              )
                                          ),
                                          keyboardType: TextInputType.number,
                                          controller: mobileNoController,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0,left: 15.0),
                                        child: Text("Address",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14,
                                          ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: snapshot.data!.data![0].address.toString(),
                                              isDense: true,
                                              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              )
                                          ),
                                          keyboardType: TextInputType.text,
                                          controller: addressController,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0,left: 15.0),
                                        child: Text("Email",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14,
                                          ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: snapshot.data!.data![0].email.toString(),
                                              isDense: true,
                                              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              )
                                          ),
                                          keyboardType: TextInputType.text,
                                          controller: emailController,
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(top: 5.0,left: 15.0),
                                      //   child: Text("Pan",
                                      //     style: TextStyle(
                                      //         color: Colors.red,
                                      //         fontSize: 14,
                                      //     ),),
                                      // ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: TextFormField(
                                      //     decoration: InputDecoration(
                                      //         hintText: "pan",
                                      //         isDense: true,
                                      //         contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      //         border: OutlineInputBorder(
                                      //             borderRadius: BorderRadius.circular(10)
                                      //         )
                                      //     ),
                                      //     keyboardType: TextInputType.text,
                                      //     controller: panController,
                                      //   ),
                                      // ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(top: 5.0,left: 15.0),
                                      //   child: Text("Short Description",
                                      //     style: TextStyle(
                                      //         color: Colors.red,
                                      //         fontSize: 14,
                                      //     ),),
                                      // ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: TextFormField(
                                      //     decoration: InputDecoration(
                                      //         hintText: snapshot.data!.data![0].shortDescription.toString(),
                                      //         isDense: true,
                                      //         contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      //         border: OutlineInputBorder(
                                      //             borderRadius: BorderRadius.circular(10)
                                      //         )
                                      //     ),
                                      //     keyboardType: TextInputType.text,
                                      //     controller: descController,
                                      //   ),
                                      // ),

                                      SizedBox(height: 15,),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0,bottom: 100.0),
                                      //   child: InkWell(
                                      //     onTap: (){
                                      //       EditProfile(vendor_id,nameController.text.toString(),lastnameController.text.toString(),mobileNoController.text.toString(),addressController.text.toString(),emailController.text.toString());
                                      //     },
                                      //     child: Container(
                                      //       height: 50,
                                      //       decoration: BoxDecoration(
                                      //         borderRadius: BorderRadius.circular(10),
                                      //         color: Colors.teal,
                                      //       ),
                                      //
                                      //       child: Center(
                                      //         child: Text(
                                      //           "Submit",
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 30.0,bottom: 50.0),
                                        child: Container(
                                          height: 50,
                                          child: Material(
                                            color: MyTheme.skyblue,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                            elevation: 6.0,
                                            //shadowColor: Colors.grey[50],

                                            child: InkWell(
                                              splashColor: const Color(0x8034b0fc),
                                              onTap: () {
                                                EditProfile(vendor_id,nameController.text.toString(),lastnameController.text.toString(),mobileNoController.text.toString(),addressController.text.toString(),emailController.text.toString());
                                              },
                                              child: Container(

                                                //decoration: ,

                                                child: Center(
                                                  child: Text(
                                                    'Update Profile',
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
                                      SizedBox(height: 15,),
                                    ],
                                  ),
                                )

                              ],
                            ),
                          );
                        }
                        else{
                          return Text("Loading...");
                        }
                      }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}

void saveData(String name,lastname,mobile,address,companyName,pan,desc)
async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString("username", name);
  await pref.setString("lastname", lastname);
  await pref.setString("mobile", mobile);
  await pref.setString("address", address);
  await pref.setString("companyName", companyName);
  await pref.setString("pan", pan);
  await pref.setString("desc", desc);
  // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
}
