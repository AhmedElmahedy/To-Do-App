import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/home/model/task.dart';

class FirebaseUtils {

  /// Collection
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (Task, options) => Task.toFireStore());
  }
  /// Add Task
  static Future<void> addTaskToFireStore(Task task) {
    var taskCollection = getTasksCollection();       /// Collection
    DocumentReference<Task> taskDecRef = taskCollection.doc();
    task.id = taskDecRef.id;   /// auto ID
    return taskDecRef.set(task);
  }
  /// Delete Task
  static Future<void> deleteTaskFromFireStore(Task task){
    return getTasksCollection().doc(task.id).delete() ;
  }
  /// UpDate Task
  static Future<void> upDateTaskFromFireStore(Task task){
   return getTasksCollection().doc(task.id).update({
     
   });

  }
}
