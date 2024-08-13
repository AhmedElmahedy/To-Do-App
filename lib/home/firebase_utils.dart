import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/home/model/my_users.dart';
import 'package:todoapp/home/model/task.dart';

class FirebaseUtils {
  /// Collection Task
  static CollectionReference<Task> getTasksCollection(String uid) {
    return getUsersCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (Task, options) => Task.toFireStore());
  }
  /// Add Task
  static Future<void> addTaskToFireStore(Task task, String uid) {
    var taskCollection = getTasksCollection(uid);

    /// Collection
    DocumentReference<Task> taskDecRef = taskCollection.doc();
    task.id = taskDecRef.id;   /// auto ID
    return taskDecRef.set(task);
  }
  /// Delete Task
  static Future<void> deleteTaskFromFireStore(Task task, String uid) {
    return getTasksCollection(uid).doc(task.id).delete();
  }
  /// UpDate Task
  static Future<void> upDateTaskFromFireStore(Task task, String uid) {
    return getTasksCollection(uid).doc(task.id).update({});
  }

  /// Collection Users
  static CollectionReference<MyUsers> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUsers.collectionName)
        .withConverter(
            fromFirestore: ((snapshot, options) =>
                MyUsers.fromFireStore(snapshot.data())),
            toFirestore: (myUsers, options) => myUsers.toFireStore());
  }

  /// Add Users
  static Future<void> addUserToFireStore(MyUsers myUsers) {
    return getUsersCollection().doc(myUsers.id).set(myUsers);
  }

  /// Read Users
  static Future<MyUsers?> readUserFromFireStore(String uid) async {
    var querySnapshot = await getUsersCollection().doc(uid).get();
    return querySnapshot.data();
  }
}
