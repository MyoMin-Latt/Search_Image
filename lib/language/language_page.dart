import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({Key? key}) : super(key: key);

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
            trailing:
                EasyLocalization.of(context)!.locale == const Locale('en', 'US')
                    ? const Icon(Icons.done)
                    : const Text('Select'),
            onTap: () {
              EasyLocalization.of(context)!.setLocale(const Locale('en', 'US'));
            },
          ),
          ListTile(
            onTap: () {
              EasyLocalization.of(context)!.setLocale(const Locale('my', 'MM'));
            },
            leading: Text(tr('myanmar')),
            trailing:
                EasyLocalization.of(context)!.locale == const Locale('my', 'MM')
                    ? const Icon(Icons.done)
                    : const Text('Select'),
          )
        ],
      ),
    );
  }
}
