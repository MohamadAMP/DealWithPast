// // ignore_for_file: file_names, unused_import, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, unnecessary_this, prefer_const_constructors, avoid_unnecessary_containers, duplicate_ignore

// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:interactive_map/Backend/auth.dart';
// import 'package:interactive_map/Homepages/mainPageAppleSignIn.dart';
// import 'package:interactive_map/Repos/UserRepo.dart';
// import 'package:interactive_map/Repos/media.dart';
// import 'package:interactive_map/Homepages/mainPage.dart';
// import 'package:interactive_map/Homepages/mainPageGuest.dart';
// import 'package:interactive_map/Map/map.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:url_launcher/url_launcher.dart';

// class AddStoryGuest extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Body(),
//     );
//   }
// }

// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   UserRepo userRepo = UserRepo();
//   Media media = Media();
//   var agreed = false;

//   late var token;

//   @override
//   void initState() {
//     super.initState();
//   }

//   posting(dynamic user) async {
//     if (await userRepo.AuthenticateOther(
//             user!.email.toString().split('@')[0], user.uid) ==
//         false) {
//       return false;
//     } else {
//       Navigator.pop(context);
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => WelcomePage(),
//           ));
//       return true;
//     }
//   }

//   void _sending(dynamic user) {
//     final _aboutdialog = StatefulBuilder(builder: (context, setState) {
//       return AlertDialog(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10))),
//           title: Center(child: Text('تسجيل الدخول')),
//           // ignore: sized_box_for_whitespace
//           content: Container(
//               height: 380,
//               child: FutureBuilder(
//                   future: posting(user),
//                   builder: (context, AsyncSnapshot snapshot) {
//                     if (!snapshot.hasData) {
//                       return const Scaffold(
//                           backgroundColor: Colors.white,
//                           body: Center(
//                               child: CircularProgressIndicator(
//                             color: Colors.black,
//                           )));
//                     } else {
//                       if (snapshot.data) {
//                         return Container();
//                       } else {
//                         return Container(
//                             height: 380,
//                             child: SingleChildScrollView(
//                                 child: Column(children: [
//                               Container(
//                                   child: Directionality(
//                                 textDirection: TextDirection.ltr,
//                                 child: Text(
//                                   'The stories and interviews and other information mentioned in this platform do not necessarily reflect the views of the UNDP and the donor. The content of the stories is the sole responsibility of the interviewees.',
//                                   style: TextStyle(fontSize: 15),
//                                 ),
//                               )),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Container(
//                                   child: Directionality(
//                                 textDirection: TextDirection.rtl,
//                                 child: Text(
//                                     'القصص والمقابلات والمعلومات الأخرى المذكورة في هذه المنصة لا تعكس بالضرورة وجهات نظر برنامج الأمم المتحدة الإنمائي والجهة المانحة. محتوى القصص هي مسؤولية الأشخاص الذين تمت مقابلتهم.',
//                                     style: TextStyle(fontSize: 15)),
//                               )),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Divider(
//                                 color: Colors.black,
//                                 thickness: 2,
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Container(
//                                 child: Center(
//                                     child: Text(
//                                   "عليك الموافقة على الشروط قبل الدخول إلى حسابك",
//                                   style: TextStyle(fontSize: 15),
//                                 )),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Container(
//                                 child: RichText(
//                                   text: TextSpan(
//                                     children: [
//                                       TextSpan(
//                                         text: 'لقراءة الشروط',
//                                         style: TextStyle(
//                                             color: Colors.black, fontSize: 15),
//                                       ),
//                                       TextSpan(
//                                         text: ' اضغط هنا',
//                                         style: TextStyle(
//                                             color: Colors.blue,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.bold),
//                                         recognizer: TapGestureRecognizer()
//                                           ..onTap = () {
//                                             launch(
//                                                 'https://dwp.world/terms-and-conditions/');
//                                           },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   TextButton(
//                                     onPressed: () async => {
//                                       token = await userRepo.Authenticate(
//                                           "admin", "admin_1234"),
//                                       await userRepo.Login(
//                                           FirebaseAuth
//                                               .instance.currentUser!.uid,
//                                           FirebaseAuth
//                                               .instance.currentUser!.email
//                                               .toString(),
//                                           FirebaseAuth
//                                               .instance.currentUser!.email
//                                               .toString()
//                                               .split('@')[0],
//                                           token),
//                                       Navigator.pop(context),
//                                       Navigator.pushReplacement(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => WelcomePage(),
//                                           ))
//                                     },
//                                     child: Text(
//                                       "قبول الشروط",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     style: TextButton.styleFrom(
//                                       primary: Colors.black,
//                                       backgroundColor: Color(0xFFCCAF41),
//                                     ),
//                                   ),
//                                   TextButton(
//                                     onPressed: () async => {
//                                       await signOut(),
//                                       Navigator.pop(context)
//                                     },
//                                     child: Text(
//                                       "عدم قبول الشروط",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     style: TextButton.styleFrom(
//                                       primary: Colors.black,
//                                       backgroundColor: Color(0xFFCCAF41),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ])));
//                       }
//                     }
//                   })));
//     });
//     showDialog(
//         barrierDismissible: true,
//         context: context,
//         builder: (context) => _aboutdialog);
//   }

//   Future<void> click() async {
//     signInWithGoogle().then((user) async => {
//           _sending(user),
//         });
//   }

//   Widget loginButton() {
//     // ignore: deprecated_member_use
//     return OutlineButton(
//         onPressed: this.click,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         splashColor: Colors.grey[600],
//         borderSide: BorderSide(color: Colors.grey),
//         child: Container(
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: const <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(left: 10),
//                   child: Text(
//                     'سجل مع Google',
//                     style: TextStyle(color: Colors.grey, fontSize: 25),
//                   ),
//                 ),
//                 Image(image: AssetImage('assets/google_logo.png'), height: 35),
//               ],
//             ),
//           ),
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Color(0xFF252422),
//         child: Center(
//             child: SingleChildScrollView(
//                 child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(height: 40),
//             Center(
//               child: Text(
//                 "لإضافة رواية عليك الدخول إلى حسابك الشخصي",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.white, fontSize: 40),
//               ),
//             ),
//             SizedBox(height: 100),
//             Container(child: loginButton()),
//             SizedBox(
//               height: 20,
//             ),
//             Platform.isIOS
//                 ? Container(
//                     height: 60,
//                     width: 250,
//                     child: SignInWithAppleButton(
//                       text: 'سجل مع Apple',
//                       style: SignInWithAppleButtonStyle.black,
//                       borderRadius: BorderRadius.circular(15),
//                       onPressed: () async {
//                         final credential =
//                             await SignInWithApple.getAppleIDCredential(
//                           scopes: [
//                             AppleIDAuthorizationScopes.email,
//                             AppleIDAuthorizationScopes.fullName,
//                           ],
//                         );

//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => WelcomePageApple(),
//                             ));
//                       },
//                     ))
//                 : Container()
//           ],
//         ))));
//   }
// }
