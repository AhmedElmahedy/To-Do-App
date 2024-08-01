import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/app_color.dart';
import 'package:todoapp/providers/app_config_provider.dart';
class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
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
              /// Change Language English
              provider.changeLanguage("en");
            },
            child:provider.appLanguage == "en" ?
                selectedItemWidget(AppLocalizations.of(context)!.english):
                unSelectedItemWidget(AppLocalizations.of(context)!.english)
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: (){
              /// Change Language Arabic
              provider.changeLanguage('ar');
            },
            child:provider.appLanguage == "ar" ? 
                selectedItemWidget(AppLocalizations.of(context)!.arabic) :
                unSelectedItemWidget(AppLocalizations.of(context)!.arabic)
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
