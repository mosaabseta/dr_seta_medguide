import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class SurgeryAntibioticsModel {
  final String speciality; //
  final String procedure;
  final String dicipline; //
  final Timestamp time;
  final List<Dosage> dosage;

  SurgeryAntibioticsModel({
    required this.time,
    required this.speciality,
    required this.procedure,
    required this.dicipline,
    required this.dosage,
  });

  static SurgeryAntibioticsModel fromSnapshot(Map<String,dynamic> snapshot) {
    List<Dosage> dosage = Dosage.fromSnapshot(snapshot["dosage"]);

    SurgeryAntibioticsModel surgeryAntibiotics = SurgeryAntibioticsModel(
      speciality: snapshot["speciality"],
      procedure: snapshot["procedure"],
      time: snapshot["time"],
      dicipline: snapshot["dicipline"],
      dosage: dosage,
    );
    return surgeryAntibiotics;
  }

  static List<Map<String, dynamic>> toMap(List<SurgeryAntibioticsModel> list) {
    List<Map<String, dynamic>> res = [];
    for (int i = 0; i < list.length; i++) {
      List<Map> dosage = Dosage.toMap(list[i].dosage);
      Map<String, dynamic> data = {
        "speciality": list[i].speciality,
        "procedure": list[i].procedure,
        "time": list[i].time,
        "dicipline": list[i].dicipline,
        "dosage": dosage
      };
      res.add(data);
    }
    return res;
  }
}

class Dosage {
  final String route;
  final String classification; // adults ex.
  final String amount;
  final String suffix;
  final int timeOfFirstDoseInMinutes;
  final int timeOfRedosingInMinutes;
  final String drug;
  final String line; //
  final String comment;
  final String firstDosageComment;

  Dosage(
      {required this.classification,
      required this.amount,
      required this.route,
      required this.firstDosageComment,
      required this.timeOfRedosingInMinutes,
      required this.timeOfFirstDoseInMinutes,
      required this.drug,
      required this.line,
      required this.comment,
      required this.suffix});

  static List<Dosage> fromSnapshot(List<dynamic> list) {
    List<Dosage> data = [];

    for (int i = 0; i < list.length; i++) {
      data.add(Dosage(
          classification: list[i]["classification"],
          amount: list[i]["amount"],
          firstDosageComment: list[i]["first_dosage_comment"],
          suffix: list[i]["suffix"],
          route: list[i]["route"],
          drug: list[i]["drug"],
          line: list[i]["line"],
          comment: list[i]["comment"],
          timeOfRedosingInMinutes: list[i]["time_of_redosing_in_minutes"],
          timeOfFirstDoseInMinutes: list[i]["time_of_first_dose_in_minutes"]));
    }

    return data;
  }

  static List<Map<String,dynamic>> toMap(List<Dosage> list) {
    List<Map<String,dynamic>> res = [];
    for (int i = 0; i < list.length; i++) {
      Map<String,dynamic> data = {
        "classification": list[i].classification,
        "amount": list[i].amount,
        "first_dosage_comment": list[i].firstDosageComment,
        "suffix": list[i].suffix,
        "route": list[i].route,
        "drug": list[i].drug,
        "line": list[i].line,
        "comment": list[i].comment,
        "time_of_redosing_in_minutes": list[i].timeOfRedosingInMinutes,
        "time_of_first_dose_in_minutes": list[i].timeOfFirstDoseInMinutes
      };

      res.add(data);
    }
    return res;
  }
  static Map<String,dynamic> toSingelMap(Dosage dosage) {


      Map<String,dynamic> data = {
        "classification": dosage.classification,
        "amount": dosage.amount,
        "first_dosage_comment": dosage.firstDosageComment,
        "suffix": dosage.suffix,
        "route": dosage.route,
        "drug":dosage.drug,
        "line": dosage.line,
        "comment": dosage.comment,
        "time_of_redosing_in_minutes": dosage.timeOfRedosingInMinutes,
        "time_of_first_dose_in_minutes": dosage.timeOfFirstDoseInMinutes
      };


    return data;
  }
}
