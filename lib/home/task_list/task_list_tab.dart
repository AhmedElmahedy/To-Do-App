import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app_color.dart';
import 'package:todoapp/home/task_list/task_list_items.dart';
import 'package:todoapp/providers/app_config_provider.dart';
import 'package:todoapp/providers/user_provider.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    if(provider.tasksList.isEmpty) {
      provider.getAllTasksFromFireStore(userProvider.currentUser!.id!);
    }
    return Column(
      children: [
        EasyDateTimeLine(
          locale: provider.appLanguage,
          initialDate: provider.selectDate,
          onDateChange: (selectedDate) {
            ///`selectedDate` the new date selected.
            provider.changeSelectDate(
                selectedDate, userProvider.currentUser!.id!);
          },
          headerProps:  EasyHeaderProps(
            monthStyle: TextStyle(
            color: provider.isDarkTheme()?
                AppColor.whiteColor:
                AppColor.backgroundDarkColor
          ),
            selectedDateStyle:TextStyle(
              color: provider.isDarkTheme()?
                  AppColor.whiteColor:
                  AppColor.backgroundDarkColor
            ) ,
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          dayProps:  EasyDayProps(
            dayStructure: DayStructure.dayStrDayNumMonth,
            inactiveDayStyle: DayStyle(
              dayNumStyle: TextStyle(
                color: provider.isDarkTheme()?
                    AppColor.grayColor:
                    AppColor.backgroundDarkColor
              )
            ),
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff045656),
                    Color(0xda0fb6a4),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context , index){
                return TaskListItems(
                  task:provider.tasksList[index],);
              },
              itemCount: provider.tasksList.length,
          ),
        )
      ],
    );
  }
}
