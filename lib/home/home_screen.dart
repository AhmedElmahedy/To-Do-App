import 'package:flutter/material.dart';
import 'package:todoapp/app_color.dart';
import 'package:todoapp/home/settings/settings_tab.dart';
import 'package:todoapp/home/task_list/add_task_bottom_sheet.dart';
import 'package:todoapp/home/task_list/task_list_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(AppLocalizations.of(context)!.title,
          // AppLocalizations.of(context)!.title,
          style: Theme.of(context).textTheme.titleSmall,
        ),),
      bottomNavigationBar: BottomAppBar(
         height: MediaQuery.of(context).size.height*0.1096938775510204,
        shape: CircularNotchedRectangle(),
        notchMargin: 15,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index){
            selectedIndex = index;
            setState(() {});},
          items:  [
            BottomNavigationBarItem(
              icon: const Icon(Icons.list),
            label: AppLocalizations.of(context)!.list_task),
             BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
            label: AppLocalizations.of(context)!.setting),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addTaskBottomSheet();
        },
        child:  Icon(Icons.add,
          size: 35,
          color:AppColor.whiteColor,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          Container(
            color: AppColor.primaryColor,
            width: double.infinity,
            height: MediaQuery.of(context).size.width * 0.1847133757961783,
          ),
          Expanded(
              child: selectedIndex == 0 ? TaskListTab()
              : SettingsTab())
         ],
      ),
    );
  }


void addTaskBottomSheet() {
  showModalBottomSheet(
      context: context,
      builder: (context) => AddTaskBottomSheet()
  );
}
}