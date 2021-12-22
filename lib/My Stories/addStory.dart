// ignore_for_file: file_names, unused_import, library_prefixes, must_be_immutable, unused_field, prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_local_variable, avoid_function_literals_in_foreach_calls, unused_element, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors, duplicate_ignore, unnecessary_this, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interactive_map/Repos/StoryRepo.dart';
import 'package:interactive_map/Repos/UserRepo.dart';
import 'package:interactive_map/Repos/media.dart';
import 'package:interactive_map/My%20Stories/Stories.dart';
import 'package:interactive_map/Homepages/mainPage.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as locationPerm;
import 'package:flutter/cupertino.dart';
import 'package:place_picker/entities/localization_item.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:place_picker/place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Repos/UserInfo.dart';

class AddStory extends StatefulWidget {
  dynamic token;
  AddStory(this.token, {Key? key}) : super(key: key);

  @override
  _AddStory createState() => _AddStory();
}

class _AddStory extends State<AddStory> {
  Media media = Media();
  TextEditingController titleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mediatypeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController eventdateController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  locationPerm.Location location = locationPerm.Location();
  late bool _serviceEnabled;
  late locationPerm.PermissionStatus _permissionGranted;
  late locationPerm.LocationData _locationData;
  String _selectedDate = 'أدخل التاريخ';
  String _selectedDateEnglish = '';
  late LocationResult locationResult;
  final googlePlace = GooglePlace("AIzaSyB5IXP-SANsluLrgaAgmqp70kNlHeCa-ps");
  var predictions = [];
  var lng;
  var lat;
  var currentLocation;
  var allUploaded = true;
  List<Map<String, dynamic>> links = [];
  var photoLinks = [];
  dynamic featured_image_id = 1325;
  late String status = 'none';
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? d = await showDatePicker(
      context: context,
      locale: const Locale('ar', 'MA'),
      initialDate: DateTime.now(),
      firstDate: DateTime(1700),
      lastDate: DateTime(2050),
    );
    if (d != null) {
      var year = convertToArabicNumber(d.year.toString());
      var month = convertToArabicNumber(d.month.toString());
      var day = convertToArabicNumber(d.day.toString());
      String date = year + "/" + month + '/' + day;

      setState(() {
        _selectedDate = DateFormat.yMd("ar").format(d);
        _selectedDateEnglish = DateFormat.yMd("en_US").format(d);
      });
    }
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

  void locationAccess() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == locationPerm.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != locationPerm.PermissionStatus.granted) {
        return;
      }
    }
  }

  void showPlacePicker() async {
    if (_permissionGranted == locationPerm.PermissionStatus.granted) {
      locationResult = await Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) => PlacePicker(
                    "AIzaSyB5IXP-SANsluLrgaAgmqp70kNlHeCa-ps",
                    displayLocation: const LatLng(33.8938, 35.5018),
                    localizationItem: LocalizationItem(
                        languageCode: "ar_lb",
                        tapToSelectLocation: "اختر هذا المكان",
                        findingPlace: "تفتيش...",
                        nearBy: "اماكن مجاورة"),
                  )))
          .catchError((error) {});
      locationController.text = locationResult.city!.name!;

      lat = locationResult.latLng!.latitude;
      lng = locationResult.latLng!.longitude;
    }
  }

