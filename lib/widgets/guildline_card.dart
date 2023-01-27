import 'package:dr_seta/helpers/constants.dart';
import 'package:dr_seta/models/surgery_antibiotics_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GuidelineCard extends StatelessWidget {
  final SurgeryAntibioticsModel data;

  const GuidelineCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: ScrollPhysics(),
        itemCount: data.dosage.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(data.procedure,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                        SizedBox(height: 5,),

                        Row(
                          children: [
                            Row(
                              children: [
                                Text(data.dosage[index].drug,style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold)),
                                Text(data.dosage[index].line,style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal)),
                              ],
                            ),

                             ],
                        ),
                        Row(
                          children: [
                            Text("Route: ${data.dosage[index].route}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                          ],
                        ),

                        Row(
                          children: [

                            Text("Dosage: ${data.dosage[index].amount}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                            Text(data.dosage[index].suffix,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal)),
                          ],
                        ),
                        Row(

                          children: [
                            Expanded(
                              child: Text(
                                  "First time administration within: ${data.dosage[index].timeOfFirstDoseInMinutes} mins",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                            ),


                          ],
                        ),
                        Align(
                            alignment: Alignment.center,
                            child:  Text("(${data.dosage[index].firstDosageComment})")),
                        if (data.dosage[index].timeOfRedosingInMinutes > 0.0)   Text("Time interval: every ${data.dosage[index].timeOfRedosingInMinutes/60.toInt()} hrs",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                        Align(
                            alignment: Alignment.center,
                            child:  Text("Note: ${data.dosage[index].comment}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal))),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text("${data.time.toDate().day}/${data.time.toDate().month}/${data.time.toDate().year}"))
                      ],
                    ),
                    Positioned(
                        top: 0,
                        right: 5,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(data.dosage[index].classification,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                            )))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
