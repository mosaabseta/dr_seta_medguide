import 'package:dr_seta/helpers/constants.dart';

import '../models/general_data_model.dart';

class GeneralDatabase {
  static GeneralDatabase instance = GeneralDatabase();

  Future<GeneralDataModel> getData() async {
   late GeneralDataModel generalDataModel ;
    await firebaseFirestore.collection(collection.generalDataCollection()).doc(
        "general_data").get().then((value) {
     generalDataModel= GeneralDataModel.fromSnapshot(value);
    });
    return generalDataModel;
  }
}