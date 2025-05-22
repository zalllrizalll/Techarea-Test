class Data {
  num? id;

  Data({this.id});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] as num?;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
