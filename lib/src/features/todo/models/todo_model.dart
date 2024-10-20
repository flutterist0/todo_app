class ToDoModel {
  String? title;
  String? description;
  int? userId;

  ToDoModel({
    this.title,
    this.description,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['userId'] = userId;
    return data;
  }
}
