import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../helpers/constants.dart';
import '../models/general_data_model.dart';

class NewGuideline extends StatefulWidget {
  const NewGuideline({Key? key}) : super(key: key);

  @override
  State<NewGuideline> createState() => _NewGuidelineState();
}

class _NewGuidelineState extends State<NewGuideline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          Padding(
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
                                  controller.speciality.value.isEmpty
                                      ? "All Specialities"
                                      : controller.speciality.value,
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
                            controller.speciality.value = value as String;
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          buttonHeight: 40,
                          buttonWidth: MediaQuery.of(context).size.width * 6,
                          buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.white,
                            ),
                            color: Colors.white,
                          ),
                          buttonElevation: 1,
                          itemHeight: 40,
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: TextFormField(
              controller: controller.procedure,
              textAlignVertical: TextAlignVertical.center,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: '',
                labelText: 'Procedure',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("List of Drugs"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: controller.listOfDosage.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        onLongPress: () {
                          controller
                              .removeDosage(controller.listOfDosage[index]);
                          setState(() {});
                        },
                        leading: Text(
                            controller.listOfDosage[index].line.toString()),
                        title: Text(controller.listOfDosage[index].drug),
                        subtitle:
                            Text(controller.listOfDosage[index].classification),
                        trailing: Column(
                          children: [
                            Text(
                                "${controller.listOfDosage[index].amount} ${controller.listOfDosage[index].suffix}"),
                            Text(controller.listOfDosage[index].route),
                          ],
                        )),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all()),
              child: Column(
                children: [
                  Padding(
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
                                          controller.line.value.isEmpty
                                              ? "Priority"
                                              : controller.line.value,
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
                                  items: snapshot.data!.line
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
                                    controller.line.value = value as String;
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  buttonHeight: 40,
                                  buttonWidth:
                                      MediaQuery.of(context).size.width * 6,
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: TextFormField(
                      controller: controller.drug,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        hintText: '',
                        labelText: 'Drug Name',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
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
                                          controller.dosageClassification.value
                                                  .isEmpty
                                              ? "Dosage classification"
                                              : controller
                                                  .dosageClassification.value,
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
                                  items: snapshot.data!.dosageClassification
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
                                    controller.dosageClassification.value =
                                        value as String;
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  buttonHeight: 40,
                                  buttonWidth:
                                      MediaQuery.of(context).size.width * 6,
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
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                          child: TextFormField(
                            controller: controller.dosage,
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: (_) => setState(() {}),
                            decoration: const InputDecoration(
                              hintText: '',
                              labelText: 'Dosage',
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                          child: TextFormField(
                            controller: controller.suffix,
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: (_) => setState(() {}),
                            decoration: const InputDecoration(
                              hintText: '',
                              labelText: 'Suffix',
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: TextFormField(
                      controller: controller.dosageNote,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        hintText: '',
                        labelText: 'Note',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: TextFormField(
                      controller: controller.firstDosageInMinutes,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        hintText: '',
                        labelText: 'First Dosage in Minutes',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: TextFormField(
                      controller: controller.firstDosageNote,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        hintText: '',
                        labelText: 'First Dosage Note',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: TextFormField(
                      controller: controller.dosageIntervalInHours,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        hintText: '',
                        labelText: 'Dosage Interval in Hours',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: TextFormField(
                      controller: controller.route,
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        hintText: '',
                        labelText: 'Route of Administration',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        controller.addDosage();
                        setState(() {});
                      },
                      child: const Text("Add Dosage Data"))
                ],
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                //controller.save();
              },
              child: const Text("Save New Guideline"))
        ],
      ),
    );
  }
}
