import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({ Key? key }) : super(key: key);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('choose_language')),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Text(tr('english')),
            trailing: EasyLocalization.of(context)!.locale == Locale('en', 'US')? Icon(Icons.done): Text('Select'),
            onTap: (){
              EasyLocalization.of(context)!.setLocale(Locale('en', 'US'));
            },
          ),
          ListTile(
            onTap: (){
               EasyLocalization.of(context)!.setLocale(Locale('my', 'MM'));
            },
            leading: Text(tr('myanmar')),
            trailing: EasyLocalization.of(context)!.locale == Locale('my', 'MM')? Icon(Icons.done): Text('Select'),
            
          )
        ],
      ),
    );
  }
}