
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_image_p1/home/home_page.dart';
import 'package:search_image_p1/theme/theme_provider.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (BuildContext context){
        return ThemeProvider();
      },      
      child:Consumer<ThemeProvider>(
        builder: (context, ThemeProvider themeProvider, child ) {
          return MaterialApp(
            home: HomePage(),
            themeMode: themeProvider.themeM,
            theme: ThemeData(              
              brightness: Brightness.light,
              primaryColor: Colors.orange,
              primarySwatch: Colors.green,              
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.grey,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.white
              )
              // primarySwatch: Colors.amber,
            ),
          );
        }
      ),
    );
  }
}

