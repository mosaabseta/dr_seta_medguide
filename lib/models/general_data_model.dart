import 'package:cloud_firestore/cloud_firestore.dart';

class GeneralDataModel {
  final List deciplines;
  final List procedures;
  final List speciality;
  final List line;
  final List dosageClassification;

  GeneralDataModel(
      {required this.deciplines,
      required this.procedures,
      required this.speciality,
      required this.line,
      required this.dosageClassification});

  static GeneralDataModel fromSnapshot(DocumentSnapshot snapshot) {
    GeneralDataModel generalData = GeneralDataModel(
        deciplines: snapshot["deciplines"],
        procedures: snapshot["procedures"],
        speciality: snapshot["speciality"],
        line: snapshot["line"],
        dosageClassification: snapshot["dosage_classification"]);
    return generalData;
  }
}
