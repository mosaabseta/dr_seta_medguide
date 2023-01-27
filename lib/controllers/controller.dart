import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_seta/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/general_data_model.dart';
import '../models/surgery_antibiotics_model.dart';

class Controller extends GetxController {
  static Controller instance = Get.find();
  Rx<List<SurgeryAntibioticsModel>> antibioticsSnapshot =
      Rx<List<SurgeryAntibioticsModel>>([]);

  List<SurgeryAntibioticsModel> get surgeryAntibiotics =>
      antibioticsSnapshot.value;
  RxString speciality = "Cardiac".obs;
  RxString dosageClassification = "".obs;
  RxString line = "".obs;
  TextEditingController search = TextEditingController();
  TextEditingController procedure = TextEditingController();
  TextEditingController drug = TextEditingController();
  TextEditingController route = TextEditingController();
  TextEditingController dosage = TextEditingController();
  TextEditingController dosageIntervalInHours = TextEditingController();
  TextEditingController dosageNote = TextEditingController();
  TextEditingController firstDosageInMinutes = TextEditingController();
  TextEditingController firstDosageNote = TextEditingController();
  TextEditingController suffix = TextEditingController();
  Future<GeneralDataModel> generalData = generalDatabase.getData();
  ScrollPhysics scrollPhysics = ScrollPhysics();
  List<Map<String, dynamic>> dosageList = [];
  List<Dosage> listOfDosage = [];
  RxInt viewType = 1.obs;

  @override
  void onInit() {
    super.onInit();
    getAntibiotics();
  }

  getAntibiotics() async {
    antibioticsSnapshot.bindStream(antibioticsService.getData());
  }

  addDosage() async {
    Map<String, dynamic> dosageData = {
      "classification": dosageClassification.value,
      "amount": dosage.text,
      "first_dosage_comment": firstDosageNote.text,
      "suffix": suffix.text,
      "route": route.text,
      "drug": drug.text,
      "line": line.value,
      "comment": dosageNote.text,
      "time_of_redosing_in_minutes":
          (int.parse(dosageIntervalInHours.text) * 60),
      "time_of_first_dose_in_minutes": int.parse(firstDosageInMinutes.text)
    };
    dosageList.add(dosageData);
    listOfDosage = Dosage.fromSnapshot(dosageList);
  }
  removeDosage(Dosage dosageDataForRemove) async {
    Map<String,dynamic> data = Dosage.toSingelMap(dosageDataForRemove);
print(data);
    dosageList.remove(data);

    listOfDosage = Dosage.fromSnapshot(dosageList);
  }

  save() async {
    try {
      List<Map<String, dynamic>> data =
          SurgeryAntibioticsModel.toMap(surgeryAntibiotics);
      Map<String, dynamic> newGuideline = {
        "speciality": speciality.value,
        "procedure": procedure.text,
        "time": Timestamp.now(),
        "dicipline": "Surgery",
        "dosage": dosageList
      };
      data.add(newGuideline);

      await firebaseFirestore
          .collection(collection.antibioticsCollection())
          .doc("surgery")
          .set({"antibiotics": data}, SetOptions(merge: true));
    } catch (e) {
      Get.snackbar("error", "invalid data");
    }
  }

  Future<List<SurgeryAntibioticsModel>> filterGuidlines(
      List<SurgeryAntibioticsModel> data) async {
    List<SurgeryAntibioticsModel> res = [];
    if (search.text.isEmpty) {
      res = data
          .where((element) => element.speciality == speciality.value)
          .toList();
    } else {
      res = data
          .where((element) =>
              element.speciality == speciality.value &&
              element.procedure
                  .toUpperCase()
                  .contains(search.text.toUpperCase()))
          .toList();
    }
    return res;
  }
}
