class Intro {
  String? intro;
  String? notice;
  String? updateAt;

  Intro({this.intro, this.notice, this.updateAt});

  Intro.fromJson(Map<String, dynamic> json) {
    intro = json['intro'];
    notice = json['notice'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['intro'] = intro;
    data['notice'] = notice;
    data['updateAt'] = updateAt;
    return data;
  }
}
