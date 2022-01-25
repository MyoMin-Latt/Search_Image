// provier/ sharepreference/ bloc with stream/ smartrefresher/ 
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_image_p1/home/home_page.dart';
import 'package:search_image_p1/theme/theme_provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('my', 'MM')],
      path: 'assets/translations', // <-- change the path of the translation files 
      fallbackLocale: Locale('en', 'US'),
      saveLocale: true, 
      child: ChangeNotifierProvider<ThemeProvider>(
      create: (BuildContext context){
        return ThemeProvider();
      },
      child: ForThemeData()
    ),
    ),);
}

class ForThemeData extends StatelessWidget {
  const ForThemeData({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    provider.checkTheme();
    return Consumer<ThemeProvider>(
        builder: (context, ThemeProvider themeProvider, child ) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: HomePage(),
            themeMode: themeProvider.themeM,
            theme: ThemeData(              
              brightness: Brightness.light,
              primaryColor: Colors.green,
              primarySwatch: Colors.green, 
              fontFamily: 'pyidaungsu'     
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.grey,
              fontFamily: 'pyidaungsu',
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.white
              )
              // primarySwatch: Colors.amber,
            ),
          );
        }
      );
  }
}

