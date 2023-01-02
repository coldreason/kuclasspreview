import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
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
                          controller.collegeToMap[controller.selectedCollege] ??
                              '1. 선택하세요',
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
          Container(
            height: 30,
            margin: EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterButton(func: controller.filterSelected, isChecked: controller.filter[0], startWith: "1"),
                FilterButton(func: controller.filterSelected, isChecked: controller.filter[1], startWith: "2"),
                FilterButton(func: controller.filterSelected, isChecked: controller.filter[2], startWith: "3"),
                FilterButton(func: controller.filterSelected, isChecked: controller.filter[3], startWith: "4")
              ],
            ),
          ),
          Expanded(child: GetBuilder<HomeController>(builder: (_) {
            if (controller.courseListView.isEmpty)
              return Container(
                  child: Center(
                child: Text(
                  '본 자료는 순수하게\n 크롤링을 이용하여 만들어졌음을 밝힙니다.\n비영리성 토이 프로젝트이며\n 위법적인 일을 수행하지는 않았으나,\n학교측의 공식 자료는 아님을 말씀드립니다\n\n대학원,평생교육사,군사학,교직,1학년세미나 추가하지 못했습니다\n학문의 기초 :각 전공에 포함되어있습니다.\n교양 -> 핵심교양, 아잉 : 따로 항목을 분리하였습니다\n선택교양 : 학수번호가 각 전공과 같은 경우 해당 전공에 포함되었습니다.(아닌경우 누락)\n데이터 최종 업데이트 : 23.01.03:00:19 자정마다 업데이트가 이루어질 예정입니다.',
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ));
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: controller.courseListView.length,
                  itemBuilder: (BuildContext context, int index) {
                    String courseInfo = controller.courseListView[index].code! +
                        "\n" +
                        controller.courseListView[index].courseId!;
                    return CourseCard(
                      courseInfo: courseInfo,
                      title: controller.courseListView[index].title ?? "",
                      professor:
                          controller.courseListView[index].professor ?? "",
                      location: controller.courseListView[index].location ?? "",
                      func: controller.click,
                      link: controller.courseListView[index].link ?? "",
                    );
                  }),
            );
          })),
        ],
      ),
    );
  }

}

class FilterButton extends StatelessWidget {
  const FilterButton({Key? key,required this.func, required this.isChecked, required this.startWith,}) : super(key: key);
  final Function func;
  final bool isChecked;
  final String startWith;


  @override
  Widget build(BuildContext context) {
    String text = startWith + "XX";
    return Row(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(text,style: GoogleFonts.lato(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),),
          ),
        ),
        RoundCheckBox(
          isChecked: isChecked,
          checkedColor: courseColor[int.parse(startWith)-1],
          size: 30,
          onTap: (selected) {
            func(selected,int.parse(startWith));
          },
        ),
      ],
    );;
  }
}

List<Color> courseColor = [Colors.greenAccent,Colors.yellow,Colors.orange,Colors.purpleAccent];

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
                  color: courseColor[int.parse(courseInfo.substring(5, 6))-1],
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
