import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TaskListItems extends StatelessWidget {
  const TaskListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Slidable(
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
              onPressed: (context){},
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
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                color: AppColor.primaryColor,
                height: MediaQuery.of(context).size.height * 0.0645161290322581,
                width: 4,
              ),
              SizedBox(width: 5,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppLocalizations.of(context)!.task,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColor.primaryColor,fontSize: 20
                  ),),
                  Text(AppLocalizations.of(context)!.description,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColor.primaryColor
                  ),),
                ],
              )),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor
              ),
                onPressed: () {},
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
  }
}
