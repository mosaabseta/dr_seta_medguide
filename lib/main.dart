import 'package:dr_seta/controllers/controller.dart';
import 'package:dr_seta/helpers/constants.dart';
import 'package:dr_seta/models/general_data_model.dart';
import 'package:dr_seta/models/surgery_antibiotics_model.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text(widget.title),
      ),
      body: GetX<Controller>(
        init: controller,
        builder: ((fetch) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FutureBuilder<GeneralDataModel>(
                          future: controller.generalData,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.done:
                                return DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: [
                                        const Icon(
                                          Icons.list,
                                          size: 16,
                                          // color: lightColorScheme.outline,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            fetch.speciality.value.isEmpty
                                                ? "All Specialities"
                                                : fetch.speciality.value,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              // fontWeight: FontWeight.bold,
                                              // color: lightColorScheme.outline,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: snapshot.data!.speciality
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  // fontWeight: FontWeight.bold,
                                                  // color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) async {
                                      fetch.speciality.value = value as String;
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                    ),
                                    iconSize: 14,
                                    buttonHeight: 40,
                                    buttonWidth: MediaQuery.of(context).size.width*6,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      color: Colors.white,
                                    ),
                                    buttonElevation: 1,
                                    itemHeight: 40,
                                    itemPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    dropdownElevation: 8,
                                    scrollbarRadius: const Radius.circular(40),
                                    scrollbarThickness: 6,
                                    scrollbarAlwaysShow: true,
                                  ),
                                );
                                break;
                              default:
                                return Container();
                            }
                          }),
                    ),
                  ),

                ],
              ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                child: TextFormField(
                  controller: fetch.search,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (_) => setState(() {}),

                  decoration: const InputDecoration(
                    hintText: 'Search',
                    labelText: 'Search',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              FutureBuilder<List<SurgeryAntibioticsModel>>(
                  future: fetch.filterGuidlines(fetch.surgeryAntibiotics),
                  builder: (context, snapshot) {
                    switch(snapshot.connectionState) {

                      case ConnectionState.none:
                        return Center(child: Text("chenck your internet connection"),);
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator(),);
                      case ConnectionState.active:
                        return  Container();
                      case ConnectionState.done:
                        return   snapshot.data!.isEmpty?Center(child: Text("no data available")):
                          ListView.builder(
                            physics: fetch.scrollPhysics,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return GuidelineCard(data: snapshot.data![index]);
                            });}
                  }
              ),
            ],
          );
        }),
      ),
    );
  }
}
