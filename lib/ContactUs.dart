// ignore_for_file: file_names, unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:interactive_map/Homepages/mainPageGuest.dart';

import 'Homepages/mainPage.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
        height: double.infinity,
        color: const Color(0xFF252422),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            const Center(
                child: Text(
              "أرسل لنا رسالة بأي شيء تريد معرفته أو الاستفسار عنه، وسنعاود الاتصال بك على الفور.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Baloo', fontSize: 25),
            )),
            Form(
              key: _formKey,
              child: Column(
                children: [
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
                        fontFamily: 'Baloo',
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
                          labelText: 'الإسم',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Baloo',
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال المعلومات ';
                        }
                      },
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Baloo',
                      ),
                      controller: phoneController,
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
                          labelText: 'رقم الهاتف',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Baloo',
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        RegExp regExp = RegExp(
                          r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)",
                          caseSensitive: false,
                          multiLine: false,
                        );
                        print(regExp.hasMatch(value!));
                        if (value == null ||
                            value.isEmpty ||
                            !regExp.hasMatch(value)) {
                          return 'الرجاء إدخال المعلومات ';
                        }
                      },
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Baloo',
                      ),
                      controller: emailController,
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
                          labelText: 'البريد الإلكتروني',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Baloo',
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
                      maxLines: 4,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Baloo',
                      ),
                      controller: questionController,
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
                          labelText: 'السؤال',
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Baloo',
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                if (_formKey.currentState!.validate()) {
                  final Email email = Email(
                    body: questionController.text,
                    subject: 'Deal With Past Support',
                    recipients: ['rf09@aub.edu.lb'],
                    cc: [''],
                    bcc: [''],
                    isHTML: false,
                  );
                  await FlutterEmailSender.send(email);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WelcomePageGuest()));
                }
              },
              color: Color(0xFFFFDE73),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: const Text(
                  "إرسال",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'Baloo',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ]),
        ));
  }
}
