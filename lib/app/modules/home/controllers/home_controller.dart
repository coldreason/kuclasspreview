import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuclasspreview/app/data/models/course_model.dart';
import 'package:kuclasspreview/app/data/models/department_model.dart';
import 'package:kuclasspreview/app/data/models/intro_model.dart';
import 'package:kuclasspreview/app/modules/home/repositories/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository repository;

  HomeController({required this.repository});

  List<Course> courseList = [];
  List<Course> courseListView = [];
  Map<String, dynamic> collegeToMap = {};
  Map<String, List<Department>> availableDepartment = {};
  String selectedCollege = "engineering";
  Department selectedDepartment = Department();
  List<bool> filter = [true,true,true,true];
  Intro intro = Intro();

  @override
  void onInit() async {
    super.onInit();
    collegeToMap = await repository.getCollegeToViewMap();
    availableDepartment = await repository.getAvailableDepartmentMap();
    intro = await repository.getIntro();
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void click(BuildContext context, String toGo) {
    Get.dialog(
      Container(
        color: Colors.white,
        margin: EdgeInsets.all(40),
        child: HtmlWidget(
          '<iframe src="${toGo}"></iframe>',
          factoryBuilder: () => MyWidgetFactory(),
        ),
      ),
    );
  }

  void filterSelected(bool selected,int startWith){
    filter[startWith-1] = selected;
    updateViewList();
  }

  void updateViewList(){
    courseListView = [];
    for(Course course in courseList){
      if (filter[int.parse(course.courseId![0])-1]==true){
        courseListView.add(course);
      }
    }
    update();
  }

  void changeCollegeSelected() async{
    selectedCollege = await Get.dialog(
      Container(
        margin: EdgeInsets.all(50),
        color: Colors.white,
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 40,
              child: MaterialButton(onPressed: (){
                Get.back(result: availableDepartment.keys.toList()[index]);
              },child: Text(collegeToMap[availableDepartment.keys.toList()[index]]),),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
          itemCount: availableDepartment.keys.length,
        ),
      ),
    );
    selectedDepartment = Department(display: "선택하세요");
    update();
  }

  void changeDepartmentSelected() async{
    selectedDepartment = await Get.dialog(
      Container(
        margin: EdgeInsets.all(50),
        color: Colors.white,
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 40,
              child: MaterialButton(onPressed: (){
                Get.back(result: availableDepartment[selectedCollege]![index]);
              },child: Text(availableDepartment[selectedCollege]![index].display!),),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
          itemCount: availableDepartment[selectedCollege]!.length,
        ),
      ),
    );
    courseList = await repository.getCoursesWithDepartment(selectedDepartment.key!);
    updateViewList();
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {}
