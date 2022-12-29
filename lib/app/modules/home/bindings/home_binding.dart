import 'package:get/get.dart';
import 'package:kuclasspreview/app/data/providers/college_to_view_provider.dart';
import 'package:kuclasspreview/app/data/providers/course_provider.dart';
import 'package:kuclasspreview/app/data/providers/department_provider.dart';
import 'package:kuclasspreview/app/modules/home/repositories/home_repository.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(repository: HomeRepository(courseProvider: CourseProvider(), collegeToViewProvider: CollegeToViewProvider(), departmentProvider: DepartmentProvider())),
    );
  }
}
