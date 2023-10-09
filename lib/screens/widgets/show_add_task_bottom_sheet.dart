import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/styles/app_colors.dart';
import 'package:todo/shared/styles/text_styles.dart';

class ShowAddTaskBottomSheet extends StatefulWidget {
  @override
  State<ShowAddTaskBottomSheet> createState() => _ShowAddTaskBottomSheetState();
}

class _ShowAddTaskBottomSheetState extends State<ShowAddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var taskTitleController = TextEditingController();
  var taskDescriptionController = TextEditingController();
  DateTime selectedDate = DateUtils.dateOnly(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom
              //to make bottom sheet in top when openning keybored
              ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                //to make bottom sheet in top when openning keybored
                children: [
                  Text(
                    "Add new Task",
                    style: bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: taskTitleController,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if(value==null || value.isEmpty){
                        return("Please Enter Task Title");
                      }/*else if(value.length != 10){
                        return ("please Enter 10 char");
                      }*/
                      return null;
                    },
                    decoration: InputDecoration(
                        label: Text(
                            taskTitleController.text
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor))),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  TextFormField(
                    controller: taskDescriptionController,
                    validator: (value) {
                      if(value==null || value.isEmpty){
                        return("Please Enter Task Description");
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        label: Text(
                            taskDescriptionController.text
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor))),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Select Time",
                      style: bodyMedium
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  InkWell(
                    onTap: () {
                      chooseTaskDate(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        selectedDate.toString().substring(0,10),
                        style: bodyMedium.copyWith(color: lightColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          TaskModel task = TaskModel(
                              title: taskTitleController.text,
                              description: taskDescriptionController.text,
                              status: false,
                              userId: FirebaseAuth.instance.currentUser!.uid,
                              date: selectedDate.millisecondsSinceEpoch);
                          FirebaseFunctions.addTaskToFirestore(task);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Add Task",
                        style: bodyMedium.copyWith(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void chooseTaskDate(BuildContext context) async{
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
    if(chosenDate != null){
      selectedDate = DateUtils.dateOnly(chosenDate);
      setState(() {

      });
    }
  }
}
