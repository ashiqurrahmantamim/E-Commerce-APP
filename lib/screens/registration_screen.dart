// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:food_app/model/register_model.dart';
// // import 'package:food_app/screens/otp_screen.dart';
// // import 'package:food_app/utils/colors.dart';
// // import 'package:food_app/utils/static_text.dart';
// // import 'package:get/route_manager.dart';
// // import 'package:http/http.dart'as http;
// // class RegistrationScreen extends StatefulWidget {
// //   const RegistrationScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<RegistrationScreen> createState() => _RegistrationScreenState();
// // }
// //
// // class _RegistrationScreenState extends State<RegistrationScreen> {
// //
// //   RegisterModel ? _registerModel;
// //   bool loader = false;
// //   String ? registerBy;
// //   final TextEditingController nameController = TextEditingController();
// //   final TextEditingController emailOrPhone = TextEditingController();
// //   final TextEditingController password = TextEditingController();
// //   final TextEditingController confirmPassword = TextEditingController();
// //   final GlobalKey<FormState>  key = GlobalKey<FormState>();
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: BG_COLOR,
// //         title: Text(REGISTRIONTEXT),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Form(
// //           key: key,
// //           child: Column(
// //             children: [
// //
// //               Padding(
// //                 padding: const EdgeInsets.only(left: 28.0,right: 28,top: 100),
// //                 child: Card(
// //                   color: Colors.white,
// //                   elevation: 2,
// //                   child: TextFormField(
// //                     validator: (value){
// //                       if(value!.isEmpty){
// //                         return "Please enter your name";
// //                       }
// //                     },
// //                     controller: nameController,
// //                     decoration: InputDecoration(
// //                       contentPadding: EdgeInsets.only(left: 14),
// //                       border: InputBorder.none,
// //                       hintText: "Name",
// //                       labelText: "Name"
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.only(left: 28.0,right: 28,top: 20),
// //                 child: Card(
// //                   color: Colors.white,
// //                   elevation: 2,
// //                   child:  TextFormField(
// //                     validator: (value){
// //                       if(value!.isEmpty){
// //                         return "Please enter your phone or email";
// //                       }
// //                     },
// //                     controller: emailOrPhone,
// //                     decoration: InputDecoration(
// //                         contentPadding: EdgeInsets.only(left: 14),
// //                         border: InputBorder.none,
// //                         hintText: "Email or Phone",
// //                         labelText: "Email or phone"
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.only(left: 28.0,right: 28,top: 20),
// //                 child: Card(
// //                   color: Colors.white,
// //                   elevation: 2,
// //                   child:  TextFormField(
// //                     validator: (value){
// //                       if(value!.isEmpty){
// //                         return "Please enter your password";
// //                       }
// //                     },
// //                     controller: password,
// //                     decoration: InputDecoration(
// //                         contentPadding: EdgeInsets.only(left: 14),
// //                         border: InputBorder.none,
// //                         hintText: "Password",
// //                         labelText: "Password"
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.only(left: 28.0,right: 28,top: 20),
// //                 child: Card(
// //                   color: Colors.white,
// //                   elevation: 2,
// //                   child:  TextFormField(
// //                     validator: (value){
// //                       if(value!.isEmpty){
// //                         return "Please enter your confirm password";
// //                       }
// //                     },
// //                     controller: confirmPassword,
// //                     decoration: InputDecoration(
// //                         contentPadding: EdgeInsets.only(left: 14),
// //                         border: InputBorder.none,
// //                         hintText: "Confirm Password",
// //                         labelText: "Confirm Password"
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //
// //
// //               SizedBox(height: 30,),
// //
// //
// //            loader ? Center(child: CircularProgressIndicator(
// //              color: Colors.indigo,
// //            ),) :
// //            InkWell(
// //                 onTap: (){
// //                   if(key.currentState!.validate()){
// //                     register();
// //
// //                   }
// //                 },
// //                 child: Padding(
// //                   padding: const EdgeInsets.only(left: 28.0,right: 28),
// //                   child: Container(
// //                     alignment: Alignment.center,
// //                     decoration: BoxDecoration(
// //                       color: Colors.indigo,
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                     height: 45,
// //                     width: double.infinity,
// //                     child: Text("Sign up",style: TextStyle(
// //                       fontSize: 18,color: Colors.white
// //                     ),),
// //
// //                   ),
// //                 ),
// //               ),
// //
// //
// //
// //
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// //   Future<RegisterModel?>  register()async{
// //     setState(() {
// //       loader = true;
// //     });
// //     if(emailOrPhone.text.contains("@")){
// //       registerBy = "email";
// //     }else{
// //       registerBy = "phone";
// //     }
// //
// //
// //     var body = {
// //       "name" : "${nameController.text}",
// //       "email_or_phone" : "${emailOrPhone.text}",
// //       "password" : "${password.text}",
// //       "password_confirmation" : "${confirmPassword.text}",
// //       "register_by" : "${registerBy}",
// //     };
// //     print("Body ___$body");
// //
// //     var response = await http.post(Uri.parse("https://bdraj.com/api/v2/auth/signup"),
// //     body: body,
// //       headers: {
// //       "Accept" : "application/json"
// //       },
// //     );
// //     _registerModel = registerModelFromJson(response.body);
// //
// //     if(response.statusCode==201){
// //
// //       if(_registerModel!.result==false){
// //         Fluttertoast.showToast(
// //             msg: "${_registerModel!.message.toString()}",
// //             toastLength: Toast.LENGTH_SHORT,
// //             gravity: ToastGravity.CENTER,
// //             timeInSecForIosWeb: 1,
// //             backgroundColor: Colors.red,
// //             textColor: Colors.white,
// //             fontSize: 16.0
// //         );
// //         setState(() {
// //           loader = false;
// //         });
// //
// //       }else{
// //
// //         setState(() {
// //           loader = false;
// //           Fluttertoast.showToast(
// //               msg: "${_registerModel!.message.toString()}",
// //               toastLength: Toast.LENGTH_SHORT,
// //               gravity: ToastGravity.CENTER,
// //               timeInSecForIosWeb: 1,
// //               backgroundColor: Colors.red,
// //               textColor: Colors.white,
// //               fontSize: 16.0
// //           );
// //
// //           Get.to(OTPScreen(userId: _registerModel!.userId!,));
// //
// //           print("response__${response.body}");
// //
// //         });
// //       }
// //
// //     }else{
// //       setState(() {
// //         loader = false;
// //       });
// //     }
// //     return _registerModel;
// //
// //   }
// //
// //
// // }
// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:food_app/utils/colors.dart';
//
// import 'package:get/get.dart';
//
// import 'package:http/http.dart'as http;
// import 'package:pinput/pinput.dart';
//
// import '../model/sign_up_model.dart';
//
// class SignUpScreen extends StatefulWidget {
//   final String ? phone;
//   final String ? email;
//   final String ? name;
//   final String ? type;
//   const SignUpScreen({Key? key, this.phone,this.email,this.name, this.type}) : super(key: key);
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//
//   String ? otp;
//
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   late SignUpRes _loginRes;
//
//   @override
//   void initState() {
//     _emailController.text=widget.email ?? "";
//     _nameController.text=widget.name ?? "";
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         centerTitle: true,
//         backgroundColor:BG_COLOR,
//         elevation: 2,
//         iconTheme: IconThemeData(color: Colors.white),
//         title: Text("Signup",style: TextStyle(fontSize: 17,color: Colors.white),),
//       ),
//       body:  SingleChildScrollView(
//         child: Column(
//
//           children: [
//             SizedBox(height: 20,),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30.0),
//               ),
//               child: Center(
//                   child: CircleAvatar(
//                     radius: 55,
//                     backgroundColor: Colors.white,
//                     backgroundImage: AssetImage("assets/images/a.jpg"),
//                   )
//               ),
//             ),
//             SizedBox(height: 30,),
//
//             // Padding(
//             //   padding: const EdgeInsets.only(left: 38.0,right: 38),
//             //   child: Center(child: Text("Login with your mobile number.We'll send you a code to the given mobile number to login into your account",textAlign: TextAlign.center,)),
//             // ),
//
//             // SizedBox(height: 40,),
//
//             Padding(
//               padding: const EdgeInsets.only(left: 28.0,right: 24,bottom: 20),
//               child: Container(
//
//                 child:
//                 TextField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                       hintText: "Email",
//                       border: OutlineInputBorder()
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 28.0,right: 24,bottom: 20),
//               child: Container(
//
//                 child:
//                 TextField(
//                   controller: _nameController,
//                   decoration: InputDecoration(
//                       hintText: "Name",
//                       border: OutlineInputBorder()
//                   ),
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 0,),
//             Padding(
//               padding: const EdgeInsets.only(left: 30.0,top: 9,bottom: 10),
//               child: Row(
//                 children: [
//                   Text("OTP CODE",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: Pinput(
//                 // useNativeKeyboard: true,
//                 length: 6,
//                 //   autofocus: true,
//                 closeKeyboardWhenCompleted: true,
//                 defaultPinTheme: PinTheme(
//
//
//                   width: 40,
//                   height: 46,
//
//                   textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onCompleted: (pin) {
//                   setState(() {
//                     otp= pin;
//
//                   });
//                 },
//               ),
//             ),
//
//             SizedBox(height: 13,),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 InkWell(
//                   onTap: (){
//                     Get.back();
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//
//                       color:  HexColor("#f15a22"),
//                     ),
//                     height: 50,
//                     width: 100,
//                     child: Text("Back",style: TextStyle(fontSize: 16,color: Colors.white),),
//                   ),
//                 ),
//
//                 InkWell(
//                   onTap: (){
//                     if(_nameController.text== "" && _emailController.text=="" ){
//
//                     }else{
//                       checkAPI();
//
//                     }
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: BG_COLOR
//                     ),
//                     height: 50,
//                     width: 100,
//                     child: Text("Verify",style: TextStyle(fontSize: 16,color: Colors.white),),
//                   ),
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 13,),
//
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<dynamic> checkAPI() async {
//
//
//     EasyLoading.show( maskType: EasyLoadingMaskType.clear);
//     Map<String, dynamic> jsonMap = {
//       'phone_number': "+88${widget.phone}",
//       'code': "$otp",
//       'name': _nameController.text,
//       'email': _emailController.text,
//
//     };
//
//     try{
//       final response = await http.post(
//         Uri.parse("https://grocery.ebasket.com.bd/api/otp-login"),
//         headers: {
//           "Accept": "application/json",
//         },
//         encoding: Encoding.getByName("utf-8"),
//         body: jsonMap,
//       );
//
//       EasyLoading.dismiss();
//       // progressDialog.dismiss();
//       _loginRes = signUpResFromJson(response.body);
//       _errorModel = errorModelFromJson(response.body);
//
//       print("Login __Response ___${response.body}");
//
//       if(response.statusCode==200) {
//         if (_loginRes.token!=null) {
//
//           MyPrefs.setToken(_loginRes.token.toString());
//           MyPrefs.setName(_nameController.text.toString());
//           MyPrefs.setPhone(widget.phone.toString());
//           MyPrefs.setPhone(widget.phone.toString());
//           MyPrefs.setId(_loginRes.customer!.id.toString());
//           MyPrefs.setStatus(_loginRes.customerStatus.toString());
//
//           showToast('Registration Successfully',
//             context: context,
//             textStyle: TextStyle(fontSize: 17,color: Colors.white),
//             backgroundColor: Colors.red,
//             animation: StyledToastAnimation.scale,
//             reverseAnimation: StyledToastAnimation.fade,
//             position: StyledToastPosition.center,
//             animDuration: Duration(seconds: 1),
//             duration: Duration(seconds: 4),
//             curve: Curves.elasticOut,
//             reverseCurve: Curves.linear,
//           );
//
//           if(widget.type=="1"){
//             log("Login 1 Response ___${response.body}");
//             Get.offAll(CartScreen());
//
//           }else{
//             log("Login 2 Response ___${response.body}");
//             Get.offAll(NewHomeScreen());
//
//           }
//           log("Login 3 Response ___${response.body}");
//
//           // Navigator.of(context).push(
//           //     MaterialPageRoute(builder: (context) => HomeScreen(),));
//         } else {
//
//           print("Abir1");
//           showDialog(context: context, builder: (context){
//             return AlertDialog(
//
//               content: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8.0),
//                       child: Center(child: Text("Your submitted Mobile number or OTP incorrect.\nPlease try again.")),
//                     ),
//
//
//                     SizedBox(height: 10,),
//                     ElevatedButton(
//                         style: ElevatedButton.styleFrom(primary: HexColor("#f15a22"),),
//                         onPressed: (){
//
//                           Navigator.pop(context,true);
//                         }, child: Text("OK")),
//
//
//                   ],
//                 ),
//               ),
//             );
//           });
//
//
//         }
//       }else{
//         print("Abir2");
//
//       }
//       print(response.body);
//       // print("Abir3");
//       // showDialog(context: context, builder: (context){
//       //   return AlertDialog(
//       //     title: Padding(
//       //       padding: const EdgeInsets.all(8.0),
//       //       child: Center(child: Text("Error!!!")),
//       //     ),
//       //     content: SingleChildScrollView(
//       //       child: Column(
//       //         children: [],
//       //       ),
//       //     ),
//       //   );
//       // });
//
//     }on SocketException{
//       EasyLoading.dismiss();
//
//     }
//
//   }
//
// }
