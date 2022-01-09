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
        title: Text('Choose Language'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Text('English'),
          ),
          ListTile(
            leading: Text('Myanmar'),
          )
        ],
      ),
    );
  }
}