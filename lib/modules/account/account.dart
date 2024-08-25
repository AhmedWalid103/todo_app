import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/services/easyLoading.dart';

import '../../firebase/firebaseUtils.dart';
import '../../firebase/task_model.dart';
import '../menu/menu_view.dart';
import '../settings/settings_view.dart';
import 'package:intl/intl.dart';

class AccountView extends StatefulWidget {
  AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  int selectedIndex = 0;

  final List<Widget> screenList = [
    const MenuView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        elevation: 2,
        child: CircleAvatar(
          radius: 25,
          backgroundColor: theme.primaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return AddBottomSheet();
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 15,
        height: 100,
        color: Colors.white,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          elevation: 0,
          backgroundColor: Colors.transparent,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_rounded),
              label: "Menu",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
      body: screenList[selectedIndex],
    );
  }
}

class AddBottomSheet extends StatefulWidget {
  @override
  _AddBottomSheetState createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController taskController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Add new Task",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  controller: taskController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your task";
                    }
                    return null;
                  },
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    hintText: "Enter your Task",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: const Color(0xFFA9A9A9)),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your description";
                    }
                    return null;
                  },
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    hintText: "Enter your Description",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: const Color(0xFFA9A9A9)),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 20),
                Text(
                  "Selected Date",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    DateTime? chosenDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );

                    if (chosenDate != null) {
                      setState(() {
                        selectedDate = chosenDate;
                      });
                    }
                  },
                  child: Text(
                    DateFormat.yMMMd().format(selectedDate),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      TaskModel task = TaskModel(
                        title: taskController.text,
                        description: descriptionController.text,
                        dateTime: selectedDate,
                      );
                      EasyLoading.show();
                      FireBaseUtils.addTasksToFireStore(task).then((onValue){
                        Navigator.pop(context);
                        EasyLoading.dismiss();
                      });


                      // Clear the form and reset the date
                      taskController.clear();
                      descriptionController.clear();
                      setState(() {
                        selectedDate = DateTime.now();
                      });

                      // Close the bottom sheet
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    "Add Task",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
