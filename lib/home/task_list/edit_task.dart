import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app_color.dart';
import 'package:todoapp/providers/app_config_provider.dart';

class EditTask extends StatefulWidget {
  static const String routeName = "Edit";
  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.title,
          style: provider.isDarkTheme()
              ? Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: AppColor.backgroundDarkColor)
              : Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            color: AppColor.primaryColor,
            width: double.infinity,
            height: MediaQuery.of(context).size.width * 0.1847133757961783,
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.03,
                    horizontal: MediaQuery.of(context).size.width * 0.03),
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width * 0.8705024311183144,
                height: MediaQuery.of(context).size.width * 1.652840909090909,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(AppLocalizations.of(context)!.edit_task_title,
                          style: provider.isDarkTheme()
                              ? Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: AppColor.whiteColor)
                              : Theme.of(context).textTheme.titleMedium),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.edit_task,
                          hintStyle: TextStyle(
                              color: provider.isDarkTheme()
                                  ? AppColor.whiteColor
                                  : AppColor.grayColor)),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextField(
                      decoration: InputDecoration(
              
                          hintText:
                              AppLocalizations.of(context)!.edit_description,
                          hintStyle: TextStyle(
                              color: provider.isDarkTheme()
                                  ? AppColor.whiteColor
                                  : AppColor.grayColor),),
                      maxLines: 4,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      AppLocalizations.of(context)!.select,
                      style: provider.isDarkTheme()
                          ? Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: AppColor.whiteColor)
                          : Theme.of(context).textTheme.titleLarge,
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
                       EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.06,
                        vertical: MediaQuery.of(context).size.height * 0.1
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor),
                        onPressed: () {
                          /// Save Edit Task

                        },
                        child: Text(
                          AppLocalizations.of(context)!.save_changes,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
          )
        ],
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
}
