class Department {
  String? display;
  String? key;

  Department({this.display, this.key});

  Department.fromJson(Map<String, dynamic> json) {
    display = json['display'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['display'] = display;
    data['key'] = key;
    return data;
  }
}
