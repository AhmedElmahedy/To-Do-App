import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app_color.dart';
import 'package:todoapp/home/firebase_utils.dart';
import 'package:todoapp/home/model/task.dart';
import 'package:todoapp/providers/app_config_provider.dart';
class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String tittle = '';
  String description = '';
  late AppConfigProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.add_new_task,
                style: provider.isDarkTheme()?
                    Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColor.whiteColor):
                Theme.of(context).textTheme.titleMedium),
            Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: provider.isDarkTheme()
                                ? AppColor.whiteColor
                                : AppColor.backDarkColor),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!.please_enter_your_task;
                          }
                          return null;
                        },
                        onChanged: (text){
                          tittle = text;
                        },
                        decoration: InputDecoration(
                            hintText:AppLocalizations.of(context)!.enter_task,
                          hintStyle: TextStyle(
                              color:provider.isDarkTheme()?
                                AppColor.textFormDark: AppColor.grayColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: provider.isDarkTheme()
                                ? AppColor.whiteColor
                                : AppColor.backDarkColor),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!.please_enter_your_description;
                          }
                          return null;
                        },
                        onChanged: (text){
                          description = text;
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.enter_description,
                          hintStyle: TextStyle(
                            color: provider.isDarkTheme()?
                                AppColor.textFormDark:
                                AppColor.grayColor
                          )
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.select,
                      style: provider.isDarkTheme()?
                      Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColor.whiteColor
                      )
                      :
                      Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () {
                          showCalendar();
                        },
                        child: Text(
                          '${DateFormat.yMMMMd().format(selectedDate)}',
                          textAlign: TextAlign.center,
                          style: provider.isDarkTheme()?
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: AppColor.whiteColor
                              ):
                          Theme.of(context).textTheme.bodySmall,
                        )),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 60, left: 30, right: 30),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor),
                        onPressed: () {
                          addTask();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.add,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate = chosenDate ?? selectedDate;
    setState(() {});
  }

  void addTask() {
    if(formKey.currentState?.validate() == true){
     /// Add task
      Task task = Task(
          title: tittle,
          description: description,
          dateTime: selectedDate);
      FirebaseUtils.addTaskToFireStore(task).timeout(
        Duration(seconds: 1),onTimeout: (){
          print("Task added successfully");
          provider.getAllTasksFromFireStore();
          Navigator.pop(context);
      }
      );
    }
  }
}
// ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}
