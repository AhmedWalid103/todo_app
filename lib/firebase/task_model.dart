import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_app/core/features/utils.dart';

class TaskModel
{
  static const String collectionName="tasks";
  String id ;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  TaskModel({
   this.id='',
    required  this.title,
    required  this.description,
    required  this.dateTime,
    this.isDone=false,
  });

factory TaskModel.fromFireStore(Map<String,dynamic> data )=>TaskModel(
  id: data["id"],
    title: data["title"],
    description: data["description"],
    dateTime: DateTime.fromMillisecondsSinceEpoch(data["dateTime"]),
  isDone: data["isDone"],
);

Map<String,dynamic> toFireStore()
  {
    return {
      "id":id,
      "title":title,
      "description":description,
      "dateTime":selectedDateFormat(dateTime).millisecondsSinceEpoch,
      "isDone":isDone
    };
  }
  // Method to convert TaskModel to Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'dateTime': dateTime,
    };
  }
}
