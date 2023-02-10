import 'package:dr_seta/helpers/constants.dart';
import 'package:dr_seta/models/surgery_antibiotics_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/color.schemes.g.dart';

class GuidelineList extends StatelessWidget {
  final SurgeryAntibioticsModel data;

  const GuidelineList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.procedure.capitalize.toString(),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.fromBorderSide(BorderSide(
              color: Colors.black
            ),
               )
          ),

          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              children: [
                // Divider(thickness: 2,),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Duration: ",
                      style: TextStyle(fontSize: 18,
                          color: Colors.grey[700], fontWeight: FontWeight.bold),
                    ),
                    Text(data.prophylaxisDuration,
                        style: const TextStyle(fontSize: 16,color: Colors.black)),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "List of Drugs",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        "Updated on ${data.time.toDate().day}/${data.time.toDate().month}/${data.time.toDate().year}")
                  ],
                ),
              ],
            ),
          ),
        ),

        FutureBuilder<List<Dosage> >(
          future:controller. filterCard(
              data.dosage),
          builder: (context, snapshot) {
           switch(snapshot.connectionState){

             case ConnectionState.none:
              return Container();

             case ConnectionState.waiting:
               return Container();

             case ConnectionState.active:
               return Container();

             case ConnectionState.done:
               return ListView.builder(
                   physics: const ScrollPhysics(),
                   itemCount:snapshot.data! .length,
                   shrinkWrap: true,
                   itemBuilder: (context, index) {
                     return Card(
                       elevation: 5,
                       shadowColor:lightColorScheme.shadow,
                       child: Padding(
                         padding:
                         const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                         child: ListTile(
                             leading: Text(
                              snapshot.data![index].line.toString(),
                               style: const TextStyle(
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             title: Padding(
                               padding: const EdgeInsets.only(top: 10),
                               child: Text(
                                 snapshot.data![index].drug.capitalize.toString(),
                                 style: const TextStyle(
                                   fontSize: 18,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                             ),
                             subtitle: Padding(
                               padding: const EdgeInsets.all(0),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   const SizedBox(
                                     height: 10,
                                   ),
                                   RichText(
                                     text: TextSpan(
                                         text: "First Time for Administration: ",
                                         style: TextStyle(
                                           color: Colors.grey[700],
                                           fontSize: 16,
                                           fontWeight: FontWeight.bold,
                                         ),
                                         children: [
                                           TextSpan(
                                               text:
                                               "within ${snapshot.data![index].timeOfFirstDoseInMinutes} mins",
                                               style: const TextStyle(
                                                   fontSize: 14,
                                                   color: Colors.black))
                                         ]),
                                   ),

                                     if(snapshot.data![index].firstDosageComment.isNotEmpty)    Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         const Divider(
                                           color: Colors.black,
                                         ),
                                         RichText(
                                             text: TextSpan(
                                                 text: "Note: ",
                                                 style: TextStyle(
                                                     color: Colors.grey[700],
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.bold),
                                                 children: [
                                                   TextSpan(
                                                       text:
                                                       " ${snapshot.data![index].firstDosageComment}",
                                                       style: const TextStyle(
                                                           fontSize: 14,
                                                           color: Colors.black))
                                                 ])),
                                       ],
                                     ),
                                   if (snapshot.data![index].timeOfRedosingInMinutes >
                                       0.0 &&
                                      snapshot.data![index].timeOfRedosingInMinutes !=
                                           null)
                                     Column(
                                       children: [
                                         const Divider(
                                           color: Colors.black,
                                         ),
                                         RichText(
                                           text: TextSpan(
                                             text: "Time Interval for Doses: ",
                                             style: TextStyle(
                                                 color: Colors.grey[700],
                                                 fontSize: 16,
                                                 fontWeight: FontWeight.bold),
                                             children: [
                                               TextSpan(
                                                   text:
                                                   " every ${(snapshot.data![index].timeOfRedosingInMinutes / 60).ceil().toInt()} hrs",
                                                   style: const TextStyle(
                                                       fontSize: 14,
                                                       color: Colors.black))
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   if (snapshot.data![index].comment.isNotEmpty)
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         const Divider(
                                           color: Colors.black,
                                         ),
                                         RichText(
                                           text: TextSpan(
                                             text: "Note: ",
                                             style: TextStyle(
                                                 color: Colors.grey[700],
                                                 fontSize: 16,
                                                 fontWeight: FontWeight.bold),
                                             children: [
                                               TextSpan(
                                                   text:snapshot.data![index].comment,
                                                   style: const TextStyle(
                                                       fontSize: 14,
                                                       color: Colors.black))
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                 ],
                               ),
                             ),
                             trailing: Column(
                               children: [
                                 for (int i = 0;
                                 i <snapshot.data![index].amount.split("=").length;
                                 i++)
                                   Text(
                                     "${snapshot.data![index].amount.split("=")[i]} ${snapshot.data![index].suffix.split("=")[i]}",
                                     style: const TextStyle(
                                         fontWeight: FontWeight.bold),
                                   ),
                                 Text(snapshot.data![index].route),
                               ],
                             )),
                       ),
                     );
                   });

           }
          }
        ),
      ],
    );
  }
}
