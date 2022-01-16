import 'dart:async';
import 'dart:io';

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
        title: Text('Download Image'),
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
                print(downloadImageList[index]);
                // return Card(
                //   child: Image.file(downloadImageList[index]),
                // );
                return Text('Download Image');// this is error
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