import 'package:dr_seta/helpers/constants.dart';
import 'package:dr_seta/models/surgery_antibiotics_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GuidelineList extends StatelessWidget {
  final SurgeryAntibioticsModel data;

  const GuidelineList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                data.procedure,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("List of Drugs"),
                Text(
                    "${data.time.toDate().day}/${data.time.toDate().month}/${data.time.toDate().year}")
              ],
            ),
          ),
          ListView.builder(
              physics: ScrollPhysics(),
              itemCount: data.dosage.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 5),
                    child: ListTile(
                        leading: Text(data.dosage[index].line.toString()),
                        title: Text(
                            "${data.dosage[index].drug} for ${data.dosage[index].classification}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [



                                  RichText(text: TextSpan(text: "First time administration ",style: TextStyle(color: Colors.grey[700]), children: [
                                    TextSpan(
                                        text: "within ${data.dosage[index].timeOfFirstDoseInMinutes} mins",style: TextStyle(color: Colors.black))

                                  ]),


                            ),
                            if (data.dosage[index].firstDosageComment.isNotEmpty)
                              RichText(text: TextSpan(text: "Note: ",style: TextStyle(color: Colors.grey[700]), children: [
                                TextSpan(
                                    text: " ${data.dosage[index].firstDosageComment}",style: TextStyle(color: Colors.black))

                              ])),
                            RichText(text: TextSpan(text: "Time interval for doses: ",style: TextStyle(color: Colors.grey[700]), children: [
                              TextSpan(
                                  text: " every ${data.dosage[index].timeOfRedosingInMinutes / 60.toInt()} hrs",style: TextStyle(color: Colors.black))

                            ])),
                            if (data.dosage[index].comment.isNotEmpty)
                              RichText(text: TextSpan(text:  "Note: ",style: TextStyle(color: Colors.grey[700]), children: [
                                TextSpan(
                                    text: "${data.dosage[index].comment}",style: TextStyle(color: Colors.black))

                              ])),

                          ],
                        ),
                        trailing: Column(
                          children: [
                            Text(
                                "${data.dosage[index].amount} ${data.dosage[index].suffix}",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(data.dosage[index].route),
                          ],
                        )),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
