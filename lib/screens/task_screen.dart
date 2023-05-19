import 'package:flutter/material.dart';
import 'package:date_time_line/date_time_line.dart';
import 'package:todo/screens/widgets/task_widget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime date=DateTime.now();

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
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) => TaskWidget(),
              separatorBuilder: (context, index) => Divider(),
              itemCount: 5),
        )
      ],
    );
  }
}
