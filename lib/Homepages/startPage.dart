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
                '''خارطة وذاكرة

تطبيق إلكتروني طورته الجامعة الأميركية في بيروت، دائرة التاريخ وعلم الآثار بالتعاون مع جمعية محاربون من أجل السلام ومركز أمم للتوثيق والأبحاث، يضم مجموعة من المقابلات والروايات والصور، مع عدد من الأشخاص الذين عاشوا الحرب الأهلية اللبنانية ١٩٧٥-١٩٩٠ من مختلف الاتجاهات السياسية والمناطقية والجندرية.

يضم التطبيق نحو خمسين رواية جمعها وسجلها فريق العمل خلال أكثر من سنة، وتشكل الخميرة الأولية، ومثال من أجل الدفع بمستخدمي التطبيق لمشاركة روايتهم الخاصة من أجل نشر ثقافة الحوار وصناعة السلام.

هذا التطبيق متاح للناس لاستخدام وإضافة قصصهم المتعلقة بالحرب الأهلية. كل ما عليك فعله هو الذهاب إلى "أضف رواية" وملء النموذج. بمجرد الموافقة على القصة ، سيتم نشرها على موقع الويب وتطبيق الهاتف المحمول
''',
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
                '''\nThis was developed with the support of UNDP and PBSO.
 The stories and interviews and other information mentioned in this platform do not necessarily reflect the views of the UNDP and the donor. The content of the stories is the sole responsibility of the interviewees
''',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Baloo', fontSize: 16),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                '''تم تطوير هذا بدعم من برنامج الأمم المتحدة الإنمائي ومكتب دعم بناء السلام.
القصص والمقابلات والمعلومات الأخرى المذكورة في هذه المنصة لا تعكس بالضرورة وجهات نظر برنامج الأمم المتحدة الإنمائي والجهة المانحة. محتوى القصص هي مسؤولية الأشخاص الذين تمت مقابلتهم. ''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Baloo',
                ),
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
                child: Image.asset('assets/img5.jpg', fit: BoxFit.contain),
              ),
              Container(
                height: 80,
                width: 60,
                child: Image.asset('assets/img4.png', fit: BoxFit.contain),
              ),
              Container(
                height: 80,
                width: 60,
                child: Image.asset(
                  'assets/img3.png',
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                height: 80,
                width: 60,
                child: Image.asset('assets/img2.png', fit: BoxFit.contain),
              ),
              Container(
                height: 80,
                width: 60,
                child: Image.asset('assets/img1.png', fit: BoxFit.contain),
              ),
            ],
          )),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            'Copyright 2022, all rights reserved to the United Nations Development Program',
            style: TextStyle(fontFamily: 'Baloo', fontSize: 11),
          )),
          Center(
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: const Text(
                    'حقوق الطبع والنشر ٢٠٢٢, جميع الحقوق محفوظة لبرنامج الأمم المتحدة الإنمائي',
                    style: TextStyle(fontFamily: 'Baloo', fontSize: 11),
                  )))
        ],
      ),
    );
  }
}
