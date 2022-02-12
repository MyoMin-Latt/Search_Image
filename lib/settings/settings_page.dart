import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_image_p1/download_image/download_image_page.dart';
import 'package:search_image_p1/language/language_page.dart';
import 'package:search_image_p1/theme/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({ Key? key }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool sw = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('setting')),
        
      ),
      body: Column(
        children: [
          Consumer(
            builder: (context, ThemeProvider themeProvider, child ){
              return ListTile(
              leading: Icon(Icons.brightness_2),
              title: Text(tr('night_mode')),
              trailing: Switch(
                    value: themeProvider.themeM != ThemeMode.light, 
                    onChanged: (change){
                      if(change){
                        themeProvider.changeToDark();
                        // print(change);
                      }
                      else{
                        themeProvider.changeToLight();
                        // print(change);
                      } 
                    }
                  ), 
          
            );
            }
             
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text(tr('download_image')),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context){
                    return DownloadImagePage();
                  }
                )
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text(tr('language')),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return LanguagePage();
                  }
                )
              ).then((value) {
                setState(() {
                  
                });
              });
            },
          )
        ],
      ),
    );
  }
}



