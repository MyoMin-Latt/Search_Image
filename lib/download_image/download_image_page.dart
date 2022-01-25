import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:search_image_p1/download_image/download_image_bloc.dart';
import 'package:search_image_p1/response_ob/response_ob.dart';

class DownloadImagePage extends StatefulWidget {
  const DownloadImagePage({ Key? key }) : super(key: key);

  @override
  _DownloadImagePageState createState() => _DownloadImagePageState();
}

class _DownloadImagePageState extends State<DownloadImagePage> {
  final DownloadImageBloc _downloadImageBloc = DownloadImageBloc();
  @override
  void initState() {
    _downloadImageBloc.getDownloadImage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('download_image')),
      ),
      body: StreamBuilder<ResponseOb>(
        stream: _downloadImageBloc.streamImage(),
        initialData: ResponseOb(msgState: MsgState.loading),
        builder: (BuildContext context, AsyncSnapshot<ResponseOb> snapshot){
          ResponseOb? responseOb = snapshot.data;
          if(responseOb!.msgState == MsgState.data){
            List<FileSystemEntity> downloadImageList = responseOb.data;
            return ListView.builder(
              itemCount: downloadImageList.length,
              itemBuilder: (BuildContext context, int index){
                // print(downloadImageList[index]);
                return Stack(
                  children: [
                    Card(
                      child: Image.file(File(downloadImageList[index].path)),
                    ),
                    Positioned(
                      child: IconButton(                        
                        onPressed: (){
                          _downloadImageBloc.delete(File(downloadImageList[index].path));
                        }, 
                        icon: Icon(Icons.delete, color: Colors.red,),), 
                      right: 0, bottom: 0,
                      )
                  ],
                );
                // return Text('Download Image');// this is error
              }
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
  @override
  void dispose() {
    _downloadImageBloc.dispose();
    super.dispose();
  }
}