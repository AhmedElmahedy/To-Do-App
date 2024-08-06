class Task {
  static const String collectionName = 'tasks';
  late String id ;
  late String title;
  late String description;
  late DateTime dateTime;
  late bool isDone;

  Task({this.id = "",
  required this.title,
  required this.description,
  required this.dateTime,
    this.isDone = false
  });


  /// json => object    /// لو عاوز اخد حاجة من Firebase
  Task.fromFireStore(Map<String , dynamic > data){
    id = data ['id'];
    title = data['task'];
    description = data['description'];
    dateTime = DateTime.fromMillisecondsSinceEpoch(data["dateTime"]);
    isDone = data ['isDone'];

  }
  /// Object => json    /// لو عاوز ابعت حاجة الي Firebase
  Map <String ,dynamic> toFireStore(){
    return{
      "id" : id,
      "task" : title,
      "description" : description,
      "dateTime" : dateTime.millisecondsSinceEpoch,
      "isDone" : isDone
    };
  }
}