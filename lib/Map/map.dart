// ignore_for_file: unused_import, library_prefixes, prefer_typing_uninitialized_variables, await_only_futures, unnecessary_this, avoid_print, duplicate_ignore, avoid_function_literals_in_foreach_calls, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, empty_catches
//
// import 'dart:html';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as IMG;
import 'package:interactive_map/My%20Stories/myStoriesTile.dart';
import 'package:interactive_map/View%20Stories/StoryWidgetAll.dart';
import 'package:interactive_map/View%20Stories/LoadUser.dart';
import 'package:location/location.dart' as locationPerm;
import 'package:flutter/cupertino.dart';
import 'package:place_picker/entities/localization_item.dart';
import '../Repos/StoryClass.dart';
import '../Repos/StoryRepo.dart';
import '../Repos/UserClass.dart';
import '../Repos/UserInfo.dart';
import '../Repos/UserRepo.dart';
import '../View Stories/StoryWidgetImgOnly.dart';
import "package:collection/collection.dart";

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPage createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  StoryRepo storyrepo = StoryRepo();
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(33.8547, 35.8623), zoom: 8.5, bearing: 10);
  late GoogleMapController _controller;
  List<Story> stories = [];
  List<UserData> userData = [];
  List<Marker> allMarkers = [];
  late BitmapDescriptor pinIcon;
  // ignore: non_constant_identifier_names
  bool Loaded = false;
  bool showPage = false;
  bool showPageGrouped = false;
  bool nearMe = false;
  dynamic location;
  late Story mainStory;
  late dynamic placemarks;
  late dynamic image;
  dynamic currLng = 0;
  dynamic currLat = 0;
  UserRepo userRepo = UserRepo();
  var token;
  locationPerm.Location locationAcc = locationPerm.Location();
  late bool _serviceEnabled;
  late locationPerm.PermissionStatus _permissionGranted;
  late locationPerm.LocationData _locationData;
  List<dynamic> groupedStories = [];
  List<dynamic> groupedMain = [];

  retrieveStories() async {
    try {
      token = await userRepo.Authenticate("admin", "admin_1234");
      stories = await storyrepo.getStories(token);
      var newMap = groupBy(stories, (Story s) => s.locationName);
      for (var i = 0; i < newMap.length; i++) {
        groupedStories.add(newMap.values.elementAt(i));
      }
      mapCreated(_controller);
    } catch (e) {}
  }

  Future<Uint8List> getBytesFromCanvas(
      String src, Size size, int length) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    final Paint tagPaint = Paint()..color = Colors.blue;
    final double tagWidth = 60.0;

    final Paint shadowPaint = Paint()..color = Colors.blue.withAlpha(100);
    final double shadowWidth = 15.0;

    final Paint borderPaint = Paint()..color = Colors.black;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(shadowWidth, shadowWidth,
              size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    // Add tag circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(size.width - tagWidth, 0.0, tagWidth, tagWidth),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        tagPaint);

    // Add tag text
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: convertToArabicNumber(length.toString()),
      style:
          TextStyle(fontSize: 60.0, color: Colors.white, fontFamily: 'Baloo'),
    );

    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(size.width - tagWidth / 2 - textPainter.width / 2,
            tagWidth / 2 - textPainter.height / 2));

    // Oval for the image
    Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
        size.width - (imageOffset * 2), size.height - (imageOffset * 2));

    // Add path for oval image
    canvas.clipPath(Path()..addOval(oval));

    // Add image
    final Uint8List imageUint8List =
        await (await NetworkAssetBundle(Uri.parse(src)).load(src))
            .buffer
            .asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(imageUint8List);
    final ui.FrameInfo imageFI = await codec.getNextFrame();
    paintImage(
        canvas: canvas, image: imageFI.image, rect: oval, fit: BoxFit.fitWidth);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(size.width - tagWidth, 0.0, tagWidth, tagWidth),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        tagPaint);
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(size.width - tagWidth / 2 - textPainter.width / 2,
            tagWidth / 2 - textPainter.height / 2));
    // Convert canvas to image
    final ui.Image _image = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());

    final rdata = await _image.toByteData(format: ui.ImageByteFormat.png);
    // Convert image to bytes
    if (this.mounted) {
      setState(() {});
    }

    return rdata!.buffer.asUint8List();
  }

  Future<Uint8List> getBytesFromAsset(
      String src, int width, int height, int size,
      {bool addBorder = true,
      Color borderColor = Colors.black,
      double borderSize = 12,
      Color titleColor = Colors.white,
      Color titleBackgroundColor = Colors.black}) async {
    //Start
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color;
    final double radius = size / 2;
    final Path clipPath = Path();
    clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
        const Radius.circular(100)));
    canvas.clipPath(clipPath);

    final Uint8List imageUint8List =
        await (await NetworkAssetBundle(Uri.parse(src)).load(src))
            .buffer
            .asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(imageUint8List);
    final ui.FrameInfo imageFI = await codec.getNextFrame();
    paintImage(
        canvas: canvas,
        rect: Rect.fromCircle(
          center: Offset(radius, radius),
          radius: radius,
        ),
        image: imageFI.image,
        fit: BoxFit.cover);

    if (addBorder) {
      //draw Border
      paint.color = borderColor;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = borderSize;
      canvas.drawCircle(Offset(radius, radius), radius, paint);
    }
    final _image = await pictureRecorder
        .endRecording()
        .toImage(size, (size * 1.1).toInt());
    final rdata = await _image.toByteData(format: ui.ImageByteFormat.png);
    //End

    if (this.mounted) {
      setState(() {});
    }
    // EasyLoading.showSuccess("Stories Loaded");
    return rdata!.buffer.asUint8List();
  }

  locationAccess() async {
    _serviceEnabled = await locationAcc.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationAcc.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await locationAcc.hasPermission();
    if (_permissionGranted == locationPerm.PermissionStatus.denied) {
      _permissionGranted = await locationAcc.requestPermission();
      if (_permissionGranted != locationPerm.PermissionStatus.granted) {
        return;
      }
    }
    var currLoc = await locationAcc.getLocation();
    setState(() {
      currLat = currLoc.latitude;
      currLng = currLoc.longitude;
    });
  }

  @override
  initState() {
    super.initState();

    retrieveStories();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller.setMapStyle("[]");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> _goToLoc() async {
    // final GoogleMapController controller = await _controller;
    _controller.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(currLat, currLng), 12));
  }

  Future<void> _goToAll() async {
    // final GoogleMapController controller = await _controller;
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(33.8547, 35.8623), zoom: 8.5, bearing: 10)));
  }

  void mapCreated(controller) {
    double doubleSize =
        (0.12186629526462396 * MediaQuery.of(context).size.height);

    var sizeIMG = (doubleSize / 1.25).toInt();
    double doubleSizeAll =
        (0.2193593314763231 * MediaQuery.of(context).size.height);
    var sizeAll = (doubleSizeAll / 1.25).toInt();
    int sizeAssets =
        ((0.18279944289693595 * MediaQuery.of(context).size.height) / 1.25)
            .toInt();
    setState(() {
      _controller = controller;
      // ignore: avoid_function_literals_in_foreach_calls
      groupedStories.forEach((storyElem) async {
        if (storyElem.length == 1) {
          Story e = storyElem[0];
          allMarkers.add(Marker(
              markerId: MarkerId(e.title + " " + e.date_submitted),
              draggable: false,
              consumeTapEvents: true,
              icon: BitmapDescriptor.fromBytes(await getBytesFromAsset(
                  e.featured_image, sizeIMG, sizeIMG, sizeAssets)),
              // infoWindow: InfoWindow(title: e.title),
              position: LatLng(e.lat, e.lng),
              onTap: () {
                setState(() {
                  showPageGrouped = false;
                  showPage = false;
                  mainStory = e;
                  showPage = true;
                });
              }
              // ignore: avoid_print
              ));
        } else {
          var mains = [];
          storyElem.forEach((e) async {
            mains.add(e);
          });
          allMarkers.add(Marker(
              markerId: MarkerId(
                  storyElem[0].title + " " + storyElem[0].date_submitted),
              draggable: false,
              consumeTapEvents: true,
              icon: BitmapDescriptor.fromBytes(await getBytesFromCanvas(
                  storyElem[0].featured_image,
                  ui.Size(sizeAll.toDouble(), sizeAll.toDouble()),
                  storyElem.length)),
              position: LatLng(storyElem[0].lat, storyElem[0].lng),
              onTap: () {
                setState(() {
                  showPageGrouped = false;
                  showPage = false;
                  groupedMain = mains;
                  showPageGrouped = true;
                });
              }
              // ignore: avoid_print
              ));
        }
      });
    });
  }

  String convertToArabicNumber(String number) {
    String res = '';

    final arabics = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    number.characters.forEach((element) {
      res += arabics[int.parse(element)];
    });

/*   final latins = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']; */
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          minMaxZoomPreference: MinMaxZoomPreference(8.5, 20),
          cameraTargetBounds: CameraTargetBounds(LatLngBounds(
              northeast: LatLng(34.6566324, 36.6896525),
              southwest: LatLng(33.0569738, 35.0935346))),
          initialCameraPosition: _initialCameraPosition,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          // zoomGesturesEnabled: false,
          compassEnabled: false,
          // scrollGesturesEnabled: false,
          rotateGesturesEnabled: false,
          markers: Set.from(allMarkers),

          onMapCreated: mapCreated,
        ),
        showPage
            ? Container(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                    height: 300,
                    child: Scaffold(
                        appBar: AppBar(
                          backgroundColor: Color(0xFFFFDE73),
                          title: Text(
                            mainStory.title,
                            style: TextStyle(
                                fontFamily: 'Baloo', color: Colors.black),
                          ),
                          leading: IconButton(
                              onPressed: () {
                                setState(() {
                                  // print(showPage);
                                  showPage = false;
                                });
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              )),
                          centerTitle: true,
                        ),
                        body: Container(
                            color: Color(0xFF252422),
                            padding: EdgeInsets.fromLTRB(20, 60, 30, 0),
                            child: Column(children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 130,
                                      width: 130,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          mainStory.featured_image,
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: 20,
                                    // ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            Icon(Icons.location_pin,
                                                color: Color(0xFFFFDE73)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: 130,
                                              child: Text(
                                                mainStory.locationName
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontFamily: 'Baloo'),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ]),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(children: [
                                            Icon(Icons.calendar_today_rounded,
                                                color: Color(0xFFFFDE73)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              child: Text(
                                                mainStory.event_date == ''
                                                    ? ""
                                                    : convertToArabicNumber(
                                                        mainStory.event_date
                                                            .toString()
                                                            .split("/")[0]
                                                            .toString()),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontFamily: 'Baloo'),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ]),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              width: 120,
                                              child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Color(
                                                                  0xFF2F69BC))),
                                                  onPressed: () async {
                                                    setState(() {
                                                      showPage = false;
                                                    });
                                                    if (mainStory.gallery ==
                                                        false) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ViewStoryStart(
                                                                    mainStory
                                                                        .author,
                                                                    false,
                                                                    mainStory,
                                                                    mainStory
                                                                        .locationName,
                                                                    false)),
                                                      );
                                                    } else {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ViewStoryStart(
                                                                    mainStory
                                                                        .author,
                                                                    true,
                                                                    mainStory,
                                                                    mainStory
                                                                        .locationName,
                                                                    false)),
                                                      );
                                                    }
                                                  },
                                                  child: const Text(
                                                    "اقرأ المزيد",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Baloo'),
                                                  )))
                                        ])
                                  ]),
                            ]))))
              ]))
            : Container(),
        nearMe
            ? Container(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _goToAll();
                        nearMe = false;
                      });
                    },
                    child: Text("كل الروايات")))
            : Container(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () async {
                      if (currLat == 0) {
                        await locationAccess();
                      }
                      setState(() {
                        _goToLoc();
                        nearMe = true;
                      });
                    },
                    child: Text("روايات قريبة"))),
        showPageGrouped
            ? Container(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                    height: 300,
                    child: Scaffold(
                        appBar: AppBar(
                          backgroundColor: Color(0xFFFFDE73),
                          title: Text(
                              'روايات في: ' +
                                  groupedMain[0].locationName.toString(),
                              style: TextStyle(
                                  fontFamily: 'Baloo', color: Colors.black)),
                          leading: IconButton(
                              onPressed: () {
                                setState(() {
                                  // print(showPage);
                                  showPageGrouped = false;
                                });
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              )),
                          centerTitle: true,
                        ),
                        body: Container(
                            color: Color(0xFF252422),
                            // padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                            child: ListView.builder(
                                // shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: groupedMain.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return StoryTile(
                                      groupedMain[index], token, false);
                                }))))
              ]))
            : Container(),
      ],
    ));
  }
}
