import 'package:dr_seta/controllers/controller.dart';
import 'package:dr_seta/helpers/constants.dart';
import 'package:dr_seta/models/general_data_model.dart';
import 'package:dr_seta/models/surgery_antibiotics_model.dart';
import 'package:dr_seta/screens/founders.dart';
import 'package:dr_seta/screens/home.dart';
import 'package:dr_seta/screens/new_guidline.dart';
import 'package:dr_seta/widgets/guildline_card.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) async {
    Get.put(Controller());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Med Guide',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Med Guide'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewGuideline()));
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: GetX<Controller>(
          init: controller,
          // initState: (_) async{},
          builder: (fetch) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          if (fetch.viewType.value == 1) {
                            fetch.viewType.value = 2;
                          } else {
                            fetch.viewType.value = 1;
                          }
                          setState(() {

                          });
                        },
                        icon: fetch.viewType.value == 1
                            ? Icon(Icons.credit_card_outlined)
                            : Icon(Icons.list)),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Founders()));
                        },
                        icon: Icon(Icons.info_rounded)),
                  ],
                )
              ],
            );
          },
        ),
      ),
      body: HomeScreen(),
    );
  }
}
