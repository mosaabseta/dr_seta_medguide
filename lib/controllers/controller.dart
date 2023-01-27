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
  TextEditingController search = TextEditingController();
  Future<GeneralDataModel> generalData = generalDatabase.getData();
  ScrollPhysics scrollPhysics = ScrollPhysics();

  @override
  void onInit() {
    super.onInit();
    getAntibiotics();
  }

  getAntibiotics() async {
    antibioticsSnapshot.bindStream(antibioticsService.getData());
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
              element.procedure.toUpperCase().contains(search.text.toUpperCase()))
          .toList();
    }
    return res;
  }
}
