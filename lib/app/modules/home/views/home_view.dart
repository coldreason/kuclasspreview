import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 60,
            child: GetBuilder<HomeController>(builder: (_) {
              if (controller.availableDepartment.keys.toList().isEmpty)
                return Container();
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 160,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.teal,
                                Colors.teal[200]!,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(5, 5),
                                blurRadius: 10)
                          ]),
                      child: MaterialButton(
                        child: Text(
                          controller.collegeToMap[controller.selectedCollege]??'1. 선택하세요',
                          style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        onPressed: controller.changeCollegeSelected,
                      )),
                  Container(
                      width: 160,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.teal,
                                Colors.teal[200]!,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(5, 5),
                                blurRadius: 10)
                          ]),
                      child: MaterialButton(
                        child: Text(
                          controller.selectedDepartment.display ?? "2. 선택하세요",
                          style: GoogleFonts.lato(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        onPressed: controller.changeDepartmentSelected,
                      )),
                ],
              );
            }),
          ),
          Expanded(child: GetBuilder<HomeController>(builder: (_) {
            if (controller.courseList.isEmpty)
              return Container(
                child: Center(
                  child: Text(
                      '본 자료는 순수하게\n 크롤링을 이용하여 만들어졌음을 밝힙니다.\n비영리성 토이 프로젝트이며\n 위법적인 일을 수행하지는 않았으나,\n학교측의 공식 자료는 아님을 말씀드립니다',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                ),
              ));
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: controller.courseList.length,
                  itemBuilder: (BuildContext context, int index) {
                    String courseInfo = controller.courseList[index].code! +
                        "\n" +
                        controller.courseList[index].courseId!;
                    return CourseCard(
                      courseInfo: courseInfo,
                      title: controller.courseList[index].title ?? "",
                      professor: controller.courseList[index].professor ?? "",
                      location: controller.courseList[index].location ?? "",
                      func: controller.click,
                      link: controller.courseList[index].link ?? "",
                    );
                  }),
            );
          })),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard(
      {Key? key,
      required this.courseInfo,
      required this.title,
      required this.professor,
      required this.location,
      required this.func,
      required this.link})
      : super(key: key);
  final String courseInfo;
  final String title;
  final String professor;
  final String location;
  final String link;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: courseInfo.substring(5, 6) == "2"
                      ? Colors.greenAccent
                      : courseInfo.substring(5, 6) == "3"
                          ? Colors.yellow
                          : Colors.orange,
                  borderRadius: BorderRadius.circular(20)),
              width: 35,
              height: 35,
              child: Center(
                child: Text(
                  courseInfo,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Center(
                        child: Text(
                      title,
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    )),
                  ),
                  Text(
                    professor,
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Text(
                location,
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: IconButton(
                  icon: Icon(Icons.article),
                  onPressed: () {
                    func(context, link);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
