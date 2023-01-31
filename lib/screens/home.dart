import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

import '../controllers/controller.dart';
import '../helpers/constants.dart';
import '../models/general_data_model.dart';
import '../models/surgery_antibiotics_model.dart';
import '../widgets/guideline_list.dart';
import '../widgets/guildline_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetX<Controller>(
      init: controller,
      builder: ((fetch) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    // flex: 2,
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
                                        size: 20,
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
                                            fontSize: 16,
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
                                                fontSize: 20,
                                                // fontWeight: FontWeight.bold,
                                                // color: Colors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) async {
                                    fetch.speciality.value = value as String;
                                    fetch.search.text = "";
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  // buttonHeight: 40,
                                  // buttonWidth:
                                  //     MediaQuery.of(context).size.width * 6,
                                  // buttonPadding: const EdgeInsets.only(
                                  //     left: 14, right: 14),
                                  buttonDecoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    color: Colors.white,
                                  ),
                                  buttonElevation: 1,
                                  itemHeight: 40,
                                  // itemPadding: const EdgeInsets.only(
                                  //     left: 14, right: 14),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  dropdownElevation: 8,
                                  scrollbarRadius: const Radius.circular(20),
                                  scrollbarThickness: 10,
                                  scrollbarAlwaysShow: true,
                                ),
                              );
                              break;
                            default:
                              return Container();
                          }
                        }),
                  ),
                ],
              ),
              TextFormField(
                controller: fetch.search,
                textAlignVertical: TextAlignVertical.center,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: 'Search',
                  labelText: 'Search',
                  // enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: FutureBuilder<List<SurgeryAntibioticsModel>>(
                    future: fetch.filterGuidlines(fetch.surgeryAntibiotics),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const Center(
                            child: Text("chenck your internet connection"),
                          );
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.active:
                          return Container();
                        case ConnectionState.done:
                          return snapshot.data!.isEmpty
                              ? const Center(child: Text("no data available"))
                              : ListView.builder(
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return fetch.viewType.value == 1
                                        ? GuidelineCard(
                                            data: snapshot.data![index])
                                        : GuidelineList(
                                            data: snapshot.data![index]);
                                  });
                      }
                    }),
              ),
            ],
          ),
        );
      }),
    );
  }
}