// List<dynamic>
  Future<List<dynamic>> _getResults(String loc) async {
    predictions.clear();
    final response = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$loc&location=33.8547%2C35.8623&radius=100&language=ar&types=geocode&key=AIzaSyB5IXP-SANsluLrgaAgmqp70kNlHeCa-ps'),
        headers: {"connection": "keep-alive"});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['predictions'].isNotEmpty) {
        for (int i = 0; i < data['predictions'].length; i++) {
          setState(() {
            predictions.add(data['predictions'][i]);
          });
        }
        return predictions;
      } else {
        setState(() {
          predictions.clear();
        });
      }
      return [];
    } else {
      return [];
    }
  }

  getLngLat(String refId) async {
    final response2 = await http.get(
        Uri.parse(
            'https://maps.googleapis.com/maps/api/place/details/json?placeid=$refId&key=AIzaSyB5IXP-SANsluLrgaAgmqp70kNlHeCa-ps'),
        headers: {"connection": "keep-alive"});
    if (response2.statusCode == 200) {
      var data2 = jsonDecode(response2.body);
      lng = data2['result']['geometry']['location']['lng'].toString();
      lat = data2['result']['geometry']['location']['lat'].toString();
    }
  }

  void _showErrorDate() {
    final _aboutdialog = StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
          // ignore: prefer_const_constructors
          shape: RoundedRectangleBorder(
              // ignore: prefer_const_constructors
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: const Icon(Icons.error),
          content: Container(
              height: 120,
              child: Column(children: [
                Container(child: const Text("يجب ادخال التاريخ")),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () => {Navigator.pop(context)},
                  child: const Text(
                    "إستمرار",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Bahij",
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Color(0xFFCCAF41),
                  ),
                ),
              ])));
    });
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => _aboutdialog);
  }

  void _showSuccess() {
    final _aboutdialog = StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: Icon(Icons.error),
          content: Container(
              height: 120,
              child: Column(children: [
                Container(child: Text("تم إرسال الرواية بنجاح")),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.pop(context),
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    )
                  },
                  child: Text(
                    "إستمرار",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Bahij",
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Color(0xFFCCAF41),
                  ),
                ),
              ])));
    });
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => _aboutdialog);
  }

  void _showError() {
    final _aboutdialog = StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: Icon(Icons.error),
          content: Container(
              height: 120,
              child: Column(children: [
                Container(child: Text("انتظر حتى يتم التحميل")),
                SizedBox(
                  height: 40,
                ),
                TextButton(
                  onPressed: () => {Navigator.pop(context)},
                  child: Text(
                    "إستمرار",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Bahij",
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Color(0xFFCCAF41),
                  ),
                ),
              ])));
    });
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => _aboutdialog);
  }

  void _showImages() {
    final _aboutdialog = StatefulBuilder(builder: (context, setState) {
      List<dynamic> carousel = [];
      photoLinks.forEach((element) {
        var type = element[1];
        if (type == 'image') {
          carousel.add(
            Image.network(
              element[0],
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(100),
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ));
              },
            ),
          );
        } else if (type == 'video' || type == 'audio') {
          carousel.add(WebView(
            initialUrl:
                'http://dwp.world/wp-content/uploads/2021/12/sweet-voice-1.mp3',
            javascriptMode: JavascriptMode.unrestricted,
          ));
        }
      });
      var length = convertToArabicNumber((carousel.length).toString());
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: Icon(Icons.image),
          content: Container(
              height: 350,
              width: 250,
              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: carousel.length,
                    options: CarouselOptions(
                      height: 250.0,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                    ),
                    itemBuilder: (context, itemIndex, realIndex) {
                      var i = convertToArabicNumber((itemIndex + 1).toString());
                      return Stack(children: [
                        Container(
                            width: double.infinity, child: carousel[itemIndex]),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "$i من $length",
                                  style: TextStyle(color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(color: Colors.black),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              )),
                        ),
                      ]);
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextButton(
                    onPressed: () => {Navigator.pop(context)},
                    child: const Text(
                      "إستمرار",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Bahij",
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Color(0xFFCCAF41),
                    ),
                  ),
                ],
              )));
    });
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => _aboutdialog);
  }

  @override
  void initState() {
    super.initState();

    locationAccess();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if (Platform.isIOS) WebView.platform = CupertinoWebView();
  }

  bool value = false;
  bool checkboxValue = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String fileName = '';
    List<dynamic> fileNames = [];

    Widget picPicker(
        String fileName, Function onFilePicked, Function onFilesPicked) {
      XFile? _imageFile;
      List<XFile?>? _imageFiles;
      ImagePicker _picker = ImagePicker();
      List<String?> files;

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: ElevatedButton(
                  onPressed: () async {
                    if (status == '') {
                      _showError();
                    } else {
                      _imageFile =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (_imageFile != null) {
                        setState(() {
                          status = '';
                        });
                      }
                      onFilePicked(_imageFile);
                    }
                  },
                  child: Text(
                    "الصورة الرئيسية",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFFFDE73))),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () async {
                    if (status == '') {
                      _showError();
                    } else {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                              allowMultiple: true,
                              type: FileType.custom,
                              allowedExtensions: [
                            'jpg',
                            'jpeg',
                            'webp',
                            'mp3',
                            'mp4',
                            'webm',
                            'm4a',
                            'png'
                          ]);

                      if (result != null) {
                        files = result.paths;
                        setState(() {
                          status = '';
                        });
                      } else {
                        files = [];
                      }

                      onFilesPicked(result);
                    }
                  },
                  child: Text(
                    "الإستديو",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFFFDE73))),
                ),
              ),
              // Image.file(
              //   File(
              //       '/data/user/0/lb.com.aub.dwp/cache/image_picker8991905038291509346.jpg'),
              //   width: 35,
              //   height: 35,
              // )
              // _imageFile != null
              //     ? Image.file(
              //         File(_imageFile!.path.toString()),
              //         width: 35,
              //         height: 35,
              //       )
              //     : Container()
            ],
          )
        ],
      );
    }

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: AppBar(
              title: Text("زيادة رواية"),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    if (status == '') {
                      _showError();
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                      );
                    }
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            body: Container(
              height: double.infinity,
              color: Color(0xFF252422),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: Text(
                          "املأ المعلومات",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // ignore: sized_box_for_whitespace
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال المعلومات ';
                            }
                          },
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          controller: titleController,
                          decoration: const InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelText: 'العنوان',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال المعلومات ';
                            }
                          },
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          controller: nameController,
                          decoration: const InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelText: 'الشخص المستهدف',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                      ),
                      // ignore: sized_box_for_whitespace
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال المعلومات ';
                            }
                          },
                          maxLines: 4,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          controller: descriptionController,
                          decoration: const InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelText: 'نبذة عن القصة',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال المعلومات ';
                            }
                          },
                          onTap: () {
                            // _showDialog();
                            showPlacePicker();
                          },
                          // enabled: false,
                          // enableInteractiveSelection:
                          //     false, // will disable paste operation
                          // focusNode: new AlwaysDisabledFocusNode(),
                          readOnly: true,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          controller: locationController,
                          decoration: const InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelText: 'موقع الحدث',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        // Center is a layout widget. It takes a single child and positions it
                        // in the middle of the parent.
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        width: 1.0, color: Colors.white),
                                    left: BorderSide(
                                        width: 1.0, color: Colors.white),
                                    right: BorderSide(
                                        width: 1.0, color: Colors.white),
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.white),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    InkWell(
                                      child: Text(_selectedDate,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white)),
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.calendar_today,
                                        color: Color(0xFFFFDE73),
                                      ),
                                      // tooltip: 'Tap to open date picker',
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            picPicker(fileName, (file) async {
                              setState(() {
                                fileName = file.path.toString();
                              });
                              var res = await media.uploadImage(file);

                              var content = jsonDecode(res);

                              setState(() {
                                status = content['data'] == null
                                    ? "Uploaded"
                                    : 'Failed';
                                featured_image_id = content['id'];
                                var list = [
                                  content['guid']['rendered'],
                                  'image'
                                ];
                                photoLinks.add(list);
                              });
                            }, (files) async {
                              setState(() {
                                fileNames = files.paths;
                              });
                              for (var fileName in fileNames) {
                                var res = await media.uploadAll(fileName);
                                var content = jsonDecode(res);
                                if (content['data'] != null) {
                                  if (this.mounted) {
                                    setState(() {
                                      allUploaded = false;
                                    });
                                  }
                                  break;
                                } else {
                                  var imgs = ['jpg', 'jpeg', 'png', 'webp'];
                                  var vids = ['mp4', 'webm'];
                                  var audio = ['mp3', 'm4a'];
                                  var mimeType = '';
                                  if (imgs.contains(
                                      (fileName.split('/').last.split('.')[1])
                                          .toString()
                                          .toLowerCase())) {
                                    mimeType = 'image/' +
                                        fileName.split('/').last.split('.')[1];
                                  } else if (vids.contains(
                                      (fileName.split('/').last.split('.')[1])
                                          .toString()
                                          .toLowerCase())) {
                                    mimeType = 'video/' +
                                        fileName.split('/').last.split('.')[1];
                                  } else if (audio.contains(
                                      (fileName.split('/').last.split('.')[1])
                                          .toString()
                                          .toLowerCase())) {
                                    mimeType = 'audio/' +
                                        fileName.split('/').last.split('.')[1];
                                  }
                                  Map<String, dynamic> media = {
                                    "ID": content['id'],
                                    "id": content['id'],
                                    'title': content['title']['raw'],
                                    'url': content['guid']['rendered'],
                                    'mime_type': mimeType,
                                    "description": "test",
                                  };
                                  links.add(media);
                                  var list = [
                                    content['guid']['rendered'],
                                    mimeType.split('/')[0]
                                  ];
                                  photoLinks.add(list);
                                }
                              }
                              if (allUploaded) {
                                setState(() {
                                  status = 'Uploaded';
                                });
                              } else {
                                setState(() {
                                  status = 'Failed';
                                });
                              }
                            }),
                            SizedBox(
                              height: 20,
                            ),
                            if (status == 'Uploaded')
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'تم التحميل',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 150,
                                    child: MaterialButton(
                                      minWidth: double.infinity,
                                      height: 40,
                                      onPressed: () {
                                        _showImages();
                                      },
                                      color: Color(0xFFFFDE73),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      child: const Text(
                                        "عرض الصور",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (status == 'Failed')
                              Text(
                                'فشل التحميل',
                                style: TextStyle(color: Colors.red),
                              ),
                            if (status == '') CircularProgressIndicator(),
                            if (status == 'none') Container(),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                      Center(
                        // ignore: sized_box_for_whitespace
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 150,
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  height: 40,
                                  onPressed: () async {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    if (status != '') {
                                      if (_selectedDate != 'أدخل التاريخ') {
                                        if (_formKey.currentState!.validate()) {
                                          var parsed =
                                              _selectedDateEnglish.split('/');
                                          var date = parsed[2].toString() +
                                              "-" +
                                              parsed[0].toString() +
                                              "-" +
                                              parsed[1].toString() +
                                              "T00:00:00";
                                          var dateParsed = DateTime.parse(date);
                                          String dateformat =
                                              DateFormat("yyyy-MM-ddTHH:mm:ss")
                                                  .format(dateParsed);
                                          Map<String, dynamic> data = {
                                            // 'author': userId[0].id,
                                            'title': titleController.text,
                                            'content':
                                                descriptionController.text,
                                            'fields': {
                                              'targeted_person':
                                                  nameController.text,
                                              'map_location': {
                                                'lat': lat,
                                                'lng': lng,
                                                'city': locationController.text
                                              },
                                              'event_date': dateformat,
                                              'anonymous': checkboxValue,
                                              'gallery': links,
                                            },
                                            'status': "pending",
                                            "featured_media": featured_image_id,
                                          };

                                          StoryRepo storyRepo = StoryRepo();
                                          var res = await storyRepo.postStory(
                                              data,
                                              FirebaseAuth.instance.currentUser!
                                                  .displayName,
                                              FirebaseAuth
                                                  .instance.currentUser!.uid);
                                          var content = jsonDecode(res);
                                          if (content['content'] != null) {
                                            _showSuccess();
                                          }
                                        }
                                      } else {
                                        _showErrorDate();
                                      }
                                    } else {
                                      _showError();
                                    }
                                  },
                                  color: Color(0xFFFFDE73),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  child: const Text(
                                    "إرسال",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    activeColor: Color(0xFFFFDE73),
                                    fillColor: MaterialStateProperty.all<Color>(
                                        Color(0xFFFFDE73)),
                                    checkColor: Colors.black,
                                    value: this.value,
                                    onChanged: (value) {
                                      setState(() {
                                        this.value = value!;
                                        checkboxValue = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "مجهول",
                                    style: TextStyle(color: Color(0xFFFFDE73)),
                                  )
                                ],
                              )
                            ]),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
