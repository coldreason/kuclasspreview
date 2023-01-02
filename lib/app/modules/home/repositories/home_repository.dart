import 'package:kuclasspreview/app/data/models/course_model.dart';
import 'package:kuclasspreview/app/data/models/department_model.dart';
import 'package:kuclasspreview/app/data/models/intro_model.dart';
import 'package:kuclasspreview/app/data/providers/college_to_view_provider.dart';
import 'package:kuclasspreview/app/data/providers/course_provider.dart';
import 'package:kuclasspreview/app/data/providers/department_provider.dart';
import 'package:kuclasspreview/app/data/providers/intro_provider.dart';

class HomeRepository {
  final CourseProvider courseProvider;
  final CollegeToViewProvider collegeToViewProvider;
  final DepartmentProvider departmentProvider;
  final IntroProvider introProvider;
  HomeRepository( {required this.courseProvider,required this.collegeToViewProvider,required this.departmentProvider,required this.introProvider, });

  Future<List<Course>> getCoursesWithDepartment(String department) => courseProvider.getCoursesWithDepartment(department);
  Future<Map<String,dynamic>> getCollegeToViewMap()=> collegeToViewProvider.getCollegeToViewMap();
  Future<Map<String,List<Department>>> getAvailableDepartmentMap ()=> departmentProvider.getAvailableDepartmentMap();

  Future<Intro>getIntro()=> introProvider.getIntro();
}
