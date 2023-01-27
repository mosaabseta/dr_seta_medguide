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
              child: Text(data.procedure,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("List of Drugs"),
          ),
          ListView.builder(
              physics: ScrollPhysics(),
              itemCount: data.dosage.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
             return   Card(
                  child: ListTile(

                      leading: Text
                        (data.dosage[index].line.toString()),
                      title: Text("${data.dosage[index].drug} for ${data.dosage[index].classification}"  ),
                      subtitle:Column(
                        children: [

                          Row(

                            children: [
                              Expanded(
                                child: Text(
                                    "First time administration within ${data.dosage[index].timeOfFirstDoseInMinutes} mins"),
                              ),


                            ],
                          ),
                        if(data.dosage[index].firstDosageComment.isNotEmpty)  Align(
                              alignment: Alignment.center,
                              child:  Text("(${data.dosage[index].firstDosageComment})")),
                          Text("Time interval for doses: every ${data.dosage[index].timeOfRedosingInMinutes/60.toInt()} hrs"),
                          if(data.dosage[index].comment.isNotEmpty)Align(
                              alignment: Alignment.center,
                              child:  Text("Note: ${data.dosage[index].comment}")),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text("${data.time.toDate().day}/${data.time.toDate().month}/${data.time.toDate().year}"))


                        ],
                      ) ,
                      trailing:Column(
                        children: [
                          Text("${data.dosage[index].amount} ${data.dosage[index].suffix}"),
                          Text(data.dosage[index].route),
                        ],
                      )
                  ),
                );
              }),
        ],
      ),
    );
  }
}
