import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: (){

            },
            child: Text(AppLocalizations.of(context)!.light,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 25
              ),),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: (){

            },
            child: Text(AppLocalizations.of(context)!.dark,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 25
              ),),
          ),
        ],
      ),
    );
  }
}
