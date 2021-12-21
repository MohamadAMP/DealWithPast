// // ignore_for_file: file_names

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:interactive_map/mainPage.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'Repos/StoryClass.dart';
// import 'Repos/UserClass.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class StoryWidgetVideo extends StatefulWidget {
//   Story story;
//   dynamic location;
//   UserData userData;
//   StoryWidgetVideo(this.story, this.location, this.userData, {Key? key})
//       : super(key: key);

//   @override
//   _StoryWidgetVideoState createState() => _StoryWidgetVideoState();
// }

// class _StoryWidgetVideoState extends State<StoryWidgetVideo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         backgroundColor: Color(0xFF252422),
//         title: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//           child: Container(
//             child: Row(children: [
//               Expanded(
//                 child: Container(
//                   child: Row(
//                     children: [
//                       Container(
//                         height: 40,
//                         width: 40,
//                         child: CircleAvatar(
//                           backgroundImage: NetworkImage(
//                             widget.userData.image,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 30,
//                       ),
//                       Column(
//                         children: [
//                           Text(
//                             widget.userData.name,
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Text(
//                             widget.story.date_submitted
//                                     .split("T")[0]
//                                     .split("-")[2] +
//                                 "-" +
//                                 widget.story.date_submitted
//                                     .split("T")[0]
//                                     .split("-")[1] +
//                                 "-" +
//                                 widget.story.date_submitted
//                                     .split("T")[0]
//                                     .split("-")[0],
//                             style: TextStyle(fontSize: 16),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//         ),
//       ),
//       body: Body(widget.story, widget.location, widget.userData),
//     );
//   }
// }

// class Body extends StatefulWidget {
//   Story story;
//   dynamic location;
//   UserData userData;
//   Body(this.story, this.location, this.userData, {Key? key}) : super(key: key);

//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   String removeAllHtmlTags(String htmlText) {
//     return htmlText.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     if (Platform.isAndroid) WebView.platform = AndroidWebView();
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isLoading = true;
//     var videoUrl = widget.story.video
//         .toString()
//         .split(" ")[4]
//         .split('="')[1]
//         .split('"')[0]
//         .toString();
//     var carousel = [
//       Image.network(
//         widget.story.featured_image,
//         fit: BoxFit.cover,
//         loadingBuilder: (BuildContext context, Widget child,
//             ImageChunkEvent? loadingProgress) {
//           if (loadingProgress == null) {
//             return child;
//           }
//           return Center(
//               child: Padding(
//             padding: const EdgeInsets.all(100),
//             child: CircularProgressIndicator(
//               value: loadingProgress.expectedTotalBytes != null
//                   ? loadingProgress.cumulativeBytesLoaded /
//                       loadingProgress.expectedTotalBytes!
//                   : null,
//             ),
//           ));
//         },
//       ),
//       WebView(
//         initialUrl: videoUrl,
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     ];
//     dynamic desc = removeAllHtmlTags(widget.story.description);
//     // int currentPos = 0;
//     // Widget buildIndicator() => AnimatedSmoothIndicator(
//     //       activeIndex: currentPos,
//     //       count: carousel.length,
//     //       effect: SlideEffect(
//     //           dotHeight: 10,
//     //           dotWidth: 10,
//     //           activeDotColor: Colors.red,
//     //           dotColor: Colors.black),
//     //     );
//     List<dynamic> myList = [
//       Column(children: [
//         CarouselSlider.builder(
//           itemCount: carousel.length,
//           options: CarouselOptions(
//             height: 250.0,
//             viewportFraction: 1,
//             enableInfiniteScroll: false,
//             // onPageChanged: (index, reason) {
//             //   // setState(() {
//             //   //   currentPos = index;
//             //   //   print(currentPos);
//             //   // });
//             // }
//           ),
//           itemBuilder: (context, itemIndex, realIndex) {
//             var i = itemIndex + 1;
//             return Stack(children: [
//               Container(width: double.infinity, child: carousel[itemIndex]),
//               Padding(
//                   padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                       "$i of 2",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.black,
//                         border: Border.all(color: Colors.black),
//                         borderRadius: BorderRadius.all(Radius.circular(10))),
//                   ))
//             ]);
//           },
//         ),
//       ]),
//       Column(
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//             child: Column(
//               children: [
//                 Container(
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.location_pin,
//                         color: Color(0xFFFFDE73),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         widget.location,
//                         style:
//                             const TextStyle(fontSize: 20, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 Container(
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.person,
//                         color: Color(0xFFFFDE73),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         widget.story.title,
//                         style:
//                             const TextStyle(fontSize: 20, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 Container(
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.calendar_today_rounded,
//                         color: Color(0xFFFFDE73),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         widget.story.event_date,
//                         style:
//                             const TextStyle(fontSize: 20, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 Container(
//                   child: Directionality(
//                     child: Text(
//                       desc,
//                       style: const TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                     textDirection: TextDirection.rtl,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 )
//               ],
//             ),
//           )
//         ],
//       )
//     ];
//     // ignore: avoid_unnecessary_containers
//     return Container(
//         color: Color(0xFF252422),
//         child: ListView.builder(
//             scrollDirection: Axis.vertical,
//             shrinkWrap: true,
//             // physics: const NeverScrollableScrollPhysics(),
//             itemCount: myList.length,
//             itemBuilder: (BuildContext context, int index) {
//               return myList[index];
//             }));
//   }
// }
