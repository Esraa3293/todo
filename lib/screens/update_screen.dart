import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/styles/text_styles.dart';

class UpdateScreen extends StatefulWidget {
  static const String routeName = 'update';

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  DateTime selectedDate = DateUtils.dateOnly(DateTime.now());
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute
        .of(context)!
        .settings
        .arguments as TaskModel;
    int timestamp = args.date;
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String datetime = tsdate.day.toString() +
        "-" +
        tsdate.month.toString() +
        "-" +
        tsdate.year.toString();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Edit Task",
          style: bodyLarge,
        ),
      ),
      body: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 10,
        margin: EdgeInsets.all(30),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: args.title,
                  labelStyle: bodyMedium.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Theme
                              .of(context)
                              .primaryColor
                      )
                  ),
                ),
              ),
              Divider(),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: args.description,
                  labelStyle: bodyMedium.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w400),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Theme
                              .of(context)
                              .primaryColor
                      )
                  ),
                ),
              ),
              Divider(),
              Text(
                "Select Time",
                style: bodyMedium,
              ),
              Divider(),
              InkWell(
                onTap: () {
                  changeTaskDate();
                },
                child: Text(datetime,
                    style: bodyMedium.copyWith(color: Colors.grey.shade400)),
              ),
              Divider(),
              ElevatedButton(
                onPressed: () {
                  args.title=titleController.text;
                  args.description=descriptionController.text;
                  tsdate=selectedDate;
                  FirebaseFunctions.updateTask(args.id, args);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Text(
                    "Save Changes",
                    style:
                    bodyMedium.copyWith(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeTaskDate() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2024)
    );
    if (chosenDate != null) {
      selectedDate = DateUtils.dateOnly(chosenDate);
      setState(() {

      });
    }
  }
}