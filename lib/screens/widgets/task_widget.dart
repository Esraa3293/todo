import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/shared/styles/text_styles.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: DrawerMotion(), children: [
        SlidableAction(
          onPressed: (context) {},
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12)
          ),
          backgroundColor: Colors.red,
          icon: Icons.delete,
          label: "Delete",
        ),
        SlidableAction(
          onPressed: (context) {},
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12)
          ),
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icons.edit,
          label: "Edit",
        )
      ]),
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Row(
              children: [
                VerticalDivider(
                  thickness: 4,
                  width: 30,
                  indent: 15,
                  endIndent: 15,
                  color: Theme.of(context).primaryColor,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Task Title",
                        style: bodyMedium.copyWith(
                            color: Theme.of(context).primaryColor)),
                    Text("Task Description", style: bodySmall),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12)))),
                      onPressed: () {},
                      child: Icon(Icons.done, size: 30)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
