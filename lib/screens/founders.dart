import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/constants.dart';
import '../models/general_data_model.dart';

class Founders extends StatefulWidget {
  const Founders({Key? key}) : super(key: key);

  @override
  State<Founders> createState() => _FoundersState();
}

class _FoundersState extends State<Founders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contributors"),
        backgroundColor: Colors.indigoAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              """App contents are based on an audit project under the title 
Preoperative Antibiotic uses in Soba University Hospital
                 """,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
            ListTile(
              title: Text("Authors",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: FutureBuilder<GeneralDataModel>(
                  future: controller.generalData,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Container();
                      case ConnectionState.waiting:
                        return Container();
                      case ConnectionState.active:
                        return Container();
                      case ConnectionState.done:
                        return Column(
                          children: [
                            ...List.generate(
                                snapshot.data!.authors.length, (index) => ListTile(
                              title: Text(snapshot.data!.authors[index]["name"]),
                              subtitle: Text(snapshot.data!.authors[index]["title"]),
                              trailing: Text(snapshot.data!.authors[index]["part"]),
                            ))
                          ],
                        );
                    }
                  }),
            )
            , ListTile(
              title: Text("Developers",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: FutureBuilder<GeneralDataModel>(
                  future: controller.generalData,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Container();
                      case ConnectionState.waiting:
                        return Container();
                      case ConnectionState.active:
                        return Container();
                      case ConnectionState.done:
                        return Column(
                          children: [
                            ...List.generate(
                                snapshot.data!.developers.length, (index) => ListTile(
                              title: Text(snapshot.data!.developers[index]["name"]),
                              subtitle: Text(snapshot.data!.developers[index]["title"]),

                            ))
                          ],
                        );
                    }
                  }),
            )
            ,  ListTile(
              title: Text("Acknowledgements",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: FutureBuilder<GeneralDataModel>(
                  future: controller.generalData,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Container();
                      case ConnectionState.waiting:
                        return Container();
                      case ConnectionState.active:
                        return Container();
                      case ConnectionState.done:
                        return Column(
                          children: [
                            ...List.generate(
                                snapshot.data!.acknowledgement.length, (index) => ListTile(
                              title: Text(snapshot.data!.acknowledgement[index]["name"]),
                              subtitle: Text(snapshot.data!.acknowledgement[index]["part"]),
                               ))
                          ],
                        );
                    }
                  }),
            )
            ,
          ],
        ),
      ),
    );
  }
}
