import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String tittle = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.add_new_task,
                style: Theme.of(context).textTheme.titleMedium),
            Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
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
                            hintText:AppLocalizations.of(context)!.enter_task),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
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
                        ),
                        maxLines: 4,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.select,
                      style: Theme.of(context).textTheme.titleLarge,
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
                          style: Theme.of(context).textTheme.bodySmall,
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

    }
  }
}
// ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}
