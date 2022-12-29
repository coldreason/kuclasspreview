import 'package:kuclasspreview/app/data/models/course_model.dart';
import 'package:kuclasspreview/app/data/models/department_model.dart';
import 'package:kuclasspreview/app/data/providers/college_to_view_provider.dart';
import 'package:kuclasspreview/app/data/providers/course_provider.dart';
import 'package:kuclasspreview/app/data/providers/department_provider.dart';

class HomeRepository {
  final CourseProvider courseProvider;
  final CollegeToViewProvider collegeToViewProvider;
  final DepartmentProvider departmentProvider;
  HomeRepository( {required this.courseProvider,required this.collegeToViewProvider,required this.departmentProvider,});

  Future<List<Course>> getCoursesWithDepartment(String department) => courseProvider.getCoursesWithDepartment(department);
  Future<Map<String,dynamic>> getCollegeToViewMap()=> collegeToViewProvider.getCollegeToViewMap();
  Future<Map<String,List<Department>>> getAvailableDepartmentMap ()=> departmentProvider.getAvailableDepartmentMap();

}
