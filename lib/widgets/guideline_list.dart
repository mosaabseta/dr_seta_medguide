import 'package:dr_seta/models/surgery_antibiotics_model.dart';
import 'package:flutter/material.dart';

class GuidelineList extends StatelessWidget {
  final SurgeryAntibioticsModel data;

  const GuidelineList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.procedure,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Duration: ",
                style: TextStyle(
                    color: Colors.grey[700], fontWeight: FontWeight.bold),
              ),
              Text(data.prophylaxisDuration,
                  style: const TextStyle(color: Colors.black)),
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                  "${data.time.toDate().day}/${data.time.toDate().month}/${data.time.toDate().year}")
            ],
          ),
          ListView.builder(
              physics: const ScrollPhysics(),
              itemCount: data.dosage.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    child: ListTile(
                        leading: Text(
                          data.dosage[index].line.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        title: Text(
                          "${data.dosage[index].drug} for ${data.dosage[index].classification}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "First time administration: ",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                          text:
                                              "within ${data.dosage[index].timeOfFirstDoseInMinutes} mins",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black))
                                    ]),
                              ),
                              if (data
                                  .dosage[index].firstDosageComment.isNotEmpty)
                                Column(
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
                                                  " ${data.dosage[index].firstDosageComment}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black))
                                        ])),
                                  ],
                                ),
                              if (data.dosage[index].timeOfRedosingInMinutes >
                                      0.0 &&
                                  data.dosage[index].timeOfRedosingInMinutes !=
                                      null)
                                Column(
                                  children: [
                                    const Divider(
                                      color: Colors.black,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "Time interval for doses: ",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                              text:
                                                  " every ${data.dosage[index].timeOfRedosingInMinutes / 60.toInt()} hrs",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              if (data.dosage[index].comment.isNotEmpty)
                                Column(
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
                                              text: data.dosage[index].comment,
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
                                i < data.dosage[index].amount.split("=").length;
                                i++)
                              Text(
                                "${data.dosage[index].amount.split("=")[i]} ${data.dosage[index].suffix.split("=")[i]}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
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
