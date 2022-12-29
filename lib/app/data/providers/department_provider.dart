import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuclasspreview/constants.dart';

import '../models/department_model.dart';

class DepartmentProvider {
  DocumentReference<Map<String, dynamic>> availableRef = FirebaseFirestore
      .instance
      .collection(FirebaseConstants.available).doc(FirebaseConstants.department);

  @override
  void onInit() {
  }

  Future<Map<String, List<Department>>> getAvailableDepartmentMap() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await availableRef.get();
    Map<String, List<Department>> ret = {};
    for(String i in documentSnapshot.data()!.keys){
      List<Department> innerList = [];
      for (var departmentJson in documentSnapshot.data()![i]){
        innerList.add(Department.fromJson(departmentJson));
      }
      ret[i] = innerList;
    }
    return ret;
  }
}
