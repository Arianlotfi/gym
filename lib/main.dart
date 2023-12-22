import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_badanvv/screens/root/rootscreen.dart';
import 'package:project_badanvv/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/users.dart';

late SharedPreferences sharedPreferences;
ValueNotifier<bool> isthemedark = ValueNotifier(false);

const String userboxname = 'userbox';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  isthemedark.value = sharedPreferences.getBool('isdark')??false;
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
 await Hive.openBox<User>('userbox');

  runApp(
    EasyLocalization(
      child:  MyApp(),
       supportedLocales: [
        Locale('fa'),
        Locale('en'),
       ],
        path: 'assets/translations',
        startLocale: Locale('fa'),)
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
    valueListenable: isthemedark,
     builder: (context, value, child) {
       return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme:themelight(context.locale == Locale('fa')?'Arianfonts2':'Arianfonts1') ,
      darkTheme: themedark(context.locale == Locale('fa')?'Arianfonts2':'Arianfonts1'),
      themeMode: isthemedark.value?ThemeMode.dark:ThemeMode.light,
      home: rootscreen(),
    );
     },);
  }
}
