import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/app_config_provider.dart';

import '../../app_color.dart';
class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: (){
              ///change Theme light
              provider.changeTheme(ThemeMode.light);
            },
            child: provider.appTheme == ThemeMode.light ?
            selectedItemWidget(AppLocalizations.of(context)!.light):
            unSelectedItemWidget(AppLocalizations.of(context)!.light)
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: (){
              /// change Theme dark
              provider.changeTheme(ThemeMode.dark);
            },
            child: provider.appTheme == ThemeMode.dark ?
            selectedItemWidget(AppLocalizations.of(context)!.dark):
            unSelectedItemWidget(AppLocalizations.of(context)!.dark)
          ),
        ],
      ),
    );
  }

  Widget selectedItemWidget(String text){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 25, color: AppColor.primaryColor
          ),),
        Icon(Icons.check,size: 35,color: AppColor.primaryColor,)
      ],
    );
  }

  Widget unSelectedItemWidget(String text){
    return Text(text,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 25
      ),
    );
  }
}
