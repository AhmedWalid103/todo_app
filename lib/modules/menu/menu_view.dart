import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/firebase/firebaseUtils.dart';
import 'package:todo_app/modules/task_item_widget.dart';
import 'package:todo_app/firebase/task_model.dart';

class MenuView extends StatefulWidget {

  const MenuView({super.key,});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {

  DateTime? focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        Container(
          height: mediaQuery.size.height * 0.1,
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 20),
            child: Text(
              "To do list",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
        EasyDateTimeLine(
          initialDate: DateTime.now(),
     onDateChange: (DateTime selectedDate) {
    if (focusDate?.year != selectedDate.year ||
    focusDate?.month != selectedDate.month ||
    focusDate?.day != selectedDate.day) {
    setState(() {
    focusDate = selectedDate;
    });
    }
    },

    activeColor: theme.primaryColor,
          dayProps: const EasyDayProps(
            height: 56.0,
            width: 56.0,
            dayStructure: DayStructure.dayNumDayStr,
            inactiveDayStyle: DayStyle(
              borderRadius: 48.0,
              dayNumStyle: TextStyle(
                fontSize: 18.0,
              ),
            ),
            activeDayStyle: DayStyle(
              dayNumStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FireBaseUtils.getStreamData(focusDate!),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }


              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No tasks available"));
              }
              // Map the documents to TaskModel objects
            List<TaskModel> tasksList = (snapshot.data!.docs.map((e)=>e.data()).toList()??[]).cast<TaskModel>();

              return ListView.builder(
                itemCount: tasksList.length,
                itemBuilder: (context, index) {
                   TaskModel taskModel =tasksList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration:  BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Slidable(
                        startActionPane: ActionPane(
                          extentRatio: 0.25,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              borderRadius: BorderRadius.circular(20),
                              onPressed: (context) {
                                FireBaseUtils.deleteData(taskModel);
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: TaskItemWidget(taskModel: taskModel),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}


