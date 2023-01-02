class Course {
  String? classNo;
  String? code;
  String? courseId;
  String? link;
  String? location;
  String? professor;
  String? title;

  Course(
      {this.classNo,
      this.code,
      this.courseId,
      this.link,
      this.location,
      this.professor,
      this.title});

  Course.fromJson(Map<String, dynamic> json) {
    classNo = json['classNo'];
    code = json['code'];
    courseId = json['courseId'].toString().padLeft(3, '0');
    link = json['link'];
    location = json['location'];
    professor = json['professor'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['classNo'] = classNo;
    data['code'] = code;
    data['courseId'] = courseId;
    data['link'] = link;
    data['location'] = location;
    data['professor'] = professor;
    data['title'] = title;
    return data;
  }
}

class Courses {
  List<Course>? courses;

  Courses({this.courses});

  Courses.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = <Course>[];
      json['courses'].forEach((v) {
        courses!.add(Course.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}