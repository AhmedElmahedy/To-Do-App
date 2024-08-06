import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app_color.dart';
import 'package:todoapp/home/settings/language_Bottom_sheet.dart';
import 'package:todoapp/home/settings/theme_bottom_sheet.dart';
import 'package:todoapp/providers/app_config_provider.dart';
class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context)!.language,
              style: provider.isDarkTheme()?
              Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColor.whiteColor):
                  Theme.of(context).textTheme.titleMedium
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          InkWell(
            onTap: (){
              showLanguageBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: provider.isDarkTheme()?
                  AppColor.backDarkColor:
                  AppColor.whiteColor,
                border: Border.all(
                  color: AppColor.primaryColor
                )
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.appLanguage == "en"?
                      AppLocalizations.of(context)!.english :
                      AppLocalizations.of(context)!.arabic,
                      style:Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 14,
                        color: AppColor.primaryColor
                      )
                      // Theme.of(context).textTheme.titleMedium
                  ),
                  Icon(Icons.keyboard_arrow_down,
                  color: AppColor.primaryColor,)
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Text(AppLocalizations.of(context)!.mode,
              style: provider.isDarkTheme()?
              Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColor.whiteColor
              ):
                  Theme.of(context).textTheme.titleMedium
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          InkWell(
            onTap: (){
              showThemeBottomSheet();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: provider.isDarkTheme()?
                      AppColor.backDarkColor:
                  AppColor.whiteColor,
                  border: Border.all(color: AppColor.primaryColor,width: 1)
              ),
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provider.isDarkTheme()?
                    AppLocalizations.of(context)!.dark:
                    AppLocalizations.of(context)!.light,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 14,
                      color: AppColor.primaryColor
                    ),
                  ),
                  Icon(
                      Icons.keyboard_arrow_down,
                  color:AppColor.primaryColor ,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => LanguageBottomSheet()
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => ThemeBottomSheet()
    );
  }
}
