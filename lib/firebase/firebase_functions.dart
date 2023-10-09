import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(TaskModel.COLLECTION_NAME)
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, options) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.COLLECTION_NAME)
        .withConverter<UserModel>(
      fromFirestore: (snapshot, options) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static Future<void> addUserToFirestore(UserModel userModel) {
    var collection = getUsersCollection();
    var docRef = collection.doc(userModel.id);
    return docRef.set(userModel);
  }

  static void addTaskToFirestore(TaskModel taskModel) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    taskModel.id = docRef.id;
    docRef.set(taskModel);
  }

  static Stream<QuerySnapshot<TaskModel>> getDataFromFirestore(DateTime date) {
    var collection = getTasksCollection();
    return collection
        .where("userId",
        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    var collection = getTasksCollection();
    return collection.doc(id).delete();
  }

  static Future<void> updateTask(String id, TaskModel taskModel) {
    var collection = getTasksCollection();
    return collection.doc(id).update(taskModel.toJson());
  }

  // static void createAuthAccount(
  //     String name, String birthday, String email, String password, Function created) async {
  //   try {
  //     var credential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     UserModel userModel = UserModel(
  //         id: credential.user!.uid,
  //         name: name,
  //         birthday: birthday,
  //         email: email);
  //     addUserToFirestore(userModel).then((value) {
  //       created();
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  static Future<UserModel?> readUser(String id)async{
    DocumentSnapshot<UserModel> userSnap = await getUsersCollection().doc(id).get();
    return userSnap.data();
  }

  // static void login(String email, String password, Function onError,  Function logged)async{
  //   try {
  //     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: email,
  //         password: password
  //     );
  //     logged();
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       onError(e.message);
  //     } else if (e.code == 'wrong-password') {
  //       onError(e.message);
  //     }
  //   }
  // }
}
