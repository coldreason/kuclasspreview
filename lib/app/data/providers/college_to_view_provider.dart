import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuclasspreview/constants.dart';

class CollegeToViewProvider{

  CollectionReference<Map<String, dynamic>> collegeRef = FirebaseFirestore.instance
      .collection(FirebaseConstants.collegeToView);

  @override
  void onInit() {
  }

  Future<Map<String, dynamic>> getCollegeToViewMap() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await collegeRef.doc(FirebaseConstants.collegeToView).get();
    return documentSnapshot.data()??{};
  }
}