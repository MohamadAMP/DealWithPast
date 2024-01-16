// ignore_for_file: file_names

import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
              child: Container(
                  color: const Color(0xFF252422),
                  height: 200,
                  width: double.infinity,
                  child: Padding(
                    child: Image.asset('assets/logo.png'),
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  ))),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                '''تم تطوير هذا التطبيق من قبل برنامج الأمم المتحدة الإنمائي والجامعة الأمريكية في بيروت بالتعاون مع محاربون من أجل السلام ة أمم للتوثيق و الأبحاث
الإنمائي وبتمويل من مكتب دعم بناء السلام''',
                style: TextStyle(
                  fontFamily: 'Baloo',
                ),
              ),
            ),
          ),
          // const Center(
          //   child: Text('Info@Dwp.World'),
          // ),
          // const Center(
          //   child: Text('00961-'),
          // ),
          const Padding(
            padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                '''\nThis application was developed by the United Nations Development Programme (UNDP) and the American University of Beirut (AUB) in collaboration with Fighters for Peace (FFP) and UMAM documentation and research with funds from the United Nations' Peacebuilding support office''',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Baloo', fontSize: 16),
              ),
            ),
          ),

          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 80,
                width: 60,
                child: Image.asset('assets/img1.png', fit: BoxFit.contain),
              ),
              Container(
                height: 80,
                width: 60,
                child: Image.asset('assets/img3.png', fit: BoxFit.contain),
              ),
              Container(
                height: 80,
                width: 60,
                child: Image.asset('assets/img2.png', fit: BoxFit.contain),
              ),
              Container(
                height: 80,
                width: 60,
                child: Image.asset('assets/img5.jpg', fit: BoxFit.contain),
              ),
              Container(
                height: 80,
                width: 60,
                child: Image.asset('assets/img4.png', fit: BoxFit.contain),
              ),
            ],
          )),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            'Copyright 2023, all rights reserved to the United Nations Development Program',
            style: TextStyle(fontFamily: 'Baloo', fontSize: 11),
          )),
          Center(
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: const Text(
                    'حقوق الطبع والنشر ٢٠٢٣, جميع الحقوق محفوظة لبرنامج الأمم المتحدة الإنمائي',
                    style: TextStyle(fontFamily: 'Baloo', fontSize: 11),
                  )))
        ],
      ),
    );
  }
}
