import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:search_image_p1/search/search_page.dart';
import 'package:search_image_p1/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List pageList = [SearchPage(), SettingsPage()];
  int botCurIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[botCurIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: botCurIndex,
        onTap: (clickIndex){
          setState(() {
            botCurIndex = clickIndex;
          });
          print(botCurIndex);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: tr('home')),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: tr('setting')),
        ]
      ),
    );
  }
}