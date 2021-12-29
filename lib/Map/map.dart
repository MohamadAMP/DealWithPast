// ignore_for_file: unused_import, library_prefixes, prefer_typing_uninitialized_variables, await_only_futures, unnecessary_this, avoid_print, duplicate_ignore, avoid_function_literals_in_foreach_calls, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, empty_catches
//
// import 'dart:html';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as IMG;
import 'package:interactive_map/View%20Stories/StoryWidgetAll.dart';
import 'package:location/location.dart' as locationPerm;
import 'package:flutter/cupertino.dart';
import 'package:place_picker/entities/localization_item.dart';
import '../Repos/StoryClass.dart';
import '../Repos/StoryRepo.dart';
import '../Repos/UserClass.dart';
import '../Repos/UserInfo.dart';
import '../Repos/UserRepo.dart';
import '../View Stories/StoryWidgetImgOnly.dart';

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
  // late Coordinates coordinates;

  retrieveStories() async {
    try {
      token = await userRepo.Authenticate("admin", "admin_1234");
      stories = await storyrepo.getStories(token);
      // EasyLoading.showSuccess("Stories Loaded");
      mapCreated(_controller);
    } catch (e) {}
  }

  retrieveUserInfo(UserInfoRepo userInfoRepo, dynamic id) async {
    try {
      userData = await userInfoRepo.getUserInfo(id, token);
    } catch (e) {}
  }

  Future<Uint8List> getBytesFromAsset(String src, int width, int height,
      {int size = 150,
      bool addBorder = true,
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
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> _goToLoc() async {
    final GoogleMapController controller = await _controller;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(currLat, currLng), zoom: 12)));
  }

  Future<void> _goToAll() async {
    final GoogleMapController controller = await _controller;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(33.8547, 35.8623), zoom: 8.5, bearing: 10)));
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
      // ignore: avoid_function_literals_in_foreach_calls
      stories.forEach((e) async {
        allMarkers.add(Marker(
            markerId: MarkerId(e.title + " " + e.date_submitted),
            draggable: false,
            consumeTapEvents: true,
            icon: BitmapDescriptor.fromBytes(
                await getBytesFromAsset(e.featured_image, 100, 100)),
            // infoWindow: InfoWindow(title: e.title),
            position: LatLng(e.lat, e.lng),
            onTap: () {
              setState(() {
                mainStory = e;
                showPage = true;
              });
            }
            // ignore: avoid_print
            ));
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
              northeast: LatLng(33.8566324, 35.7896525),
              southwest: LatLng(33.8469738, 35.7535346))),
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
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  UserInfoRepo userInfoRepo = UserInfoRepo();
                                  await retrieveUserInfo(
                                      userInfoRepo, mainStory.author);
                                  setState(() {
                                    showPage = false;
                                  });
                                  if (mainStory.gallery == false) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StoryWidgetImgOnly(
                                                  mainStory,
                                                  mainStory.locationName,
                                                  userData[0])),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StoryWidgetAll(
                                              mainStory,
                                              mainStory.locationName,
                                              userData[0])),
                                    );
                                  }
                                },
                                child: const Text(
                                  "اقرأ المزيد",
                                  style: TextStyle(color: Color(0xFFFFDE73)),
                                ))
                          ],
                          title: Text(mainStory.title),
                          leading: IconButton(
                              onPressed: () {
                                setState(() {
                                  // print(showPage);
                                  showPage = false;
                                });
                              },
                              icon: Icon(Icons.arrow_back)),
                          centerTitle: true,
                        ),
                        body: Container(
                            color: Color(0xFF252422),
                            padding: EdgeInsets.fromLTRB(20, 60, 40, 0),
                            child: Column(children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 110,
                                      width: 110,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          mainStory.featured_image,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                    ),
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
                                                mainStory.locationName,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ]),
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Row(children: [
                                            Icon(Icons.calendar_today_rounded,
                                                color: Color(0xFFFFDE73)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              child: Text(
                                                convertToArabicNumber(mainStory
                                                    .event_date
                                                    .toString()
                                                    .split("T")
                                                    .toList()[0]
                                                    .split('-')[0]
                                                    .toString()),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ]),
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
                    child: Text("روايات قريبة")))
      ],
    ));
  }
}
