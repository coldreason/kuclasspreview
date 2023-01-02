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
            if (controller.courseListView.isEmpty) {
              return Container(
                  child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (controller.intro.intro??"").replaceAll('\\n', '\n'),
                        style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (controller.intro.notice??"").replaceAll('\\n', '\n'),
                        style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "data last updated at ${controller.intro.updateAt}",
                        style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ));
            }
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
