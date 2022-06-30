import 'dart:convert';
import 'package:civildeal_user_app/Services/Utilities/app_url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import '../Utils/routs.dart';
import '../Widget/theme.dart';
import 'home_page.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;

  TextEditingController mobileNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void Login(String mobile , password) async{

    if(_formKey.currentState!.validate()){

      try{

        Response response = await post(
            Uri.parse(AppUrl.loginApiName),
            body: {
              'mobile':mobile,
              'password':password
            }
        );

        if(response.statusCode==200){


          var responseData = json.decode(response.body);


          var status = responseData["status"];


          print("responseCode"+status.toString());
          var data = responseData["data"];
          print("data"+data["id"].toString());

          if(status == "Success")
          {
            var data = responseData["data"];
            pageRoute(data["id"].toString(),data["path_image"],data["name"],data["lastname"],data["mobile"],data["location_id"].toString(),data["location_name"].toString(),data["email"].toString());
            print("Login Succesfully"+response.body);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Login Succesfully"),
            ));
            print(responseData["message"]);




            var message = responseData["message"];




            print("data"+data["id"]);


          }
          else{
            var data = responseData["data"];
            var message = responseData["message"];
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
            print("data"+data["id"]);
          }



        }else{
          var responseData = json.decode(response.body);
          var message = responseData["message"];

          print("mobile"+mobile);
          print("password"+password);
          print("failed"+response.body);
        }
      }catch(e){
        print(e.toString());
        // Fluttertoast.showToast(
        //     msg: "exc "+e.toString(),
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0
        // );
      }
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString("id");
    if(val != null){
       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset("assets/images/cd_image.jpeg",fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0,left: 20.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, MyRoutes.homeRoute);
                      },
                      child: Text("Skip",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  )
                ],
              ),


              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  child: Row(
                    children: [
                      Text("NEW USER",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          color: MyTheme.skyblue,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 2.0,bottom: 2.0),
                            child: Text("LOGIN",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )

                ),
              ),

              SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white30,width: 1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(height: 20.0,),
                                TextFormField(
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(10),
                                  ],
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      hintText: "Enter Mobile No",
                                      labelText: "Mobile No",
                                      suffix: Icon(Icons.phone),
                                      isDense: true,
                                      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      )
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Mobile No cannot be empty";
                                    }
                                    return null;
                                  },
                                  autofocus: false,
                                  keyboardType: TextInputType.number,
                                  controller: mobileNoController,
                                ),

                                SizedBox(height: 20.0,),

                                TextFormField(
                                  obscureText: _isHidden,
                                  decoration: InputDecoration(
                                      hintText: "Enter Password",
                                      labelText: "Password",
                                      suffix: InkWell(
                                        onTap: _togglePasswordView,
                                        child: Icon(
                                          _isHidden ?         /// CHeck Show & Hide.
                                          Icons.visibility :
                                          Icons.visibility_off,
                                        ),
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      )
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Password cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: passwordController,
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20.0,),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),


          Container(
            height: 50,
            width: 320,
            child: Material(
              color: MyTheme.skyblue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 6.0,
              //shadowColor: Colors.grey[50],

              child: InkWell(
                splashColor: const Color(0x8034b0fc),
                onTap: () {
                  Login(mobileNoController.text.toString(), passwordController.text.toString());
                },
                child: Container(

                  //decoration: ,

                  child: Center(
                    child: Text(
                      'Login',
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

              // InkWell(
              //   onTap: (){
              //     Login(mobileNoController.text.toString(), passwordController.text.toString());
              //   },
              //   child: Center(
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 20.0,right: 20.0),
              //       child: Container(
              //         child: Ink(
              //             height: 50,
              //             decoration: BoxDecoration(
              //                 color: MyTheme.skyblue,
              //                 borderRadius: BorderRadius.circular(10)
              //             ),
              //             child: Center(
              //               child: Text("Login",
              //                 style: TextStyle(
              //                     color: Colors.white
              //                 ),),
              //             )
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              SizedBox(height: 10.0,),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0,right: 30.0,top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, MyRoutes.forgetPasswordRoute);
                        },
                          child: Text("Send OTP")),
                      InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, MyRoutes.registerRoute);
                          },
                          child: Text("Register Now"))
                    ],
                  ),
                ),
              )
              
            ],
          ),
        )

    );
  }

  void pageRoute(String user_id,user_image,name,lastname,mobile,location_id,location_name,email)
  async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    // await pref.setString("login", token);
    await pref.setString("id", user_id);
    // await pref.setString("locationName", city_name);
    await pref.setString("path_image", user_image);
    await pref.setString("name", name);
    await pref.setString("lastname", lastname);
    await pref.setString("mobile", mobile);
    await pref.setString("location_id", location_id);
    await pref.setString("location_name", location_name);
    await pref.setString("email", email);
     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
