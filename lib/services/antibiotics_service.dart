import 'package:dr_seta/helpers/constants.dart';
import 'package:dr_seta/models/surgery_antibiotics_model.dart';

class AntibioticsService {
  static AntibioticsService instance = AntibioticsService();

  Stream<List<SurgeryAntibioticsModel>> getData() {
   return firebaseFirestore.collection(collection.antibioticsCollection()).doc(
        "surgery").snapshots().map((event) {
      List data = event.get("antibiotics");
      return data.map((e) => SurgeryAntibioticsModel.fromSnapshot(e)).toList();
    });
  }
}