import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_time_line/date_time_line.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/screens/widgets/task_widget.dart';
import 'package:todo/shared/styles/app_colors.dart';
import 'package:todo/shared/styles/text_styles.dart';

import '../models/task_model.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateTimeLine(
          width: MediaQuery.of(context).size.width,
          color: Colors.lightGreen,
          hintText: "10 task today",
          onSelected: (value) {
            setState(() {
              date = value;
            });
          },
        ),
        StreamBuilder<QuerySnapshot<TaskModel>>(
          stream: FirebaseFunctions.getDataFromFirestore(date),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Column(
                children: [
                  Text("Something went wrong"),
                  ElevatedButton(onPressed: () {}, child: Text("Try Again"))
                ],
              );
            }
              var tasksList =
                  snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
            if(tasksList.isEmpty){
              return Center(child: Text("No Tasks", style: bodyMedium.copyWith(color: lightColor),));
            }
              return Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => TaskWidget(tasksList[index]),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: tasksList.length),
              );
          },
        ),
      ],
    );
  }
}
