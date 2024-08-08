import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/app_color.dart';
class MyThemeData{
  // light theme and dark theme
  static final themeDataLight = ThemeData(
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColor.whiteColor
    ),
    primaryColor: AppColor.primaryColor,
    scaffoldBackgroundColor: AppColor.backgroundLightColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.primaryColor,
      elevation: 0
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColor.primaryColor,
      showUnselectedLabels: false,
      unselectedItemColor: AppColor.grayColor,
        backgroundColor: Colors.transparent,
      elevation: 0
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColor.whiteColor,
          width: 4
        )
      )
      // RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(30),
      //   side: BorderSide(
      //       color:AppColor.whiteColor,
      //     width: 4
      //   )
      // )
    ),
    textTheme: TextTheme(
      titleSmall: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColor.whiteColor
      ),
      titleMedium: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight:FontWeight.bold,
          color: AppColor.blackColor
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.bold,
            color: Color(0x9c5b5858),
          ),
          bodyLarge: GoogleFonts.poppins(
              fontSize: 24,
              color: Color(0xff303030),
              fontWeight: FontWeight.bold),
          bodyMedium:
              GoogleFonts.poppins(fontSize: 14, color: AppColor.textFormDark)));
  static final themeDataDark = ThemeData(
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColor.backDarkColor
    ),
    primaryColor: AppColor.primaryColor,
    scaffoldBackgroundColor: AppColor.backgroundDarkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.primaryColor,
      elevation: 0
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColor.primaryColor,
      showUnselectedLabels: false,
      unselectedItemColor: AppColor.whiteColor,
        backgroundColor: Colors.transparent,
      elevation: 0
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColor.backDarkColor,
          width: 4
        )
      )
      // RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(30),
      //   side: BorderSide(
      //       color:AppColor.whiteColor,
      //     width: 4
      //   )
      // )
    ),
    textTheme: TextTheme(
      titleSmall: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColor.whiteColor
      ),
      titleMedium: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight:FontWeight.bold,
          color: AppColor.blackColor
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0x9c5b5858)
      )
    )
  );
}