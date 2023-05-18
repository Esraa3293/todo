import 'package:flutter/material.dart';
import 'package:todo/screens/settings_screen.dart';
import 'package:todo/screens/task_screen.dart';
import 'package:todo/screens/widgets/show_add_task_bottom_sheet.dart';
import 'package:todo/shared/styles/text_styles.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = 'home layout';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<Widget> tabs = [TaskScreen(), SettingsScreen()];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      //to see the background
      appBar: AppBar(
        title: Text("To Do List", style: bodyLarge),
      ),
      bottomNavigationBar: BottomAppBar(
        //to make notch margin
        shape: CircularNotchedRectangle(), //to make notch margin
        notchMargin: 8, //to make notch margin
        child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            //to make notch margin
            elevation: 0.0,
            //to make notch margin
            onTap: (value) {
              index = value;
              setState(() {});
            },
            currentIndex: index,
            iconSize: 30,
            showSelectedLabels: false,
            //center items
            showUnselectedLabels: false,
            //center items
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: "",
              ),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskSheet();
        },
        child: Icon(Icons.add),
        shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 3)),
      ),
      body: tabs[index],
    );
  }

  void showAddTaskSheet() {
    showModalBottomSheet(
      isScrollControlled: true, //to make bottom sheet in top when openning keybored
      context: context,
      builder: (context) {
        return ShowAddTaskBottomSheet();
      },
    );
  }
}
