import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuclasspreview/constants.dart';

import '../models/course_model.dart';

class CourseProvider{

  CollectionReference<Map<String, dynamic>> courseRef = FirebaseFirestore.instance
      .collection(FirebaseConstants.department);

  @override
  void onInit() {
  }
  Future<List<Course>> getCoursesWithDepartment(String department) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await courseRef.doc(department).get();
    return [
      for(Course j in Courses.fromJson(documentSnapshot.data()??{"courses":[]}).courses!) j
    ];
  }
}
