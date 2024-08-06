import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app_color.dart';
import 'package:todoapp/home/firebase_utils.dart';
import 'package:todoapp/home/model/task.dart';
import 'package:todoapp/home/task_list/edit_task.dart';
import 'package:todoapp/providers/app_config_provider.dart';
class TaskListItems extends StatefulWidget {
  Task task ;
  TaskListItems({required this.task});

  @override
  State<TaskListItems> createState() => _TaskListItemsState();
}

class _TaskListItemsState extends State<TaskListItems> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: Slidable(
        endActionPane:
        ActionPane(
          motion: ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              onPressed: (context){
                /// Edit Task
                Navigator.pushNamed(context, EditTask.routeName);
              },
              backgroundColor: Color(0xDA1BB6A9),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'EDIT',
            ),
          ],

        ),
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),
          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              onPressed: (context){
                /// Delete Task
                FirebaseUtils.deleteTaskFromFireStore(widget.task).timeout(
                  Duration(microseconds : 1),
                  onTimeout: (){
                    print('task deleted successfully');
                    provider.getAllTasksFromFireStore();
                },
                );
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:provider.isDarkTheme()?
                AppColor.backDarkColor:
            AppColor.whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                color: isDone  ? AppColor.greenColor
                    : AppColor.primaryColor
                ,
                height: MediaQuery.of(context).size.height * 0.0645161290322581,
                width: 4,
              ),
              SizedBox(width: 5,),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(widget.task.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isDone ?AppColor.greenColor:
                    AppColor.primaryColor
                      ,fontSize: 20
                  ),),
                  Text(widget.task.description,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: isDone ? AppColor.greenColor :
                    AppColor.primaryColor
                  ),),
                ],
              )),
              isDone ? Text('Done!',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppColor.greenColor
              ),) :
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor
              ),
                onPressed: () {
                setState(() {
                  isDone = true;
                });
                },
                child: Icon(
                  Icons.check,
                  color: AppColor.whiteColor,
                    size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }}
