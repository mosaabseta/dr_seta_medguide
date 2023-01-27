import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_seta/controllers/controller.dart';
import 'package:dr_seta/helpers/collections.dart';

import '../services/antibiotics_service.dart';
import '../services/general_data_service.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
Controller controller = Controller.instance;
Collection collection = Collection.instance;
AntibioticsService antibioticsService= AntibioticsService.instance;
GeneralDatabase generalDatabase =GeneralDatabase.instance;