import 'package:cloud_firestore/cloud_firestore.dart';

class GeneralDataModel {
  final List deciplines;
  final List procedures;
  final List speciality;
  final List line;
  final List dosageClassification;
  final List developers;
  final List authors;
  final List acknowledgement;

  GeneralDataModel(
      {required this.deciplines,
      required this.procedures,
        required this.authors,
        required this.acknowledgement,
        required this.developers,
      required this.speciality,
      required this.line,
      required this.dosageClassification});

  static GeneralDataModel fromSnapshot(DocumentSnapshot snapshot) {
    GeneralDataModel generalData = GeneralDataModel(
        deciplines: snapshot["deciplines"],
        procedures: snapshot["procedures"],
        speciality: snapshot["speciality"],
        authors: snapshot["authors"],
        developers: snapshot["developers"],
        acknowledgement: snapshot["acknowledgement"],
        line: snapshot["line"],
        dosageClassification: snapshot["dosage_classification"]);
    return generalData;
  }
}
