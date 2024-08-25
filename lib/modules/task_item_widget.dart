import 'package:flutter/material.dart';
import 'package:todo_app/firebase/firebaseUtils.dart';
import 'package:todo_app/firebase/task_model.dart';
import 'package:intl/intl.dart';


class TaskItemWidget extends StatefulWidget {
  final TaskModel taskModel;
  const TaskItemWidget({super.key, required this.taskModel});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final TaskModel taskModel;
    String formattedDate = DateFormat.yMMMd().format(widget.taskModel.dateTime);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Container(
              height: 50,
              width: 6,
              decoration: BoxDecoration(
                color:widget.taskModel.isDone?const
                Color(0xFF61E757) : theme.primaryColor,
                borderRadius: BorderRadius.circular(20)
              ),
            ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.taskModel.title,style: theme.textTheme.displayLarge?.
                  copyWith(color:widget.taskModel.isDone?const
                  Color(0xFF61E757) :theme.primaryColor),),
                  Text(widget.taskModel.description,style: theme.textTheme.displayMedium?.
                  copyWith(fontWeight: FontWeight.w100,color:widget.taskModel.isDone?
                  const Color(0xFF61E757) : theme.primaryColor),),
                  Row(
                    children: [
                      const Icon(Icons.alarm,size: 15,),
                      Text(formattedDate,style: theme.textTheme.displaySmall,)
                    ],
                  ),
                ],
              ),
              Container(
                width: 70,
                height: 50,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: InkWell(
                  onTap: ()
                    {
                      FireBaseUtils.updateData(widget.taskModel);
                    },
                    child: widget.taskModel.isDone?
                    const Text("Done",style:TextStyle(color:Color(0xFF61E757) ),) :
                    const Icon(Icons.done,color: Colors.white,)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
