import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/services/easyLoading.dart';
import 'package:todo_app/firebase/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseUtils {

  static CollectionReference<TaskModel> getRef() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User is not signed in");
    }
    String uid = user.uid;
  return  FirebaseFirestore.instance
  .collection("users")
  .doc(uid)
        .collection(TaskModel.collectionName)
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, options) =>
          TaskModel.fromFireStore(snapshot.data()!),
      toFirestore: (taskModel, options) => taskModel.toFireStore(),
    );
  }

 static Future<void> addTasksToFireStore(TaskModel task)
{
   var docREf = getRef().doc();
   task.id=docREf.id;

   return docREf.set(task);
}
static Future<void> deleteData(TaskModel task) async
{
  var docREf = getRef().doc(task.id);

  return docREf.delete();
}
  static Future<void> updateData(TaskModel task) async
  {
    var docREf = getRef().doc(task.id);

    return docREf.update({
      "isDone":true,
    });
  }

 static Future<List<TaskModel>> getDocumentsData(DateTime selectedDate) async
{
  var collectionRef = await getRef().where(
      "dateTime", isEqualTo: selectedDate.millisecondsSinceEpoch);

  List<TaskModel> tasksList = [];

  var doc=await collectionRef.get();

  tasksList = doc.docs.map((e) => e.data()).toList();

  return tasksList;
}

 static Stream<QuerySnapshot<TaskModel>> getStreamData(DateTime selectedDate)
{
  var collectionRef =  getRef().where(
      "dateTime", isEqualTo: selectedDate.millisecondsSinceEpoch);

  List<TaskModel> tasksList = [];

  return collectionRef.snapshots();

}
  static Future<bool> createAccount(String email, String password) async {
    try {
      EasyLoading.show(); // Show loading indicator before starting the process
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      EasyLoading.dismiss(); // Dismiss loading indicator on success
      return true; // Indicate that account creation was successful
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss(); // Ensure loading indicator is dismissed on error

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print('An error occurred: ${e.message}');
      }
      return false; // Indicate that account creation failed
    } catch (e) {
      EasyLoading.dismiss(); // Ensure loading indicator is dismissed on unexpected error
      print('An error occurred: $e');
      return false; // Indicate that account creation failed
    }
  }
  static Future<bool> signIn(String email, String password) async {
    try {
      EasyLoading.show(); // Show loading indicator while signing in
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      EasyLoading.dismiss(); // Dismiss loading indicator on success
      return true; // Indicate that sign-in was successful
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss(); // Ensure loading indicator is dismissed on error

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        // Optionally show a message to the user
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        // Optionally show a message to the user
      } else {
        print('An error occurred: ${e.message}');
        // Optionally show a message to the user
      }
      return false; // Indicate that sign-in failed
    } catch (e) {
      EasyLoading.dismiss(); // Ensure loading indicator is dismissed on unexpected error
      print('An unexpected error occurred: $e');
      // Optionally show a message to the user
      return false; // Indicate that sign-in failed
    }
  }

}
