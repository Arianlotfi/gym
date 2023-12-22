import 'package:flutter/material.dart';
class CustomColors {
  static const kGreenColor = Color(0xFF66CAA6);
  static const kRedColor = Color(0xFFFA6060);
  static const kWhiteColor = Color(0xFFFFFFFF);
  static const kBlackColor = Color(0xFF090909);
  static const kPrimaryColor = Color(0xFF60A5FA);
  static const kLightBlackColor = Color(0xFF252525);
  static const kLightGreyColor = Color(0xFF828282);
  static const kDarkGreyColor = Color(0xFF414141);
  static const kMilkyColor = Color(0xFFFAFAFA);
  static const kLightCardColor = Color(0xFFF2F2F2);
  static const kDarkCardColor = Color(0xFF414141);
}
ThemeData themelight(String fontname){
  return ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.all(14.0),
    filled: true,
    fillColor: CustomColors.kLightCardColor,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide:BorderSide(color: CustomColors.kLightCardColor),
             ),
      focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide:BorderSide(color: CustomColors.kLightCardColor),
             ),
             errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:BorderSide(color: CustomColors.kRedColor) 
             ),
             focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:BorderSide(color: CustomColors.kRedColor) 
             ),
  ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w800,
        color: CustomColors.kBlackColor
      ),
      bodyMedium: TextStyle(
        fontSize:18.0,
        fontWeight: FontWeight.w700,
        color: CustomColors.kBlackColor, 
      ),
      bodySmall: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: CustomColors.kLightGreyColor
      )
    ),
    fontFamily: fontname,
    scaffoldBackgroundColor:CustomColors.kMilkyColor, 
    colorScheme: ColorScheme.light(
    primary: CustomColors.kPrimaryColor,
    onPrimary: CustomColors.kWhiteColor,
    secondary: CustomColors.kWhiteColor,
    onSecondary: CustomColors.kBlackColor,
    tertiary: CustomColors.kLightCardColor,
    onTertiary: CustomColors.kMilkyColor
    ),
  
  );
}
ThemeData themedark(String fontname){
  return ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(14.0),
      filled: true,
      fillColor: CustomColors.kDarkCardColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: CustomColors.kDarkCardColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: CustomColors.kDarkCardColor),
      ),
      errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:BorderSide(color: CustomColors.kRedColor) 
             ),
             focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:BorderSide(color: CustomColors.kRedColor) 
             ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w800,
        color: CustomColors.kWhiteColor,
      ),
      bodyMedium: TextStyle(
        fontSize:18.0,
        fontWeight: FontWeight.w700,
        color: CustomColors.kWhiteColor, 
      ),
      bodySmall: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: CustomColors.kLightGreyColor
      )
    ),
    fontFamily: fontname,
    scaffoldBackgroundColor: CustomColors.kLightBlackColor,
    colorScheme: ColorScheme.dark(
     primary: CustomColors.kPrimaryColor,
     onPrimary: CustomColors.kWhiteColor,
     secondary: CustomColors.kBlackColor,
     onSecondary: CustomColors.kWhiteColor,
     tertiary: CustomColors.kDarkCardColor,
     onTertiary: CustomColors.kLightBlackColor
    )
  );
}