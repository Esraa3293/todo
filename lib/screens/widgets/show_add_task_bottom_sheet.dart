import 'package:flutter/material.dart';
import 'package:todo/shared/styles/app_colors.dart';
import 'package:todo/shared/styles/text_styles.dart';

class ShowAddTaskBottomSheet extends StatefulWidget {
  @override
  State<ShowAddTaskBottomSheet> createState() => _ShowAddTaskBottomSheetState();
}

class _ShowAddTaskBottomSheetState extends State<ShowAddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return("Please Enter Task Title");
                  }else if(value.length != 10){
                    return ("please Enter 10 char");
                  }
                  return null;
                },
                decoration: InputDecoration(
                    label: Text("Task Title"),
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
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return("Please Enter Task Description");
                  }
                  return null;
                },
                decoration: InputDecoration(
                    label: Text("Task Describtion"),
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
                    DateTime.now().toString().substring(0,10),
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
                      print("Route c8");
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
    );
  }

  void chooseTaskDate(BuildContext context){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
  }
}
