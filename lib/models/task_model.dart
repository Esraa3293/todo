class TaskModel {
  static const String COLLECTION_NAME = "Tasks";
  String id;
  String title;
  String description;
  bool status;
  int date;
  String userId;

  TaskModel(
      {this.id = "",
      required this.title,
      required this.description,
      required this.status,
      required this.date,
      required this.userId});

  TaskModel.fromJson(Map<String,dynamic> json):this(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    status: json['status'],
    date: json['date'],
    userId: json['userId']
  );

  Map<String,dynamic> toJson(){
    return {
      'id' : id,
      'title' : title,
      'description' : description,
      'status' : status,
      'date' : date,
      'userId' : userId
    };
  }
}
