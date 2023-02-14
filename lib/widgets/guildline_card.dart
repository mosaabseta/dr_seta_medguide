import 'package:dr_seta/models/surgery_antibiotics_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/constants.dart';

class GuidelineCard extends StatelessWidget {
  final SurgeryAntibioticsModel data;

  const GuidelineCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Dosage>>(
        future: controller.filterCard(data.dosage),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();

            case ConnectionState.waiting:
              return Container();

            case ConnectionState.active:
              return Container();

            case ConnectionState.done:
              return ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    double width = MediaQuery.of(context).size.width * .8;
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFF8797F2),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width,
                                    child: RichText(
                                      text: TextSpan(
                                        text: data.procedure.capitalize
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "updated on ${data.time.toDate().day}/${data.time.toDate().month}/${data.time.toDate().year}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // const Divider(
                              //   thickness: 2,
                              // ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: RichText(
                                    text: TextSpan(
                                        text: snapshot
                                            .data![index].drug.capitalize
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                      TextSpan(
                                          text:
                                              "  ${snapshot.data![index].line}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal))
                                    ])),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Route: ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(child: Align(
                                      alignment : Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Container(
                                          color: Colors.grey[700],
                                          height: 1,
                                        ),
                                      ),
                                    ),),
                                    Text(
                                      snapshot.data![index].route,
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Dosage: ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Expanded(child: Align(
                                      alignment : Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Container(
                                          color: Colors.grey[700],
                                          height: 1,
                                        ),
                                      ),
                                    ),),
                                  Column(children: [
                                    for (int i = 0;
                                    i <snapshot.data![index].amount.split("=").length;
                                    i++)Text(
                                        "${snapshot.data![index].amount.split("=")[i]} ${snapshot.data![index].suffix.split("=")[i]}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal))
                                  ],)
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        "First time administration within: ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(child: Align(
                                      alignment : Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Container(
                                          color: Colors.grey[700],
                                          height: 1,
                                        ),
                                      ),
                                    ),),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${snapshot.data![index].timeOfFirstDoseInMinutes.toInt()} mins",
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        if (snapshot.data![index]
                                            .firstDosageComment.isNotEmpty)
                                          Text(
                                            "(${snapshot.data![index].firstDosageComment})",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (snapshot
                                      .data![index].timeOfRedosingInMinutes >
                                  0.0)
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    // mainAxisAlignment:
                                    // MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Text(
                                        "Time interval: ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(child: Align(
                                        alignment : Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Container(
                                            color: Colors.grey[700],
                                            height: 1,
                                          ),
                                        ),
                                      ),),
                                      Text(
                                        "Every ${snapshot.data![index].timeOfRedosingInMinutes ~/ 60.ceil()} hrs",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              const SizedBox(
                                height: 5,
                              ),
                              if (snapshot.data![index].comment.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: "Note: ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                text: snapshot
                                                    .data![index].comment,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              )
                                            ]),
                                      ),
                                      // const Text(
                                      //   "Note: ",
                                      //   style: TextStyle(
                                      //       fontSize: 18, fontWeight: FontWeight.bold),
                                      // ),
                                      // Column(
                                      //   children: [
                                      //     Container(
                                      //       child: Text(
                                      //         snapshot.data![index].comment,
                                      //         style: const TextStyle(
                                      //           fontSize: 16,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
          }
        });
  }
}
